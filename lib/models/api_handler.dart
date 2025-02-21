import 'dart:io';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:logo_search/models/api_request.dart';
import 'package:logo_search/models/http_exception.dart';

final class ApiHandler {
  // - Properties -

  static final ApiHandler sharedInstance = ApiHandler._();

  final HttpClient _client = HttpClient();

  // - Methods -

  ApiHandler._();

  Future<Response> sendRequest<Response>(ApiRequest<Response> request) async {
    HttpClientRequest httpRequest = await _client.getUrl(request.uri);

    // 設定 Header
    request.headers?.forEach((header) {
      httpRequest.headers.add(header.field, header.value);
    });

    HttpClientResponse httpResponse = await httpRequest.close();
    String json = await httpResponse.transform(utf8.decoder).join();
    int statusCode = httpResponse.statusCode;

    if (statusCode != 200) {
      HttpStatusCode code = HttpStatusCode.statusCode(statusCode);
      final exception = HttpException(code);

      throw exception;
    }

    logJson(json);
    Response response = request.responseFromJson(json);

    return response;
  }

  void logJson(String json) {
    if (!kDebugMode) {
      return;
    }

    debugPrint('JSON: $json');
  }
}
