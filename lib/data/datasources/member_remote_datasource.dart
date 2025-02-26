import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:seblak_sulthane_app/core/constants/variables.dart';
import 'package:seblak_sulthane_app/data/datasources/auth_local_datasource.dart';
import 'package:seblak_sulthane_app/data/models/response/member_response_model.dart';
import 'package:http/http.dart' as http;

class MemberRemoteDatasource {
  Future<Either<String, MemberResponseModel>> getMembers() async {
    final url = Uri.parse('${Variables.baseUrl}/api/members');
    final authData = await AuthLocalDataSource().getAuthData();

    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer ${authData.token}',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        // Parse the nested data structure from the API response
        final jsonResponse = json.decode(response.body);
        final memberList = jsonResponse['data']['data'] as List;
        
        // Create a simplified response with just the members list
        final simplifiedResponse = {
          'status': jsonResponse['status'],
          'data': memberList,
        };
        
        return Right(MemberResponseModel.fromJson(simplifiedResponse));
      } else {
        return Left('Failed to get members: ${response.statusCode}');
      }
    } catch (e) {
      return Left('Error: $e');
    }
  }

  Future<Either<String, MemberResponseModel>> addMember({
    required String name,
    required String phone,
  }) async {
    final url = Uri.parse('${Variables.baseUrl}/api/members');
    final authData = await AuthLocalDataSource().getAuthData();

    try {
      final Map<String, dynamic> body = {
        'name': name,
        'phone': phone,
      };

      final response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer ${authData.token}',
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(body),
      );

      if (response.statusCode == 201) {
        final jsonResponse = json.decode(response.body);
        final simplifiedResponse = {
          'status': jsonResponse['status'],
          'data': jsonResponse['data'],
        };
        
        return Right(MemberResponseModel.fromJson(simplifiedResponse));
      } else {
        return Left(
            'Failed to add member: ${response.statusCode} - ${response.body}');
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
    final url = Uri.parse('${Variables.baseUrl}/api/members/$id');
    final authData = await AuthLocalDataSource().getAuthData();

    try {
      final Map<String, dynamic> body = {
        'name': name,
        'phone': phone,
      };

      final response = await http.put(
        url,
        headers: {
          'Authorization': 'Bearer ${authData.token}',
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final simplifiedResponse = {
          'status': jsonResponse['status'],
          'data': jsonResponse['data'],
        };
        
        return Right(MemberResponseModel.fromJson(simplifiedResponse));
      } else {
        return Left(
            'Failed to update member: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      return Left('Error: $e');
    }
  }

  Future<Either<String, MemberResponseModel>> deleteMember(int id) async {
    final url = Uri.parse('${Variables.baseUrl}/api/members/$id');
    final authData = await AuthLocalDataSource().getAuthData();

    try {
      final response = await http.delete(
        url,
        headers: {
          'Authorization': 'Bearer ${authData.token}',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        // For delete operations, create a simplified response
        // since the API just returns a success message
        final jsonResponse = json.decode(response.body);
        final simplifiedResponse = {
          'status': jsonResponse['status'],
          'data': [], // Empty data for delete response
        };
        
        return Right(MemberResponseModel.fromJson(simplifiedResponse));
      } else {
        return Left('Failed to delete member: ${response.statusCode}');
      }
    } catch (e) {
      return Left('Error: $e');
    }
  }
}