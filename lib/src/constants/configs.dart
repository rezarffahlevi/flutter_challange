import 'dart:convert';

import 'package:flutter_challange/src/constants/enums.dart';
import 'package:flutter_challange/src/constants/constant.dart';

class Configs {
// IMPORTANT! CHECK BEFORE BUILD
  static const AppEnvironmentEnum appEnvironment = AppEnvironmentEnum.STAGING;
  // static const AppEnvironmentEnum appEnvironment = AppEnvironmentEnum.PRODUCTION;

  static const String _devBuildNumber = '.0';

  static const _baseUrlStaging = 'my.unpam.ac.id';
  static const _baseUrlSSOStaging = 'sso.unpam.ac.id';

  static const _baseUrlProduction = 'my.unpam.ac.id';
  static const _baseUrlSSOProduction = 'sso.unpam.ac.id';

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
        result[CONSTANT.KEY_API_MY_UNPAM] = _baseUrlStaging;
        result[CONSTANT.KEY_API_SSO] = _baseUrlSSOStaging;
        break;
      case AppEnvironmentEnum.PRODUCTION:
        result[CONSTANT.KEY_API_MY_UNPAM] = _baseUrlProduction;
        result[CONSTANT.KEY_API_SSO] = _baseUrlSSOProduction;
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
