import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:seblak_sulthane_app/core/components/components.dart';
import 'package:seblak_sulthane_app/core/constants/colors.dart';
import 'package:seblak_sulthane_app/core/extensions/build_context_ext.dart';
import 'package:seblak_sulthane_app/core/extensions/int_ext.dart';
import 'package:seblak_sulthane_app/data/datasources/daily_cash_remote_datasource.dart';
import 'package:seblak_sulthane_app/data/models/response/daily_cash_model.dart';
import 'package:seblak_sulthane_app/presentation/report/blocs/daily_cash_bloc/daily_cash_bloc.dart';
import 'package:seblak_sulthane_app/presentation/setting/widgets/daily_cash_info_card.dart';
import 'package:seblak_sulthane_app/presentation/setting/widgets/daily_cash_section_widget.dart';

class DailyCashPage extends StatefulWidget {
  const DailyCashPage({Key? key}) : super(key: key);

  @override
  State<DailyCashPage> createState() => _DailyCashPageState();
}

class _DailyCashPageState extends State<DailyCashPage> {
  late DailyCashBloc _dailyCashBloc;
  String _selectedDate = '';
  final _openingBalanceController = TextEditingController();
  final _expenseAmountController = TextEditingController();
  final _expenseNoteController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _dailyCashBloc = context.read<DailyCashBloc>();
    _selectedDate = _dailyCashBloc.getTodayDate();
    _loadDailyCash();
  }

  void _loadDailyCash() {
    _dailyCashBloc.add(DailyCashEvent.fetchDailyCash(_selectedDate));
  }

  @override
  void dispose() {
    _openingBalanceController.dispose();
    _expenseAmountController.dispose();
    _expenseNoteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kelola Kas Harian'),
        centerTitle: true,
      ),
      body: BlocConsumer<DailyCashBloc, DailyCashState>(
        listener: (context, state) {
          state.maybeWhen(
            error: (message) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(message)),
              );
            },
            openingBalanceSet: (_) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Saldo awal berhasil disimpan')),
              );
              _openingBalanceController.clear();
              _loadDailyCash();
            },
            expenseAdded: (_) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    content: Text('Pengeluaran berhasil ditambahkan')),
              );
              _expenseAmountController.clear();
              _expenseNoteController.clear();
              _loadDailyCash();
            },
            orElse: () {},
          );
        },
        builder: (context, state) {
          return ListView(
            padding: const EdgeInsets.all(24.0),
            children: [
              _buildDateSelector(),
              const SpaceHeight(24),
              state.maybeWhen(
                loading: () => const Center(
                  child: Padding(
                    padding: EdgeInsets.all(24.0),
                    child: CircularProgressIndicator(),
                  ),
                ),
                loaded: (dailyCash) => DailyCashInfoCard(dailyCash: dailyCash),
                openingBalanceSet: (dailyCash) =>
                    DailyCashInfoCard(dailyCash: dailyCash),
                expenseAdded: (dailyCash) =>
                    DailyCashInfoCard(dailyCash: dailyCash),
                orElse: () => const Center(
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      'Tidak ada data kas untuk tanggal ini',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ),
              const SpaceHeight(24),
              _buildOpeningBalanceSection(),
              const SpaceHeight(24),
              _buildExpenseSection(),
            ],
          );
        },
      ),
    );
  }

  Widget _buildDateSelector() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Tanggal",
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
                const SpaceHeight(4),
                Text(
                  DateFormat('dd MMMM yyyy')
                      .format(DateFormat('yyyy-MM-dd').parse(_selectedDate)),
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          IconButton(
            icon: Icon(Icons.calendar_today, color: AppColors.primary),
            onPressed: () async {
              final DateTime? picked = await showDatePicker(
                context: context,
                initialDate: DateFormat('yyyy-MM-dd').parse(_selectedDate),
                firstDate: DateTime(2020),
                lastDate: DateTime(2030),
              );

              if (picked != null) {
                setState(() {
                  _selectedDate = _dailyCashBloc.formatDate(picked);
                  _loadDailyCash();
                });
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildOpeningBalanceSection() {
    return DailyCashSection(
      title: 'Set Saldo Awal',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: _openingBalanceController,
            decoration: const InputDecoration(
              labelText: 'Saldo Awal (Rp)',
              border: OutlineInputBorder(),
              prefixText: 'Rp ',
            ),
            keyboardType: TextInputType.number,
          ),
          const SpaceHeight(16),
          SizedBox(
            width: double.infinity,
            child: Button.filled(
              onPressed: () {
                if (_openingBalanceController.text.isNotEmpty) {
                  final amount = int.tryParse(
                          _openingBalanceController.text.replaceAll('.', '')) ??
                      0;
                  _dailyCashBloc.add(
                      DailyCashEvent.setOpeningBalance(_selectedDate, amount));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('Silakan masukkan jumlah saldo')),
                  );
                }
              },
              label: 'Simpan Saldo Awal',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExpenseSection() {
    return DailyCashSection(
      title: 'Tambah Pengeluaran',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: _expenseAmountController,
            decoration: const InputDecoration(
              labelText: 'Jumlah Pengeluaran (Rp)',
              border: OutlineInputBorder(),
              prefixText: 'Rp ',
            ),
            keyboardType: TextInputType.number,
          ),
          const SpaceHeight(16),
          TextFormField(
            controller: _expenseNoteController,
            decoration: const InputDecoration(
              labelText: 'Keterangan Pengeluaran',
              border: OutlineInputBorder(),
              hintText: 'Contoh: Pembelian tisu dan alat kebersihan',
            ),
            maxLines: 3,
          ),
          const SpaceHeight(16),
          SizedBox(
            width: double.infinity,
            child: Button.filled(
              onPressed: () {
                if (_expenseAmountController.text.isNotEmpty &&
                    _expenseNoteController.text.isNotEmpty) {
                  final amount = int.tryParse(
                          _expenseAmountController.text.replaceAll('.', '')) ??
                      0;
                  _dailyCashBloc.add(DailyCashEvent.addExpense(
                      _selectedDate, amount, _expenseNoteController.text));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text(
                            'Silakan masukkan jumlah dan keterangan pengeluaran')),
                  );
                }
              },
              label: 'Tambah Pengeluaran',
            ),
          ),
        ],
      ),
    );
  }
}
