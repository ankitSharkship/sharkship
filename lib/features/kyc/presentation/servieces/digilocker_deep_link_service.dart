// lib/services/digilocker_deep_link_service.dart

import 'dart:async';
import 'package:app_links/app_links.dart';
import 'package:flutter/foundation.dart';

class DigilockerDeepLinkService {
  // Singleton
  static final DigilockerDeepLinkService _instance =
      DigilockerDeepLinkService._internal();
  factory DigilockerDeepLinkService() => _instance;
  DigilockerDeepLinkService._internal();

  final _appLinks = AppLinks();
  StreamSubscription<Uri>? _sub;

  // The active DigiLocker screen registers its handler here
  void Function(Uri uri)? onDeepLink;

  void init() {
    _sub = _appLinks.uriLinkStream.listen(
      (uri) {
        debugPrint('[DigiLocker] Deep link received: $uri');
        // Only forward links that are our DigiLocker callback
        if (uri.scheme == 'sharkship' && uri.host == 'digilocker') {
          onDeepLink?.call(uri);
        }
      },
      onError: (err) {
        debugPrint('[DigiLocker] Deep link error: $err');
      },
    );
  }

  void dispose() {
    _sub?.cancel();
  }
}
