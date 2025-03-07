import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:seblak_sulthane_app/data/datasources/discount_local_datasource.dart';
import 'package:seblak_sulthane_app/data/datasources/discount_remote_datasource.dart';
import 'package:seblak_sulthane_app/data/models/response/discount_response_model.dart';

class DiscountRepository {
  final DiscountRemoteDatasource remoteDatasource;
  final DiscountLocalDatasource localDatasource;
  final Connectivity connectivity;

  DiscountRepository({
    required this.remoteDatasource,
    required this.localDatasource,
    required this.connectivity,
  });

  Future<bool> isConnected() async {
    final result = await connectivity.checkConnectivity();
    return result != ConnectivityResult.none;
  }

  Future<Either<String, DiscountResponseModel>> getDiscounts() async {
    try {
      // Check if online
      if (await isConnected()) {
        log('Online mode: Fetching discounts from remote');
        // Try to fetch from remote
        final remoteResult = await remoteDatasource.getDiscounts();

        return remoteResult.fold(
          (error) async {
            // If remote fails, get from local
            log('Remote fetch failed: $error, falling back to local data');
            final localDiscounts = await localDatasource.getAllDiscounts();
            return Right(DiscountResponseModel(
              status: 'success',
              data: localDiscounts,
            ));
          },
          (response) async {
            // Cache the data locally
            if (response.data != null && response.data!.isNotEmpty) {
              log('Caching ${response.data!.length} discounts locally');
              await localDatasource.deleteAllDiscounts();
              await localDatasource.insertDiscounts(response.data!);
            }
            return Right(response);
          },
        );
      } else {
        // Offline mode - get from local
        log('Offline mode: Fetching discounts from local database');
        final localDiscounts = await localDatasource.getAllDiscounts();

        if (localDiscounts.isEmpty) {
          return const Left('No discounts available offline');
        }

        return Right(DiscountResponseModel(
          status: 'success',
          data: localDiscounts,
        ));
      }
    } catch (e) {
      log('Error in getDiscounts: $e');
      return Left('Error: $e');
    }
  }

  Future<Either<String, DiscountResponseModel>> addDiscount({
    required String name,
    required String description,
    required double value,
    required String category,
  }) async {
    try {
      if (await isConnected()) {
        // Online - add to remote first
        final result = await remoteDatasource.addDiscount(
          name: name,
          description: description,
          value: value,
          category: category,
        );

        return result.fold(
          (error) => Left(error),
          (response) async {
            // Cache the new data locally if the remote was successful
            if (response.data != null && response.data!.isNotEmpty) {
              for (var discount in response.data!) {
                await localDatasource.insertDiscount(discount);
              }
            }
            return Right(response);
          },
        );
      } else {
        // Offline mode - not supported for adding new discounts
        // You could implement offline queue system here if needed
        return const Left('Cannot add discounts while offline');
      }
    } catch (e) {
      return Left('Error: $e');
    }
  }

  Future<Either<String, DiscountResponseModel>> updateDiscount({
    required int id,
    required String name,
    required String description,
    required double value,
    required String category,
  }) async {
    try {
      if (await isConnected()) {
        // Online - update remote first
        final result = await remoteDatasource.updateDiscount(
          id: id,
          name: name,
          description: description,
          value: value,
          category: category,
        );

        return result.fold(
          (error) => Left(error),
          (response) async {
            // Update local data if remote update was successful
            if (response.data != null && response.data!.isNotEmpty) {
              for (var discount in response.data!) {
                await localDatasource.insertDiscount(discount);
              }
            }
            return Right(response);
          },
        );
      } else {
        // Offline mode - not supported for updating discounts
        return const Left('Cannot update discounts while offline');
      }
    } catch (e) {
      return Left('Error: $e');
    }
  }

  Future<Either<String, DiscountResponseModel>> deleteDiscount(int id) async {
    try {
      if (await isConnected()) {
        // Online - delete from remote
        final result = await remoteDatasource.deleteDiscount(id);

        return result.fold(
          (error) => Left(error),
          (response) async {
            // Also delete from local if remote delete was successful
            final db = await localDatasource.database;
            await db.delete(
              'discounts',
              where: 'id = ?',
              whereArgs: [id],
            );
            return Right(response);
          },
        );
      } else {
        // Offline mode - not supported for deleting discounts
        return const Left('Cannot delete discounts while offline');
      }
    } catch (e) {
      return Left('Error: $e');
    }
  }

  // Get discounts by category - works offline
  Future<Either<String, List<Discount>>> getDiscountsByCategory(
      String category) async {
    try {
      final discounts = await localDatasource.getDiscountsByCategory(category);
      return Right(discounts);
    } catch (e) {
      return Left('Error: $e');
    }
  }
}
