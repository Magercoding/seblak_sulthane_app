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

  Future<Either<String, DailyCashResponse>> openShift(
    String date,
    int openingBalance, {
    String? shiftName,
  }) async {
    return await _remoteDatasource.openShift(date, openingBalance,
        shiftName: shiftName);
  }

  Future<Either<String, DailyCashResponse>> closeShift(int shiftId) async {
    return await _remoteDatasource.closeShift(shiftId);
  }

  Future<Either<String, DailyCashResponse>> getActiveShifts() async {
    return await _remoteDatasource.getActiveShifts();
  }

  Future<Either<String, DailyCashResponse>> fetchShiftById(int shiftId) async {
    return await _remoteDatasource.fetchShiftById(shiftId);
  }
}