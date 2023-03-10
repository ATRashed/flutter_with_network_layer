// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:async';
import 'dart:convert';
import 'dart:io';

// import 'package:network_layer/network_module/api_base.dart';
// import 'package:network_layer/network_module/api_exceptions.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'api_base.dart';
import 'api_exceptions.dart';

class HttpClient {
  static final HttpClient _singleton = HttpClient();

  static HttpClient get instance => _singleton;

  Future<dynamic> fetchData(String url, {Map<String, String>? params}) async {
    var responseJson;

    var uri = APIBase.baseURL +
        url +
        ((params != null) ? queryParameters(params) : "");
    var header = {HttpHeaders.contentTypeHeader: 'application/json'};
    try {
      final response = await http.get(Uri.parse(uri), headers: header);
      if (kDebugMode) {
        print(response.body.toString());
      }
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  String queryParameters(Map<String, String> params) {
    // ignore: unnecessary_null_comparison
    if (params != null) {
      final jsonString = Uri(queryParameters: params);
      return '?${jsonString.query}';
    }
    return '';
  }

  Future<dynamic> postData(String url, dynamic body) async {
    var responseJson;
    var header = {HttpHeaders.contentTypeHeader: 'application/json'};
    Uri uri = Uri.parse(APIBase.baseURL + url);
    try {
      final response = await http.post(uri, body: body, headers: header);
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  dynamic _returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body.toString());
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
