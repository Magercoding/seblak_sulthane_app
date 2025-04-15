import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seblak_sulthane_app/core/components/buttons.dart';
import 'package:seblak_sulthane_app/core/components/spaces.dart';
import 'package:seblak_sulthane_app/core/constants/colors.dart';
import 'package:seblak_sulthane_app/core/extensions/build_context_ext.dart';
import 'package:seblak_sulthane_app/data/models/response/table_model.dart';
import 'package:seblak_sulthane_app/presentation/home/bloc/status_table/status_table_bloc.dart';
import 'package:seblak_sulthane_app/presentation/table/blocs/get_table/get_table_bloc.dart';

class CloseTableConfirmationDialog extends StatelessWidget {
  final TableModel table;

  const CloseTableConfirmationDialog({
    super.key,
    required this.table,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Tutup Meja ${table.tableNumber}',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: AppColors.primary,
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Apakah Anda yakin ingin menutup meja ini? Tindakan ini tidak dapat dibatalkan.',
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
      actions: [
        Button.outlined(
          onPressed: () => context.pop(),
          label: 'Batal',
        ),
        const SpaceWidth(8),
        BlocConsumer<StatusTableBloc, StatusTableState>(
          listener: (context, state) {
            state.maybeWhen(
              orElse: () {},
              success: () {
                context
                    .read<GetTableBloc>()
                    .add(const GetTableEvent.getTables());

                context.pop();
              },
            );
          },
          builder: (context, state) {
            return Button.filled(
              color: AppColors.red,
              onPressed: () {
                final newTableStatus = TableModel(
                  id: table.id,
                  tableNumber: table.tableNumber,
                  status: 'available',
                  paymentAmount: 0,
                  orderId: 0,
                  startTime: DateTime.now().toIso8601String(),
                );

                context.read<StatusTableBloc>().add(
                      StatusTableEvent.statusTabel(newTableStatus),
                    );
              },
              label: 'Tutup Meja',
            );
          },
        ),
      ],
    );
  }
}
