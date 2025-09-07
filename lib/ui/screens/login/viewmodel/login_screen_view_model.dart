import 'package:flutter/foundation.dart';
import '../../../../domain/repositories/auth/auth_repository.dart';

enum LoginState {
  initial,
  loading,
  success,
  error,
}

class LoginScreenViewModel extends ChangeNotifier {
  final AuthRepository _authRepository;

  LoginScreenViewModel(this._authRepository);

  LoginState _state = LoginState.initial;
  String? _errorMessage;

  LoginState get state => _state;
  String? get errorMessage => _errorMessage;
  bool get isLoading => _state == LoginState.loading;

  Future<void> signInWithGoogle() async {
    try {
      _state = LoginState.loading;
      _errorMessage = null;
      notifyListeners();

      await _authRepository.signInWithGoogle();
      _state = LoginState.success;
    } catch (e) {
      _errorMessage = e.toString().replaceFirst("Exception: ", "");
      _state = LoginState.error;
    }
    notifyListeners();
  }

  void clearError() {
    _errorMessage = null;
    if (_state == LoginState.error) {
      _state = LoginState.initial;
    }
    notifyListeners();
  }
}