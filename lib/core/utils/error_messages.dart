import '../errors/app_errors.dart';

class ErrorMessages {
  static String getErrorMessage(AppError error) {
    switch (error) {
      // Network related
      case AppError.noNetworkConnection:
        return 'No internet connection. Please check your network and try again.';
      case AppError.serverUnavailable:
        return 'Server is temporarily unavailable. Please try again later.';
      case AppError.requestTimeout:
        return 'Request timed out. Please try again.';
      
      // Authentication & Authorization
      case AppError.unauthorized:
        return 'You are not authorized. Please sign in again.';
      case AppError.sessionExpired:
        return 'Your session has expired. Please sign in again.';
      case AppError.signInFailed:
        return 'Sign in failed. Please try again.';
      case AppError.signOutFailed:
        return 'Sign out failed. Please try again.';
      
      // Note operations
      case AppError.noteCreationFailed:
        return 'Failed to create note. Please try again.';
      case AppError.noteUpdateFailed:
        return 'Failed to save changes. Please try again.';
      case AppError.noteDeletionFailed:
        return 'Failed to delete note. Please try again.';
      
      // Local note errors
      case AppError.localNotesGetFailed:
        return 'Failed to load notes from storage.';
      case AppError.localNoteUpdateFailed:
        return 'Failed to save note locally.';
      case AppError.localNoteDeletionFailed:
        return 'Failed to delete note from local storage.';
      
      // Sync operations
      case AppError.syncFailed:
        return 'Sync failed. Check your connection and try again.';
      
      // Data related
      case AppError.notFound:
        return 'Requested data not found.';
      case AppError.invalidResponse:
        return 'Invalid response from server.';
      case AppError.parsingError:
        return 'Error processing server response.';
      
      // Cache & Storage
      case AppError.cacheReadFailed:
        return 'Failed to read from local storage.';
      case AppError.cacheWriteFailed:
        return 'Failed to write to local storage.';
      case AppError.storagePermissionDenied:
        return 'Storage permission denied.';
      
      // User actions
      case AppError.requestCancelled:
        return 'Request was cancelled.';
      
      // Search specific
      case AppError.noOfflineSearch:
        return 'Search is not available offline.';
      case AppError.searchTermTooShort:
        return 'Search term is too short.';
      
      // Generic
      case AppError.unknown:
        return 'Something went wrong. Please try again.';
    }
  }
  
  static bool shouldShowRetryButton(AppError error) {
    switch (error) {
      case AppError.noNetworkConnection:
      case AppError.serverUnavailable:
      case AppError.requestTimeout:
      case AppError.syncFailed:
      case AppError.noteCreationFailed:
      case AppError.noteUpdateFailed:
      case AppError.noteDeletionFailed:
      case AppError.localNotesGetFailed:
      case AppError.unknown:
        return true;
        
      case AppError.unauthorized:
      case AppError.sessionExpired:
      case AppError.signInFailed:
      case AppError.signOutFailed:
      case AppError.storagePermissionDenied:
      case AppError.requestCancelled:
      case AppError.searchTermTooShort:
        return false;
        
      default:
        return false;
    }
  }
}