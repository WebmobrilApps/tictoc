import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:tictoc/utils/network_check/connectivty_service.dart';
import 'package:tictoc/utils/network_check/no_internet_screen.dart';


class ConnectivityListener extends StatefulWidget {
  final Widget child;

  const ConnectivityListener({super.key, required this.child});

  @override
  _ConnectivityListenerState createState() => _ConnectivityListenerState();
}

class _ConnectivityListenerState extends State<ConnectivityListener> {
  ConnectivityResult? _previousConnectionStatus;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ConnectivityResult>(
      stream: ConnectivityService.connectivityStream,
      builder: (context, snapshot) {
        final isConnected = snapshot.data != ConnectivityResult.none;

        // Check if connectivity state has changed
        if (_previousConnectionStatus != snapshot.data) {
          _previousConnectionStatus = snapshot.data;

          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (!isConnected) {
              // Avoid pushing multiple instances of NoInternetScreen
              if (ModalRoute.of(context)?.settings.name != "NoInternetScreen") {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const NoInternetScreen(),
                    settings: const RouteSettings(name: "NoInternetScreen"),
                  ),
                );
              }
            } else {
              // Ensure the NoInternetScreen is removed when the internet is back
              Navigator.popUntil(context, (route) => route.settings.name != "NoInternetScreen");
            }
          });
        }

        return widget.child;
      },
    );
  }
}



/*class ConnectivityListener extends StatelessWidget {
  final Widget child;

  const ConnectivityListener({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ConnectivityResult>(
      stream: ConnectivityService.connectivityStream,
      builder: (context, snapshot) {
        final isConnected = snapshot.data != ConnectivityResult.none;

        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (!isConnected) {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const NoInternetScreen()),
            );
          } else {
            // Ensure the NoInternetScreen is removed when the internet is back
            if (Navigator.canPop(context)) {
              Navigator.of(context).popUntil((route) => route.isFirst);
            }
          }
        });

        return child;
      },
    );
  }
}*/
