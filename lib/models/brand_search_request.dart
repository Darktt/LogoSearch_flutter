import 'package:logo_search/models/api_key.dart';
import 'package:logo_search/models/api_name.dart';
import 'package:logo_search/models/api_request.dart';
import 'package:logo_search/models/brand_search_response.dart';
import 'package:logo_search/models/http_header.dart';

final class BrandSearchRequest extends ApiRequest<List<LogoInfo>> {
  // MARK: - Properties -

  Map<String, dynamic>? _parameters;

  @override
  APIName get apiName => APIName.seartch;

  @override
  Map<String, dynamic>? get parameters => _parameters;

  @override
  List<HttpHeader>? get headers => [
        HttpHeader.authorization(
            Authorization.token(APIKey.secretKey, AuthorizationType.bearer()))
      ];

  @override
  Uri get uri {
    Uri url = Uri.parse(apiName.url);

    if (_parameters != null) {
      url = url.replace(queryParameters: _parameters);
    }

    return url;
  }

  // - Methods -

  BrandSearchRequest(String keyword) {
    _parameters = {"q": keyword};
  }

  @override
  List<LogoInfo> responseFromJson(String json) {
    return BrandSearchResponse.decode(json);
  }
}
