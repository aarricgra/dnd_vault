import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:js/js_util.dart' as js_util;
import 'package:web/web.dart' as web;

class AutoUpdateService {
  const AutoUpdateService();

  static final _cookieStorage = web.window.localStorage;
  static const _localStorageKey = 'app_version';

  Future<void> updateIfNecessary() async {
    final shouldUpdate = await _checkForUpdate();

    if (!shouldUpdate) {
      return;
    }

    _reloadApp();
  }

  Future<bool> _checkForUpdate() async {
    final currentVersion = _getSavedVersion();
    final remoteVersion = await _getRemoteVersion();

    debugPrint('App version: $currentVersion');

    if (currentVersion == remoteVersion) {
      return false;
    }

    debugPrint('New app version: $remoteVersion');

    _saveVersion(remoteVersion);

    return true;
  }

  Future _getRemoteVersion() async {
    const versionPath = '/version.json';

    final response = await http.get(Uri.parse('$versionPath?ts=${DateTime.now().millisecondsSinceEpoch}'));
    final appData = json.decode(response.body);
    final remoteVersion = appData['version'];

    return remoteVersion;
  }

  String? _getSavedVersion() => _cookieStorage.getItem(_localStorageKey);

  void _saveVersion(String version) => _cookieStorage.setItem(_localStorageKey, version);

  Future<void> _reloadApp() async {
    final registrationsPromise = web.window.navigator.serviceWorker.getRegistrations();

    final registrations = await js_util.promiseToFuture(registrationsPromise);

    for (final registration in registrations) {
      registration.unregister();
    }
  }
}