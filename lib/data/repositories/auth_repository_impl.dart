import 'dart:async';
import 'package:flutter/foundation.dart';
import '../../domain/entities/user/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/firebase_auth_datasource.dart';

class AuthRepositoryImpl extends ChangeNotifier implements AuthRepository {
  final FirebaseAuthDataSource _firebaseAuthDataSource;
  late final StreamSubscription _authSubscription;
  
  UserEntity? _currentUser;
  bool _isInitialized = false;

  AuthRepositoryImpl(this._firebaseAuthDataSource) {
    _initAuthListener();
  }

  @override
  UserEntity? get currentUser => _currentUser;
  
  @override
  bool get isAuthenticated => _currentUser != null;
  
  @override
  bool get isInitialized => _isInitialized;

  void _initAuthListener() {
    _authSubscription = _firebaseAuthDataSource.authStateChanges.listen(
      (userModel) {
        _currentUser = userModel?.toEntity();
        _isInitialized = true;
        notifyListeners();
      },
      onError: (error) {
        _currentUser = null;
        _isInitialized = true;
        notifyListeners();
      },
    );
  }

  @override
  Future<UserEntity?> getCurrentUser() async {
    final userModel = await _firebaseAuthDataSource.getCurrentUser();
    return userModel?.toEntity();
  }

  @override
  Future<UserEntity> signInWithGoogle() async {
    final userModel = await _firebaseAuthDataSource.signInWithGoogle();
    return userModel.toEntity();
  }

  @override
  Future<void> signOut() async {
    await _firebaseAuthDataSource.signOut();
  }

  @override
  Stream<UserEntity?> get authStateChanges {
    return _firebaseAuthDataSource.authStateChanges
        .map((userModel) => userModel?.toEntity());
  }

  @override
  void dispose() {
    _authSubscription.cancel();
    super.dispose();
  }
}