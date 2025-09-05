import 'package:connectinno_case_client/core/cache/i_cache_service.dart';
import 'package:connectinno_case_client/core/cache/impl/hive_cache_service.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hive_ce/hive.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'domain/repositories/auth_repository.dart';
import 'data/repositories/auth_repository_impl.dart';
import 'data/datasources/firebase_auth_datasource.dart';
import 'core/router/app_router.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Initialize Hive
  await Hive.initFlutter();
  
  final notesBox = await Hive.openBox('favorites');


  runApp(
    MultiProvider(
      providers: [
        // Cache Providers
        Provider<ICacheService<NoteCache>>(create: (_) => HiveCacheService(notesBox)),

        // Auth Providers
        Provider<FirebaseAuthDataSourceImpl>(
          create: (context) => FirebaseAuthDataSourceImpl(),
        ),
        ChangeNotifierProvider<AuthRepository>(
          create: (context) =>
              AuthRepositoryImpl(context.read<FirebaseAuthDataSourceImpl>()),
        ),

      ],
      child: MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Note App',
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      routerConfig: AppRouter.router(context.read<AuthRepository>()),
    );
  }
}
