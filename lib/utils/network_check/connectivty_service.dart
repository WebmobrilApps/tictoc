import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityService {
  static final Connectivity _connectivity = Connectivity();
  static Stream<ConnectivityResult> get connectivityStream =>
      _connectivity.onConnectivityChanged.map((results) => results.isNotEmpty ? results.first : ConnectivityResult.none).distinct();



  static Future<bool> isConnected() async {
    final result = await _connectivity.checkConnectivity();
    return result != ConnectivityResult.none;
  }
}