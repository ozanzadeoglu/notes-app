import 'package:connectinno_case_client/domain/repositories/auth/auth_token_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthTokenProvider implements AuthTokenProvider {
  final FirebaseAuth _firebaseAuth;
  FirebaseAuthTokenProvider({
    FirebaseAuth? firebaseAuth,
  }) : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  @override
  Future<String?> getIdToken({bool forceRefresh = false}) async {
    try {
      final user = _firebaseAuth.currentUser;
      if (user == null) {
        return null; // User not authenticated
      }
      
      return await user.getIdToken(forceRefresh);
    } catch (e) {
      return null;
    }
  }
}