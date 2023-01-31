import 'internet_connection_checker.dart';

abstract class NetworkInfo {
  Future<bool> get isConnectedToInternet;
}

class NetworkInfoImp implements NetworkInfo {
  InternetConnectionChecker connectionChecker;
  NetworkInfoImp({
    required this.connectionChecker,
  });
  @override
  Future<bool> get isConnectedToInternet =>
      connectionChecker.isInternetConnected;
}
