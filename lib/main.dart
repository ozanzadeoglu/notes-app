import 'package:connectinno_case_client/core/cache/cache_constants.dart';
import 'package:connectinno_case_client/core/cache/i_cache_service.dart';
import 'package:connectinno_case_client/core/cache/impl/hive_cache_service.dart';
import 'package:connectinno_case_client/core/connectivity/i_connectivity_service.dart';
import 'package:connectinno_case_client/core/connectivity/impl/connectivity_service.impl.dart';
import 'package:connectinno_case_client/core/network/dio_client.dart';
import 'package:connectinno_case_client/data/datasources/auth/firebase_auth_token_provider.dart';
import 'package:connectinno_case_client/data/datasources/note/local_note_datasource.dart';
import 'package:connectinno_case_client/data/datasources/note/remote_note_datasource.dart';
import 'package:connectinno_case_client/data/datasources/queue/queue_datasource.dart';
import 'package:connectinno_case_client/data/models/note/note_model.dart';
import 'package:connectinno_case_client/data/models/queue/queue_model.dart';
import 'package:connectinno_case_client/data/network/api_client.dart';
import 'package:connectinno_case_client/data/repositories/note/note_repository_impl.dart';
import 'package:connectinno_case_client/data/services/i_sync_orchestrator.dart';
import 'package:connectinno_case_client/data/services/sync_orchestrator_impl.dart';
import 'package:connectinno_case_client/domain/repositories/auth/auth_token_provider.dart';
import 'package:connectinno_case_client/domain/repositories/note/note_repository.dart';
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
  final lastSyncBox = await Hive.openBox<String>(CacheBoxNames.lastSyncDate);

  runApp(
    MultiProvider(
      providers: [
        // Connectivity service provider
        ChangeNotifierProvider<IConnectivityService>(
          create: (context) => connectivityService,
        ),

        // Cache Providers
        Provider<ICacheService<NoteCache>>(
          create: (_) => HiveCacheService(notesBox),
        ),
        Provider<ICacheService<QueueCache>>(
          create: (context) => HiveCacheService(queueBox),
        ),
        Provider<ICacheService<LastSyncCache>>(
          create: (context) => HiveCacheService(lastSyncBox),
        ),

        // Auth Providers
        Provider<AuthTokenProvider>(create: (_) => FirebaseAuthTokenProvider()),
        Provider<FirebaseAuthDataSourceImpl>(
          create: (context) => FirebaseAuthDataSourceImpl(),
        ),
        ChangeNotifierProvider<AuthRepository>(
          create: (context) =>
              AuthRepositoryImpl(context.read<FirebaseAuthDataSourceImpl>()),
        ),

        // Api Client
        Provider<ApiClient>(
          create: (context) => ApiClient(
            dio: DioClient.instance.dio,
            tokenProvider: context.read<AuthTokenProvider>(),
          ),
        ),

        // Note data sources
        Provider<RemoteNoteDataSource>(
          create: (context) =>
              RemoteNoteDataSourceImpl(context.read<ApiClient>()),
        ),
        Provider<LocalNoteDataSource>(
          create: (context) =>
              LocalNoteDataSourceImpl(context.read<ICacheService<NoteCache>>()),
        ),

        // Queue data sources
        Provider<QueueDataSource>(
          create: (context) =>
              QueueDataSourceImpl(context.read<ICacheService<QueueCache>>()),
        ),

        // Note repository
        Provider<NoteRepository>(
          create: (context) => NoteRepositoryImpl(
            localDataSource: context.read<LocalNoteDataSource>(),
            remoteDataSource: context.read<RemoteNoteDataSource>(),
            queueDataSource: context.read<QueueDataSource>(),
            connectivityService: connectivityService,
          ),
        ),

        // Sync Orchestrator
        Provider<ISyncOrchestrator>(
          create: (context) { 
            final orchestrator = SyncOrchestratorImpl(
            connectivityService: connectivityService,
            authRepository: context.read<AuthRepository>(),
            queueDataSource: context.read<QueueDataSource>(),
            remoteDataSource: context.read<RemoteNoteDataSource>(),
            localNoteDataSource: context.read<LocalNoteDataSource>(),
            lastSyncCache: context.read<ICacheService<LastSyncCache>>(),
          );
          orchestrator.initialize();
          return orchestrator;
          }

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
