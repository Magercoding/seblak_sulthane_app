import 'package:flutter/material.dart';
import 'package:seblak_sulthane_app/core/components/components.dart';
import 'package:seblak_sulthane_app/core/constants/colors.dart';
import 'package:seblak_sulthane_app/data/datasources/auth_local_datasource.dart';
import 'package:seblak_sulthane_app/data/datasources/auth_remote_datasource.dart';
import 'package:seblak_sulthane_app/data/models/response/user_model.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  UserModel? user;
  bool isLoading = true;
  String errorMessage = '';
  bool isOffline = false;

  @override
  void initState() {
    super.initState();
    loadUserProfile();
  }

  Future<void> loadUserProfile() async {
    // Check connectivity
    final connectivityResult = await Connectivity().checkConnectivity();
    final hasConnection = connectivityResult != ConnectivityResult.none;

    if (hasConnection) {
      // Try to fetch from remote first
      await fetchRemoteUserProfile();
    } else {
      setState(() {
        isOffline = true;
      });
    }

    // Always try to load from local as fallback or if offline
    if (user == null || isOffline) {
      await fetchLocalUserProfile();
    }
  }

  Future<void> fetchRemoteUserProfile() async {
    try {
      final authRemoteDatasource = AuthRemoteDatasource();
      final result = await authRemoteDatasource.getProfile();

      result.fold(
        (error) {
          setState(() {
            errorMessage = error;
            isLoading = false;
          });
        },
        (userData) async {
          // Save the user data locally - make sure this happens
          print("Saving user to local storage: ${userData.name}");
          await saveUserLocally(userData);

          // Double-check that it was saved properly
          try {
            final authLocalDatasource = AuthLocalDataSource();
            final savedUser = await authLocalDatasource.getUserData();
            print("Verified saved user: ${savedUser.name}");
          } catch (e) {
            print("Failed to verify saved user: $e");
          }

          setState(() {
            user = userData;
            isLoading = false;
          });
        },
      );
    } catch (e) {
      setState(() {
        errorMessage = 'Failed to fetch remote profile: $e';
        isLoading = false;
      });
    }
  }

  Future<void> fetchLocalUserProfile() async {
    try {
      final authLocalDatasource = AuthLocalDataSource();
      final userData = await authLocalDatasource.getUserData();

      setState(() {
        user = userData;
        isLoading = false;
        if (isOffline && errorMessage.isEmpty) {
          errorMessage =
              'Currently in offline mode. Showing saved profile data.';
        }
      });
    } catch (e) {
      setState(() {
        if (errorMessage.isEmpty) {
          errorMessage = 'No profile data available offline.';
        }
        isLoading = false;
      });
    }
  }

  Future<void> saveUserLocally(UserModel userData) async {
    try {
      final authLocalDatasource = AuthLocalDataSource();
      print("Starting to save user data locally: ${userData.name}");
      await authLocalDatasource.saveUserData(userData);
      print("Successfully saved user data locally");
    } catch (e) {
      // Log the error but don't display to user
      print('Failed to save user data locally: $e');
      // Try to diagnose the issue
      print('User data being saved: ${userData.toJson()}');
    }
  }

  Future<void> refreshProfile() async {
    setState(() {
      isLoading = true;
      errorMessage = '';
      isOffline = false;
    });

    await loadUserProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Profile'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: refreshProfile,
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: refreshProfile,
        child: ListView(
          padding: const EdgeInsets.all(24.0),
          children: [
            if (isLoading)
              const Center(child: CircularProgressIndicator())
            else if (user == null)
              Center(child: Text(errorMessage))
            else
              Column(
                children: [
                  if (isOffline && errorMessage.isNotEmpty)
                    Container(
                      padding: const EdgeInsets.all(8),
                      margin: const EdgeInsets.only(bottom: 16),
                      decoration: BoxDecoration(
                        color: Colors.amber.shade100,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.warning_amber_rounded,
                              color: Colors.amber),
                          const SizedBox(width: 8),
                          Expanded(
                              child: Text(errorMessage,
                                  style: const TextStyle(color: Colors.amber))),
                        ],
                      ),
                    ),
                  _buildProfileCard(user!),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileCard(UserModel user) {
    return Container(
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: AppColors.card, width: 2),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Profile Information',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
          const SpaceHeight(16),
          _buildProfileItem('Name', user.name),
          _buildProfileItem('Email', user.email),
          _buildProfileItem('Role', user.role),
          _buildProfileItem('Outlet ID', user.outletId.toString()),
        ],
      ),
    );
  }

  Widget _buildProfileItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
