import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class OnlineStatusIndicator extends StatefulWidget {
  const OnlineStatusIndicator({Key? key}) : super(key: key);

  @override
  _OnlineStatusIndicatorState createState() => _OnlineStatusIndicatorState();
}

class _OnlineStatusIndicatorState extends State<OnlineStatusIndicator> {
  bool _isOnline = true;

  @override
  void initState() {
    super.initState();
    Connectivity().onConnectivityChanged.listen((result) {
      setState(() {
        _isOnline = result != ConnectivityResult.none;
      });
    });

    // Check initial status
    Connectivity().checkConnectivity().then((result) {
      setState(() {
        _isOnline = result != ConnectivityResult.none;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          _isOnline ? Icons.wifi : Icons.wifi_off,
          color: _isOnline ? Colors.green : Colors.red,
          size: 16,
        ),
        const SizedBox(width: 4),
        Text(
          _isOnline ? 'Online' : 'Offline',
          style: TextStyle(
            fontSize: 12,
            color: _isOnline ? Colors.green : Colors.red,
          ),
        ),
      ],
    );
  }
}
