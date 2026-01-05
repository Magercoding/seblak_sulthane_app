part of 'daily_cash_bloc.dart';

@freezed
class DailyCashState with _$DailyCashState {
  const factory DailyCashState.initial() = _Initial;
  const factory DailyCashState.loading() = _Loading;
  const factory DailyCashState.loaded(DailyCashModel dailyCash) = _Loaded;
  const factory DailyCashState.error(String message) = _Error;
  const factory DailyCashState.openingBalanceSet(DailyCashModel dailyCash) =
      _OpeningBalanceSet;
  const factory DailyCashState.expenseAdded(DailyCashModel dailyCash) =
      _ExpenseAdded;

  const factory DailyCashState.shiftOpened(DailyCashModel dailyCash) =
      _ShiftOpened;

  const factory DailyCashState.shiftClosed(DailyCashModel dailyCash) =
      _ShiftClosed;

  const factory DailyCashState.shiftsLoaded(
    List<DailyCashModel> shifts, {
    int? activeShiftId,
  }) = _ShiftsLoaded;
}
