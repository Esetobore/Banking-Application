class ApiEndPoints {
  static const String baseUrl = 'https://bankapi.veegil.com/';
  static _AuthEndPoints authEndpoints = _AuthEndPoints();
}

class _AuthEndPoints {
  final String signup = 'auth/signup';
  final String login = 'auth/login';
  final String withDraw = 'accounts/withdraw';
  final String transfer = 'accounts/transfer';
  final String transactions_history = 'transactions';
  final String authUsers = 'auth/users';

}