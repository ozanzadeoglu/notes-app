import 'package:flutter/foundation.dart';
import '../entities/user/user_entity.dart';

abstract class AuthRepository extends ChangeNotifier {
  Future<UserEntity?> getCurrentUser();
  Future<UserEntity> signInWithGoogle();
  Future<void> signOut();
  Stream<UserEntity?> get authStateChanges;
  
  // Properties for GoRouter and UI
  UserEntity? get currentUser;
  bool get isAuthenticated;
  bool get isInitialized;
}