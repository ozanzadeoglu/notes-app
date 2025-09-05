import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../ui/screens/login/login_screen.dart';
import '../../ui/screens/home/home_screen.dart';
import '../../ui/screens/login/viewmodel/login_screen_view_model.dart';
import '../../domain/repositories/auth_repository.dart';

class AppRouter {
  static GoRouter router(AuthRepository authRepository) {
    return GoRouter(
      initialLocation: '/login',
      redirect: (context, state) {
        final isAuthenticated = authRepository.isAuthenticated;
        final isInitialized = authRepository.isInitialized;
        final isLoginRoute = state.matchedLocation == '/login';
        
        // Wait for auth state to be initialized
        if (!isInitialized) {
          return null;
        }
        
        if (isAuthenticated && isLoginRoute) {
          return '/home';
        } else if (!isAuthenticated && !isLoginRoute) {
          return '/login';
        }
        
        return null;
      },
      refreshListenable: authRepository,
      routes: [
        GoRoute(
          path: '/login',
          name: 'login',
          builder: (context, state) => ChangeNotifierProvider(
            create: (context) => LoginScreenViewModel(
              context.read<AuthRepository>(),
            ),
            child: const LoginScreen(),
          ),
        ),
        GoRoute(
          path: '/home',
          name: 'home',
          builder: (context, state) => const HomeScreen(),
        ),
      ],
      errorBuilder: (context, state) => Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.error_outline,
                size: 64,
                color: Colors.red,
              ),
              const SizedBox(height: 16),
              Text(
                'Page not found',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 8),
              Text(
                state.error.toString(),
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => context.go('/login'),
                child: const Text('Go to Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}