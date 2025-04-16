import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';

final connectivityAdapter = InternetConnectionCheckerAdapter();

abstract class ConnectivityAdapter {
  bool _isConnectedSync;

  ConnectivityAdapter() : _isConnectedSync = true {
    isConnected.then((c) => _isConnectedSync = c);
    onConnectivityChanged.listen((isConnected) {
      _isConnectedSync = isConnected;
    });
  }

  bool get isConnectedSync => _isConnectedSync;

  Future<bool> get isConnected;

  Stream<bool> get onConnectivityChanged;
}

class InternetConnectionCheckerAdapter extends ConnectivityAdapter
    with WidgetsBindingObserver {
  InternetConnectionCheckerAdapter()
      : dio = Dio(),
        super() {
    Timer? timer;

    onConnectivityChanged.listen((connected) {
      if (!connected && timer == null) {
        timer = Timer.periodic(const Duration(seconds: 30), (timer) async {
          if (WidgetsBinding.instance.lifecycleState ==
              AppLifecycleState.paused) {
            return;
          }
          await isConnected;
        });
      } else {
        timer?.cancel();
        timer = null;
      }
    });
  }
  final Dio dio;
  final _connectionStreamController = StreamController<bool>.broadcast();

  @override
  didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {
      await isConnected;
    }
  }

  final vpnNames = [
    'tun',
    'tap',
    'ppp',
    'pptp',
    'l2tp',
    'ipsec',
    'vpn',
    'wireguard',
    'openvpn',
    'softether',
    'proton',
    'strongswan',
    'cisco',
    'forticlient',
    'fortinet',
    'hideme',
    'hidemy',
    'hideman',
    'hidester',
    'lightway',
  ];
  Future<bool> isVpnActive() async {
    final interfaces = await NetworkInterface.list(
      includeLoopback: false,
      type: InternetAddressType.any,
    );

    if (interfaces.isEmpty) {
      return false;
    }

    return interfaces.any(
      (interface) =>
          vpnNames.any((name) => interface.name.toLowerCase().contains(name)),
    );
  }

  @override
  Future<bool> get isConnected async {
    final connected = await _isConnected();
    if (connected != isConnectedSync /*previous value*/) {
      _connectionStreamController.add(connected);
    }
    return connected;
  }

  Future<bool> doesConnectTo(String address) async {
    try {
      final result = await InternetAddress.lookup(address);
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
      return false;
    } on SocketException catch (_) {
      try {
        final response = await dio.head('https://$address');
        return (response.statusCode ?? 500) <= 400;
      } on DioException catch (_) {
        return false;
      }
    }
  }

  Future<bool> _isConnected() async {
    return await doesConnectTo('google.com') || await isVpnActive();
  }

  @override
  Stream<bool> get onConnectivityChanged => _connectionStreamController.stream;
}
