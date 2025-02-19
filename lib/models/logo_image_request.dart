import 'package:logo_search/models/api_key.dart';
import 'package:logo_search/models/api_name.dart';
import 'package:logo_search/models/logo_image_fallback.dart';
import 'package:logo_search/models/logo_image_format.dart';

final class LogoImageRequest {
  double size = 128.0;

  LogoImageFormat format = LogoImageFormat.jpg;

  bool isGreyscale = false;

  bool isRetina = false;

  LogoImageFallback fallback = LogoImageFallback.monogram;

  final APIName apiName;

  String get url {
    Map<String, dynamic> queryParameters = {
      'token': APIKey.publicKey,
      'size': '${size.toInt()}',
    };

    if (format == LogoImageFormat.png) {
      queryParameters['format'] = format.description;
    }

    if (isGreyscale) {
      queryParameters['greyscale'] = 'true';
    }

    if (isRetina) {
      queryParameters['retina'] = 'true';
    }

    if (fallback != LogoImageFallback.monogram) {
      queryParameters['fallback'] = fallback.description;
    }

    Uri uri = Uri.parse(apiName.url).replace(queryParameters: queryParameters);

    return uri.toString();
  }

  static LogoImageRequest image(String domain) =>
      LogoImageRequest._(apiName: APIName.image(domain));

  LogoImageRequest._({required this.apiName});
}
