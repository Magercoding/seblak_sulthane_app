import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:seblak_sulthane_app/data/datasources/member_local_datasource.dart';
import 'package:seblak_sulthane_app/data/datasources/member_remote_datasource.dart';
import 'package:seblak_sulthane_app/data/models/response/member_response_model.dart';

class MemberRepository {
  final MemberRemoteDatasource remoteDatasource;
  final MemberLocalDatasource localDatasource;
  final Connectivity connectivity;

  MemberRepository({
    required this.remoteDatasource,
    required this.localDatasource,
    required this.connectivity,
  });

  Future<bool> isConnected() async {
    final result = await connectivity.checkConnectivity();
    return result != ConnectivityResult.none;
  }

  Future<Either<String, MemberResponseModel>> getMembers() async {
    try {
      // Check if online
      if (await isConnected()) {
        log('Online mode: Fetching members from remote');
        // Try to fetch from remote
        final remoteResult = await remoteDatasource.getMembers();
        
        return remoteResult.fold(
          (error) async {
            // If remote fails, get from local
            log('Remote fetch failed: $error, falling back to local data');
            final localMembers = await localDatasource.getAllMembers();
            return Right(MemberResponseModel(
              status: 'success',
              data: localMembers,
            ));
          },
          (response) async {
            // Cache the data locally
            if (response.data.isNotEmpty) {
              log('Caching ${response.data.length} members locally');
              await localDatasource.deleteAllMembers();
              await localDatasource.insertMembers(response.data);
            }
            return Right(response);
          },
        );
      } else {
        // Offline mode - get from local
        log('Offline mode: Fetching members from local database');
        final localMembers = await localDatasource.getAllMembers();
        
        if (localMembers.isEmpty) {
          return const Left('No members available offline');
        }
        
        return Right(MemberResponseModel(
          status: 'success',
          data: localMembers,
        ));
      }
    } catch (e) {
      log('Error in getMembers: $e');
      return Left('Error: $e');
    }
  }

  Future<Either<String, MemberResponseModel>> searchMembers(String query) async {
    try {
      final members = await localDatasource.searchMembersByName(query);
      if (members.isEmpty) {
        return const Left('No members found matching your search');
      }
      return Right(MemberResponseModel(
        status: 'success',
        data: members,
      ));
    } catch (e) {
      log('Error searching members: $e');
      return Left('Error: $e');
    }
  }

  Future<Either<String, MemberResponseModel>> getMemberByPhone(String phone) async {
    try {
      final member = await localDatasource.getMemberByPhone(phone);
      if (member == null) {
        return const Left('Member not found');
      }
      return Right(MemberResponseModel(
        status: 'success',
        data: [member],
      ));
    } catch (e) {
      log('Error getting member by phone: $e');
      return Left('Error: $e');
    }
  }

  Future<Either<String, MemberResponseModel>> addMember({
    required String name,
    required String phone,
  }) async {
    try {
      if (await isConnected()) {
        // Online - add to remote first
        final result = await remoteDatasource.addMember(
          name: name,
          phone: phone,
        );
        
        return result.fold(
          (error) => Left(error),
          (response) async {
            // Cache the new data locally if the remote was successful
            if (response.data.isNotEmpty) {
              for (var member in response.data) {
                await localDatasource.insertMember(member);
              }
            }
            return Right(response);
          },
        );
      } else {
        // Offline mode - not supported for adding new members
        return const Left('Cannot add members while offline');
      }
    } catch (e) {
      return Left('Error: $e');
    }
  }

  Future<Either<String, MemberResponseModel>> updateMember({
    required int id,
    required String name,
    required String phone,
  }) async {
    try {
      if (await isConnected()) {
        // Online - update remote first
        final result = await remoteDatasource.updateMember(
          id: id,
          name: name,
          phone: phone,
        );
        
        return result.fold(
          (error) => Left(error),
          (response) async {
            // Update local data if remote update was successful
            if (response.data.isNotEmpty) {
              for (var member in response.data) {
                await localDatasource.insertMember(member);
              }
            }
            return Right(response);
          },
        );
      } else {
        // Offline mode - not supported for updating members
        return const Left('Cannot update members while offline');
      }
    } catch (e) {
      return Left('Error: $e');
    }
  }

  Future<Either<String, MemberResponseModel>> deleteMember(int id) async {
    try {
      if (await isConnected()) {
        // Online - delete from remote
        final result = await remoteDatasource.deleteMember(id);
        
        return result.fold(
          (error) => Left(error),
          (response) async {
            // Also delete from local if remote delete was successful
            final db = await localDatasource.database;
            await db.delete(
              'members',
              where: 'id = ?',
              whereArgs: [id],
            );
            return Right(response);
          },
        );
      } else {
        // Offline mode - not supported for deleting members
        return const Left('Cannot delete members while offline');
      }
    } catch (e) {
      return Left('Error: $e');
    }
  }
}