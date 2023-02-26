
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class ConnectivityProvider extends ChangeNotifier {
   bool _isOnline =true;
  bool get isOnline => _isOnline;

  ConnectivityProvider() {
    Connectivity connectivity = Connectivity();
    connectivity.onConnectivityChanged.listen(
      (event) {
        if (event == ConnectivityResult.none) {
          _isOnline = false;
          notifyListeners();
        } else {
          _isOnline = true;
          notifyListeners();
        }
      },
    );
  }
}
