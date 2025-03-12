part of 'daily_cash_bloc.dart';

@freezed
class DailyCashEvent with _$DailyCashEvent {
  const factory DailyCashEvent.started() = _Started;

  const factory DailyCashEvent.fetchDailyCash(
    String date,
  ) = _FetchDailyCash;

  const factory DailyCashEvent.setOpeningBalance(
    String date,
    int openingBalance,
  ) = _SetOpeningBalance;

  const factory DailyCashEvent.addExpense(
    String date,
    int amount,
    String note,
  ) = _AddExpense;
}
