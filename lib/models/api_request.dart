import 'package:logo_search/models/api_name.dart';
import 'package:logo_search/models/http_header.dart';

abstract class ApiRequest<Response> {
  // Properties

  APIName get apiName;

  Map<String, dynamic>? get parameters;

  List<HttpHeader>? get headers;

  Uri get uri;

  // Methods

  Response responseFromJson(String json);
}
