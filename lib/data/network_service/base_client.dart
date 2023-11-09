import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'app_exceptions.dart';

class BaseClient {
  static const int TIME_OUT_DURATION = 10000;

  static const String baseUrl = "https://raw.githubusercontent.com";

  final http.Client _client;

  // Private constructor
  BaseClient._(this._client);

  // Singleton instance
  static final BaseClient _singleton = BaseClient._(http.Client());

  // Factory method to get the singleton instance
  factory BaseClient() {
    return _singleton;
  }

  //GET
  Future<dynamic> get({
    required String api,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      var response = await _client.get(
        Uri.parse(
          "$baseUrl$api",
        ),
      ).timeout(
        const Duration(milliseconds: TIME_OUT_DURATION),
      );
      return _processResponse(response);
    } on SocketException {
      return Future.error('No Internet connection 😢');
    } on TimeoutException {
      return Future.error('Server Connection Timeout 😢');
    } on UnAuthorizedException {
      return Future.error('Access denied UnAuthorized Request 👎');
    } on FormatException catch (e) {
      debugPrint("error ${e.message}");
      return Future.error('Bad response format 👎');
    } catch (e) {
      return Future.error(e);
    }
  }

  //DELETE
  //OTHER

  dynamic _processResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        return jsonDecode(response.body);
      case 201:
        return jsonDecode(response.body);
      case 400:
        {
          var error = jsonDecode(response.body);
          debugPrint("in process: ${error.toString()}");
          var errorMsg = error["message"] ?? "Something went wrong";
          throw BadRequestException(errorMsg, error.toString());
        }
      case 401:
      case 403:
        throw UnAuthorizedException(
            utf8.decode(response.bodyBytes), response.request!.url.toString());
      case 422:
        throw BadRequestException(
            utf8.decode(response.bodyBytes), response.request!.url.toString());
      case 502:
        throw ServerFailedException();
      case 500:
      default:
        throw FetchDataException(
            'Error occured with code : ${response.statusCode}',
            response.request!.url.toString());
    }
  }
}
