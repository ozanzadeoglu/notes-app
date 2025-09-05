/// This interface only exposes idToken of a authenticated user.
abstract class AuthTokenProvider {
  /// Returns auth id token.
  Future<String?> getIdToken({bool forceRefresh = false});
}