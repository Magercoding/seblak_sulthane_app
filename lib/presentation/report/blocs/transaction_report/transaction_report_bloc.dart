import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seblak_sulthane_app/data/datasources/auth_remote_datasource.dart';
import 'package:seblak_sulthane_app/data/datasources/order_remote_datasource.dart';
import 'package:seblak_sulthane_app/data/models/response/order_response_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'transaction_report_event.dart';
part 'transaction_report_state.dart';
part 'transaction_report_bloc.freezed.dart';

class TransactionReportBloc
    extends Bloc<TransactionReportEvent, TransactionReportState> {
  final OrderRemoteDatasource datasource;

  TransactionReportBloc(this.datasource) : super(const _Initial()) {
    on<_GetReport>((event, emit) async {
      emit(const _Loading());

      final result = await datasource.getOrderByRangeDate(
        event.startDate,
        event.endDate,
        event.outletId,
      );

      await result.fold<Future<void>>(
        (l) async => emit(_Error(l)),
        (r) async {
          if (r.data == null || r.data!.isEmpty) {
            emit(const _Error("No transaction data for this outlet"));
            return;
          }

          final profileResult = await AuthRemoteDatasource().getProfile();

          profileResult.fold(
            (error) => emit(_Error(error)),
            (user) {
              final cashierOrders = r.data!
                  .where(
                    (order) =>
                        order.idKasir == user.id ||
                        (order.namaKasir?.toLowerCase() ==
                            user.name.toLowerCase()),
                  )
                  .toList();

              if (cashierOrders.isEmpty) {
                emit(const _Error(
                    "No transaction data for the logged-in cashier"));
                return;
              }

              emit(_Loaded(cashierOrders));
            },
          );
        },
      );
    });
  }
}
