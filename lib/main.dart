import 'package:connectinno_case_client/core/cache/cache_constants.dart';
import 'package:connectinno_case_client/core/cache/i_cache_service.dart';
import 'package:connectinno_case_client/core/cache/impl/hive_cache_service.dart';
import 'package:connectinno_case_client/core/connectivity/i_connectivity_service.dart';
import 'package:connectinno_case_client/core/connectivity/impl/connectivity_service.impl.dart';
import 'package:connectinno_case_client/data/datasources/auth/firebase_auth_token_provider.dart';
import 'package:connectinno_case_client/data/models/note/note_model.dart';
import 'package:connectinno_case_client/data/models/queue/queue_model.dart';
import 'package:connectinno_case_client/domain/repositories/auth/auth_token_provider.dart';
import 'package:connectinno_case_client/hive_registrar.g.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'domain/repositories/auth/auth_repository.dart';
import 'data/repositories/auth/auth_repository_impl.dart';
import 'data/datasources/auth/firebase_auth_datasource.dart';
import 'core/router/app_router.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Initialize connectivity
  final connectivityService = ConnectivityServiceImpl();
  // Perform the initial connectivity check before the app even runs.
  await connectivityService.initialize();

  // Initialize Hive
  await Hive.initFlutter();

  // Hive_ce QOL function to register adapters at once.
  Hive.registerAdapters();

  final notesBox = await Hive.openBox<NoteModel>(CacheBoxNames.notes);
  final queueBox = await Hive.openBox<QueueModel>(CacheBoxNames.queue);


  runApp(
    MultiProvider(
      providers: [
        // Connectivity service provider
        ChangeNotifierProvider<IConnectivityService>(
          create: (context) => connectivityService,
        ),

        // Cache Providers
        Provider<ICacheService<NoteCache>>(create: (_) => HiveCacheService(notesBox)),
        Provider<ICacheService<QueueCache>>(create: (context) => HiveCacheService(queueBox)),

        // Auth Providers
        Provider<AuthTokenProvider>(create: (_) => FirebaseAuthTokenProvider()),
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
