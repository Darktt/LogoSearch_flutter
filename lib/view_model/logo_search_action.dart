import 'package:logo_search/models/brand_search_request.dart';
import 'package:logo_search/models/brand_search_response.dart';

sealed class LogoSearchAction {
  const LogoSearchAction();

  const factory LogoSearchAction.search(BrandSearchRequest request) =
      LogoSearchActionSearch;

  const factory LogoSearchAction.searchResponse(List<LogoInfo> logos) =
      LogoSearchActionSearchResponse;

  const factory LogoSearchAction.fetchApiError(Exception exception) =
      LogoSearchActionFetchApiError;
}

class LogoSearchActionSearch extends LogoSearchAction {
  final BrandSearchRequest request;

  const LogoSearchActionSearch(this.request);
}

class LogoSearchActionSearchResponse extends LogoSearchAction {
  final List<LogoInfo> logos;

  const LogoSearchActionSearchResponse(this.logos);
}

class LogoSearchActionFetchApiError extends LogoSearchAction {
  final Exception exception;

  const LogoSearchActionFetchApiError(this.exception);
}
