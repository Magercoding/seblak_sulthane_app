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
          // Handle jika response adalah list (multiple shifts)
          final listData = response.getListData();
          if (listData != null) {
            emit(_ShiftsLoaded(listData, activeShiftId: response.activeShift));
          } else {
            // Handle jika response adalah single data (backward compatibility)
            final singleData = response.getSingleData();
            if (singleData != null) {
              emit(_Loaded(singleData));
            } else {
              emit(_Error('Data tidak ditemukan'));
            }
          }
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
          final data = response.getSingleData();
          if (data != null) {
            emit(_OpeningBalanceSet(data));
          } else {
            emit(_Error('Data tidak ditemukan'));
          }
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
          final data = response.getSingleData();
          if (data != null) {
            emit(_ExpenseAdded(data));
          } else {
            emit(_Error('Data tidak ditemukan'));
          }
        },
      );
    });

    on<_OpenShift>((event, emit) async {
      emit(const _Loading());

      final result = await datasource.openShift(
        event.date,
        event.openingBalance,
        shiftName: event.shiftName,
      );

      result.fold(
        (error) => emit(_Error(error)),
        (response) {
          final data = response.getSingleData();
          if (data != null) {
            emit(_ShiftOpened(data));
          } else {
            emit(_Error('Data tidak ditemukan'));
          }
        },
      );
    });

    on<_CloseShift>((event, emit) async {
      emit(const _Loading());

      final result = await datasource.closeShift(event.shiftId);

      result.fold(
        (error) => emit(_Error(error)),
        (response) {
          final data = response.getSingleData();
          if (data != null) {
            emit(_ShiftClosed(data));
          } else {
            emit(_Error('Data tidak ditemukan'));
          }
        },
      );
    });

    on<_FetchActiveShifts>((event, emit) async {
      emit(const _Loading());

      final result = await datasource.getActiveShifts();

      result.fold(
        (error) => emit(_Error(error)),
        (response) {
          final listData = response.getListData();
          if (listData != null) {
            emit(_ShiftsLoaded(listData));
          } else {
            emit(_ShiftsLoaded([]));
          }
        },
      );
    });

    on<_FetchShiftById>((event, emit) async {
      emit(const _Loading());

      final result = await datasource.fetchShiftById(event.shiftId);

      result.fold(
        (error) => emit(_Error(error)),
        (response) {
          final data = response.getSingleData();
          if (data != null) {
            emit(_Loaded(data));
          } else {
            emit(_Error('Shift tidak ditemukan'));
          }
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
