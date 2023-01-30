import 'dart:io';

import 'package:flutter/foundation.dart';

class InternetConnectionChecker {
  Future<bool> get isInternetConnected async {
    try {
      final hasData = await InternetAddress.lookup('www.google.com',
          type: InternetAddressType.IPv4);
      if (hasData[0].address.isNotEmpty) {
        return true;
      }
    } on SocketException catch (error) {
      debugPrint(error.message);
    }
    return false;
  }
}
