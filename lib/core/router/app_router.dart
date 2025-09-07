import 'package:connectinno_case_client/data/services/i_sync_orchestrator.dart';
import 'package:connectinno_case_client/domain/repositories/note/note_repository.dart';
import 'package:connectinno_case_client/ui/screens/home/viewmodel/home_viewmodel.dart';
import 'package:connectinno_case_client/ui/screens/note/note_view.dart';
import 'package:connectinno_case_client/ui/screens/note/viewmodel/note_view_model.dart';
import 'package:connectinno_case_client/domain/entities/note/note.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../ui/screens/login/login_screen.dart';
import '../../ui/screens/home/home_screen.dart';
import '../../ui/screens/login/viewmodel/login_screen_view_model.dart';
import '../../domain/repositories/auth/auth_repository.dart';

class AppRouter {
  static GoRouter router(AuthRepository authRepository) {
    return GoRouter(
      initialLocation: '/splash',
      redirect: (context, state) {
        final isAuthenticated = authRepository.isAuthenticated;
        final isInitialized = authRepository.isInitialized;
        final currentLocation = state.matchedLocation;

        if (!isInitialized) {
          return '/splash';
        }

        if (isAuthenticated &&
            (currentLocation == '/login' || currentLocation == '/splash')) {
          return '/home';
        } else if (!isAuthenticated && currentLocation != '/login') {
          return '/login';
        }

        return null;
      },
      refreshListenable: authRepository,
      routes: [
        GoRoute(
          path: '/login',
          name: 'login',
          pageBuilder: (context, state) => NoTransitionPage(
            child: ChangeNotifierProvider(
              create: (context) =>
                  LoginScreenViewModel(context.read<AuthRepository>()),
              child: const LoginScreen(),
            ),
          ),
        ),
        GoRoute(
          path: '/home',
          name: 'home',
          pageBuilder: (context, state) => NoTransitionPage(
            child: ChangeNotifierProvider(
              create: (context) => HomeViewModel(
                noteRepository: context.read<NoteRepository>(),
                syncOrchestrator: context.read<ISyncOrchestrator>(),
              ),
              child: const HomeScreen(),
            ),
          ),
        ),
        GoRoute(
          path: '/note',
          name: 'note',
          builder: (context, state) {
            final noteExtra = state.extra as Map<String, dynamic>?;
            final note = noteExtra?['note'] as Note?;
            final isNew = noteExtra?['isNew'] as bool? ?? false;

            return ChangeNotifierProvider(
              create: (context) => NoteViewModel(
                noteRepository: context.read<NoteRepository>(),
                note: note,
                isNewNote: isNew,
              ),
              child: const NoteView(),
            );
          },
        ),
        GoRoute(
          path: '/splash',
          name: 'splash',
          builder: (context, state) => const Scaffold(),
        ),
      ],
      errorBuilder: (context, state) => Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 64, color: Colors.red),
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
