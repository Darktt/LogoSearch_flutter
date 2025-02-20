import 'dart:typed_data';

import 'package:logo_search/models/brand_search_request.dart';
import 'package:logo_search/models/brand_search_response.dart';
import 'package:logo_search/models/logo_image_request.dart';
import 'package:logo_search/redux/store.dart';
import 'package:logo_search/view_model/logo_search_error.dart';

sealed class LogoSearchAction extends Action {
  final dynamic content;

  LogoSearchAction(this.content);

  static LogoSearchAction search(BrandSearchRequest content) =>
      LogoSearchActionSearch(content);

  static LogoSearchAction searchResponse(List<LogoInfo> content) =>
      LogoSearchActionSearchResponse(content);

  static LogoSearchAction fetchApiException(Exception content) =>
      LogoSearchActionFetchApiException(content);

  static LogoSearchAction error(LogoSearchError content) =>
      LogoSearchActionError(content);

  static LogoSearchAction imageRequest(LogoImageRequest content) =>
      LogoSearchActionImageRequest(content);

  static LogoSearchAction imageResponse(Uint8List? content) =>
      LogoSearchActionImageResponse(content);
}

class LogoSearchActionSearch extends LogoSearchAction {
  @override
  BrandSearchRequest get content => super.content as BrandSearchRequest;

  LogoSearchActionSearch(super.content);
}

class LogoSearchActionSearchResponse extends LogoSearchAction {
  @override
  List<LogoInfo> get content => super.content as List<LogoInfo>;

  LogoSearchActionSearchResponse(super.content);
}

class LogoSearchActionFetchApiException extends LogoSearchAction {
  @override
  Exception get content => super.content as Exception;

  LogoSearchActionFetchApiException(super.content);
}

class LogoSearchActionError extends LogoSearchAction {
  @override
  LogoSearchError get content => super.content as LogoSearchError;

  LogoSearchActionError(super.content);
}

class LogoSearchActionImageRequest extends LogoSearchAction {
  @override
  LogoImageRequest get content => super.content as LogoImageRequest;

  LogoSearchActionImageRequest(super.content);
}

class LogoSearchActionImageResponse extends LogoSearchAction {
  @override
  Uint8List? get content => super.content as Uint8List;

  LogoSearchActionImageResponse(super.content);
}
