import 'package:connectinno_case_client/core/theme/app_colors.dart';
import 'package:connectinno_case_client/ui/screens/login/widgets/sign_in_loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'viewmodel/login_screen_view_model.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox.shrink(),
              Column(
                children: [
                  const Text(
                    'NoteIt',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Sign in to start taking notes smartly, and free.',
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.secondaryText,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              SizedBox.shrink(),
              Consumer<LoginScreenViewModel>(
                builder: (context, loginViewModel, child) {
                  return SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton.icon(
                      onPressed: loginViewModel.isLoading
                          ? null
                          : () async {
                              await loginViewModel.signInWithGoogle();
                              if (loginViewModel.errorMessage != null) {
                                if (context.mounted) {
                                  _showErrorSnackbar(context, loginViewModel.errorMessage!);
                                  loginViewModel.clearError();
                                }
                              }
                            },
                      icon: loginViewModel.isLoading
                          ? SignInLoadingIndicator()
                          : const Icon(Icons.login, color: Colors.white),
                      label: Text(
                        loginViewModel.isLoading
                            ? 'Signing in...'
                            : 'Sign in with Google',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF4285F4),
                        foregroundColor: Colors.white,
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),

                    ),
                  );
                },
              ),
              SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }

  void _showErrorSnackbar(BuildContext context, String errorMessage) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          errorMessage,
          textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.red,
      ),
    );
  }
}
