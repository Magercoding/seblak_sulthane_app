import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seblak_sulthane_app/data/datasources/daily_cash_remote_datasource.dart';
import 'package:seblak_sulthane_app/data/models/response/daily_cash_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'daily_cash_event.dart';
part 'daily_cash_state.dart';
part 'daily_cash_bloc.freezed.dart';

class DailyCashBloc extends Bloc<DailyCashEvent, DailyCashState> {
  final DailyCashRemoteDatasource datasource;

  DailyCashBloc(this.datasource) : super(const _Initial()) {
    on<_FetchDailyCash>((event, emit) async {
      emit(const _Loading());

      final result = await datasource.getDailyCash(event.date);

      result.fold(
        (error) => emit(_Error(error)),
        (response) {
          emit(_Loaded(response.data));
                },
      );
    });

    on<_SetOpeningBalance>((event, emit) async {
      emit(const _Loading());

      final result = await datasource.setOpeningBalance(
        event.date,
        event.openingBalance,
      );

      result.fold(
        (error) => emit(_Error(error)),
        (response) {
          emit(_OpeningBalanceSet(response.data));
                },
      );
    });

    on<_AddExpense>((event, emit) async {
      emit(const _Loading());

      final result = await datasource.addExpense(
        event.date,
        event.amount,
        event.note,
      );

      result.fold(
        (error) => emit(_Error(error)),
        (response) {
          emit(_ExpenseAdded(response.data));
                },
      );
    });
  }

  // Helper methods
  String getTodayDate() {
    return datasource.getTodayDate();
  }

  String formatDate(DateTime date) {
    return datasource.formatDate(date);
  }
}
