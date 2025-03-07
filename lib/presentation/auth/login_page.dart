import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seblak_sulthane_app/data/datasources/auth_local_datasource.dart';

import 'package:flutter_svg/flutter_svg.dart';

import '../../core/assets/assets.gen.dart';
import '../../core/components/buttons.dart';
import '../../core/components/custom_text_field.dart';
import '../../core/components/spaces.dart';
import '../../core/constants/colors.dart';
import '../home/pages/dashboard_page.dart';
import 'bloc/login/login_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isPasswordVisible = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isTablet = screenWidth > 600;

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: isTablet ? screenWidth * 0.1 : 24.0,
            vertical: 20.0,
          ),
          child: Column(
            children: [
              SizedBox(height: screenHeight * 0.08),
              Center(
                child: SvgPicture.asset(
                  Assets.icons.homeResto.path,
                  width: isTablet ? 120 : 100,
                  height: isTablet ? 120 : 100,
                  color: AppColors.primary,
                ),
              ),
              const SpaceHeight(24.0),
              const Text(
                'Welcome',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
              const SpaceHeight(8.0),
              const Text(
                'Silahkan Login Terlebih Dahulu',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey,
                ),
              ),
              const SpaceHeight(40.0),
              CustomTextField(
                controller: emailController,
                label: 'Email',
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
              ),
              const SpaceHeight(16.0),
              CustomTextField(
                controller: passwordController,
                label: 'Password',
                obscureText: !isPasswordVisible,
                textInputAction: TextInputAction.done,
                suffixIcon: InkWell(
                  onTap: () => setState(() {
                    isPasswordVisible = !isPasswordVisible;
                  }),
                  child: Icon(
                    isPasswordVisible
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                    color: Colors.grey,
                    size: 20,
                  ),
                ),
              ),
              const SpaceHeight(32.0),
              BlocListener<LoginBloc, LoginState>(
                listener: (context, state) {
                  state.maybeWhen(
                    orElse: () {},
                    success: (authResponseModel) {
                      AuthLocalDataSource().saveAuthData(authResponseModel);
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const DashboardPage(),
                        ),
                      );
                    },
                    error: (message) {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          contentPadding: const EdgeInsets.all(24.0),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.close,
                                color: Colors.red,
                                size: 48,
                              ),
                              const SizedBox(height: 16),
                              const Text(
                                'Email atau Password Salah',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 24),
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.primary,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 12),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text(
                                    'Kembali',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
                child: BlocBuilder<LoginBloc, LoginState>(
                  builder: (context, state) {
                    return state.maybeWhen(
                      orElse: () {
                        return SizedBox(
                          width: double.infinity,
                          child: Button.filled(
                            onPressed: () {
                              context.read<LoginBloc>().add(
                                    LoginEvent.login(
                                      email: emailController.text,
                                      password: passwordController.text,
                                    ),
                                  );
                            },
                            label: 'Masuk',
                          ),
                        );
                      },
                      loading: () {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
