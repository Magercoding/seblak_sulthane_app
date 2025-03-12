import 'package:dartz/dartz.dart';
import 'package:seblak_sulthane_app/data/datasources/daily_cash_remote_datasource.dart';
import 'package:seblak_sulthane_app/data/models/response/daily_cash_model.dart';

class DailyCashRepository {
  final DailyCashRemoteDatasource _remoteDatasource = DailyCashRemoteDatasource();

  Future<Either<String, DailyCashResponse>> setOpeningBalance(
    String date,
    int openingBalance,
  ) async {
    return await _remoteDatasource.setOpeningBalance(date, openingBalance);
  }

  Future<Either<String, DailyCashResponse>> addExpense(
    String date,
    int amount,
    String note,
  ) async {
    return await _remoteDatasource.addExpense(date, amount, note);
  }

  Future<Either<String, DailyCashResponse>> getDailyCash(String date) async {
    return await _remoteDatasource.getDailyCash(date);
  }
  
  // Helper methods to make date handling easier
  String formatDate(DateTime date) {
    return _remoteDatasource.formatDate(date);
  }
  
  String getTodayDate() {
    return _remoteDatasource.getTodayDate();
  }
}