import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seblak_sulthane_app/presentation/setting/bloc/tax/tax_bloc.dart';

import '../../home/widgets/custom_tab_bar.dart';
import '../dialogs/form_tax_dialog.dart';
import '../models/tax_model.dart';
import '../widgets/manage_tax_card.dart';
import '../widgets/settings_title.dart';

class TaxPage extends StatefulWidget {
  const TaxPage({super.key});

  @override
  State<TaxPage> createState() => _TaxPageState();
}

class _TaxPageState extends State<TaxPage> {
  late TaxBloc _taxBloc;

  @override
  void initState() {
    super.initState();
    _taxBloc = TaxBloc()..add(const TaxEvent.started());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _taxBloc,
      child: Builder(
        builder: (context) {
          return SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SettingsTitle('Perhitungan Biaya'),
                const SizedBox(height: 24),
                BlocConsumer<TaxBloc, TaxState>(
                  listener: (context, state) {
                    state.maybeWhen(
                      error: (message) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(message)),
                        );
                      },
                      orElse: () {},
                    );
                  },
                  buildWhen: (previous, current) {
                    return current.maybeWhen(
                      loaded: (_) => true,
                      orElse: () => false,
                    );
                  },
                  builder: (context, state) {
                    return state.maybeWhen(
                      loaded: (items) => CustomTabBar(
                        key: ValueKey('tax-tabbar-${items.length}'),
                        tabTitles: const ['Layanan', 'Pajak'],
                        initialTabIndex: 0,
                        tabViews: _buildTabViews(context, items),
                      ),
                      orElse: () => const Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  List<Widget> _buildTabViews(BuildContext context, List<TaxModel> items) {
    return [
      _buildGridView(
        context,
        items.where((element) => element.type.isLayanan).toList(),
        'layanan',
      ),
      _buildGridView(
        context,
        items.where((element) => element.type.isPajak).toList(),
        'pajak',
      ),
    ];
  }

  Widget _buildGridView(
      BuildContext context, List<TaxModel> items, String type) {
    return SizedBox(
      child: GridView.builder(
        key: ValueKey('grid-$type-${items.length}'),
        shrinkWrap: true,
        itemCount: items.length,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 0.85,
          crossAxisCount: 3,
          crossAxisSpacing: 30.0,
          mainAxisSpacing: 30.0,
        ),
        itemBuilder: (context, index) {
          final item = items[index];
          return ManageTaxCard(
            key: ValueKey(
                'tax-${item.type}-${item.value}-${DateTime.now().millisecondsSinceEpoch}'),
            data: item,
            onEditTap: () => _onEditTap(context, item),
          );
        },
      ),
    );
  }

  void _onEditTap(BuildContext context, TaxModel item) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => BlocProvider.value(
        value: _taxBloc,
        child: FormTaxDialog(data: item),
      ),
    ).then((_) {
      _taxBloc.add(const TaxEvent.started());
    });
  }

  @override
  void dispose() {
    _taxBloc.close();
    super.dispose();
  }
}
