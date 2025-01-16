import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants/colors.dart';
import '../../../data/datasources/auth_local_datasource.dart';
import '../../auth/bloc/logout/logout_bloc.dart';
import '../../auth/login_page.dart';

class LogoutPage extends StatefulWidget {
  const LogoutPage({super.key});

  @override
  State<LogoutPage> createState() => _LogoutPageState();
}

class _LogoutPageState extends State<LogoutPage> {
  final AuthLocalDataSource _authLocalDataSource = AuthLocalDataSource();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Welcome to Dashboard'),
            const SizedBox(height: 100),
            BlocConsumer<LogoutBloc, LogoutState>(
              listener: (context, state) async {
                state.maybeMap(
                  orElse: () {},
                  loading: (_) {
                    setState(() => _isLoading = true);
                  },
                  error: (e) async {
                    setState(() => _isLoading = false);

                    if (e.message == 'UNAUTHORIZED') {
                      print('Handling unauthorized - navigating to login');
                      await _authLocalDataSource.removeAuthData();
                      if (!mounted) return;

                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (_) => const LoginPage()),
                          (route) => false);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(e.message),
                          backgroundColor: AppColors.red,
                        ),
                      );
                    }
                  },
                  success: (_) async {
                    print('Logout success - cleaning up and navigating');
                    setState(() => _isLoading = false);
                    await _authLocalDataSource.removeAuthData();
                    if (!mounted) return;

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Logout success'),
                        backgroundColor: AppColors.primary,
                      ),
                    );

                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (_) => const LoginPage()),
                        (route) => false);
                  },
                );
              },
              builder: (context, state) {
                return ElevatedButton(
                  onPressed: _isLoading
                      ? null
                      : () {
                          print('Triggering logout');
                          context
                              .read<LogoutBloc>()
                              .add(const LogoutEvent.logout());
                        },
                  child: _isLoading
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : const Text('Logout'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
