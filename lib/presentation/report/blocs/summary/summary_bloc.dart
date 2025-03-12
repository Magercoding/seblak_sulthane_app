import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seblak_sulthane_app/data/datasources/order_remote_datasource.dart';
import 'package:seblak_sulthane_app/data/models/response/summary_response_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'summary_event.dart';
part 'summary_state.dart';
part 'summary_bloc.freezed.dart';

class SummaryBloc extends Bloc<SummaryEvent, SummaryState> {
  final OrderRemoteDatasource datasource;

  SummaryBloc(this.datasource) : super(const _Initial()) {
    on<_GetSummary>((event, emit) async {
      emit(const _Loading());

      final result = await datasource.getSummaryByRangeDate(
        event.startDate,
        event.endDate,
        event.outletId,
      );

      result.fold(
        (l) => emit(_Error(l)),
        (r) {
          if (r.data != null) {
            emit(_Success(r.data! as EnhancedSummaryData));
          } else {
            emit(const _Error("No summary data for this outlet"));
          }
        },
      );
    });
  }
}