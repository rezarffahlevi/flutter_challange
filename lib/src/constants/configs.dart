import 'dart:convert';
import 'package:flutter_challange/src/constants/enums.dart';
import 'package:flutter_challange/src/helpers/api_helpers.dart';

class Configs {
// IMPORTANT! CHECK BEFORE BUILD
  static const AppEnvironmentEnum appEnvironment = AppEnvironmentEnum.STAGING;
  // static const AppEnvironmentEnum appEnvironment = AppEnvironmentEnum.PRODUCTION;

  static const String _devBuildNumber = '.0';

  static const _baseUrlStaging = 'node.kasehat.co.id';

  static const _baseUrlProduction = 'node.kasehat.co.id';

  static String get getDevBuildNumber {
    String result = '';
    if (appEnvironment == AppEnvironmentEnum.STAGING) {
      result = _devBuildNumber;
    }
    return result;
  }

  static dynamic get baseUrl {
    // List<String> result;
    Map<String, String> result = Map<String, String>();
    switch (appEnvironment) {
      case AppEnvironmentEnum.STAGING:
        result[ApiHelper.BASE_URL] = _baseUrlStaging;
        break;
      case AppEnvironmentEnum.PRODUCTION:
        result[ApiHelper.BASE_URL] = _baseUrlProduction;
        break;
    }
    return jsonEncode(result);
  }

  static String get authorization {
    String result = '';

    switch (appEnvironment) {
      case AppEnvironmentEnum.STAGING:
        break;
      case AppEnvironmentEnum.PRODUCTION:
        break;
    }
    return result;
  }

  static Duration get timeOutDuration {
    Duration result;

    switch (appEnvironment) {
      case AppEnvironmentEnum.STAGING:
        result = Duration(seconds: 30);
        break;
      case AppEnvironmentEnum.PRODUCTION:
        result = Duration(minutes: 3);
        break;
    }
    return result;
  }

  static String get prefixEnvironment {
    String result = 'prod';
    switch (appEnvironment) {
      case AppEnvironmentEnum.STAGING:
        result = 'dev';
        break;
      case AppEnvironmentEnum.PRODUCTION:
        result = 'prod';
        break;
    }
    return result;
  }
}
