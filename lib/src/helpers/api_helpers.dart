import 'dart:convert';
import 'dart:io';
import 'package:flutter_challange/src/helpers/validators.dart';
import 'package:http/http.dart' as client;
import 'dart:async';
import 'package:flutter_challange/src/constants/configs.dart';
import 'package:flutter_challange/src/constants/constant.dart';
import 'preferences_base.dart';

class ApiHelper {
  ApiHelper._instantiate();

  static final ApiHelper instance = ApiHelper._instantiate();

  var header = new Map<String, String>();

  ApiHelper();

  static String getBaseUrl(key) {
    try {
      final base = jsonDecode(Configs.baseUrl);
      if (Validators.isNull(key)) return base[CONSTANT.KEY_BASE_URL];
      return base[key];
    } catch (e) {
      print("ERR $e");
      return 'Error';
    }
  }

  static String _getAuthorization() {
    return Configs.authorization;
  }

  static Duration _getTimeOutDuration() {
    return Configs.timeOutDuration;
  }

  Future<Map<String, String>> getHeader() async {
    var result = Map<String, String>();
    // String pushToken = await Prefs.pushToken;
    // if (pushToken == '') pushToken = 'ERROR';

    result["Authorization"] = 'Bearer ' + await Prefs.token;
    // result["user-agent"] = await Utilities.getUserAgent();
    result["Content-Type"] = "application/json";

    // print('header : $result');
    return result;
  }

  Future<Map<String, String>> getHeaderUrlEncodes() async {
    var result = await getHeader();
    result["Content-Type"] = "application/x-www-form-urlencoded";

    print('header : $result');
    return result;
  }

  Future<dynamic> get(String url, {dynamic params, String baseUrl}) async {
    baseUrl = getBaseUrl(baseUrl);
    print('CALL API GET ==> ${baseUrl + url}');
    if (params != null) {
      url += mapToParamString(params);
    }

    var responseJson;
    try {
      var uri = Uri.https(baseUrl, url, {});
      final response = await client
          .get(uri, headers: await getHeader())
          .timeout(_getTimeOutDuration());
      // print('RESPONSE ${response.body}');
      print('GET STATUS CODE  $url ==> ${response.statusCode}');
      responseJson = _returnResponse(response);
    } on SocketException {
      print('No net');
    } on TimeoutException {
      print(
          'Koneksi Mums lemah, Pastikan internet Mums lancar dengan cek ulang jaringan Mums');
    }
    return responseJson;
  }

  Future<dynamic> post(String url, {dynamic params, String baseUrl}) async {
    baseUrl = getBaseUrl(baseUrl);
    print('CALL API POST ==> ${baseUrl + url}');
    String bodyString = '';
    if (params != null) {
//      params.removeWhere((String key, dynamic value) => value == null);
      bodyString = jsonEncode(params);
    }
    print('Params : $bodyString');
    var responseJson;
    try {
      var uri = Uri.https(baseUrl, url, {});
      final response = await client
          .post(uri, body: bodyString, headers: await getHeader())
          .timeout(_getTimeOutDuration());
      // print('RESPONSE ${response.body}');
      print('POST STATUS CODE $url ==> ${response.statusCode}');
      responseJson = _returnResponse(response);
    } on SocketException {
      print('No net');
    } on TimeoutException {
      print(
          'Koneksi Mums lemah, Pastikan internet Mums lancar dengan cek ulang jaringan Mums');
    }
    return responseJson;
  }

  String mapToParamString(dynamic params) {
    String result = '?';
    params.forEach((a, b) {
      if (a == 'week' && b == '0') {
        result += '$a=$b&';
        return;
      }
      if (b != null && b != '' && (b != '0' || a == 'page')) result += '$a=$b&';
    });
    return result;
  }

  dynamic _returnResponse(client.Response response) {
    //TODO: Bikin force logout dari utilities force logout
    // switch (response.statusCode) {
    //   case 200:
    //     var responseJson = json.decode(response.body.toString());
    //     if (responseJson["acknowledge"] == false ||
    //         responseJson["status"].toString() == 'error') {
    //       if (responseJson["info"] != null) {}
    //     }
    //     return responseJson;
    //   case 400:
    //   case 401:
    //   case 403:
    //   case 413:
    //   case 500:
    //   case 502:
    //     throw SocketException('Ups, Sorry Mums. Coba lagi dong');
    //   default:
    // }

    var responseJson = json.decode(response.body.toString());
    return responseJson;
  }
}
