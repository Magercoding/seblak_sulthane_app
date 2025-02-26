import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seblak_sulthane_app/data/datasources/order_remote_datasource.dart';
import 'package:seblak_sulthane_app/data/models/response/order_remote_datasource.dart';
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

      result.fold(
        (l) => emit(_Error(l)),
        (r) {
          if (r.data != null && r.data!.isNotEmpty) {
            emit(_Loaded(r.data!));
          } else {
            emit(const _Error("No transaction data for this outlet"));
          }
        },
      );
    });
  }
}
