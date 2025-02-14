import 'dart:convert';
import 'package:logo_search/models/json_decodable.dart';

final class BrandSearchResponse {
  BrandSearchResponse._();

  static List<LogoInfo> decode(String json) {
    final List<dynamic> jsonData = jsonDecode(json);
    return jsonData.map((dynamic data) => LogoInfo.fromJson(data)).toList();
  }
}

final class LogoInfo extends JsonDecodable {
  // MARK: - Properties -

  String? _name;

  String? get name => _name;

  String? _domain;

  String? get domain => _domain;

  String? _imageUrl;

  String? get imageUrl => _imageUrl;

  // MARK: - Methods -

  LogoInfo({String? name, String? domain, String? imageUrl}) {
    _name = name;
    _domain = domain;
    _imageUrl = imageUrl;
  }

  factory LogoInfo.fromJson(Map<String, dynamic> json) {
    final String? name = () {
      if (json["name"] is String) {
        return json["name"] as String;
      }

      return null;
    }();
    final String? domain = () {
      if (json["domain"] is String) {
        return json["domain"] as String;
      }

      return null;
    }();
    final String? imageUrl = () {
      if (json["logo_url"] is String) {
        return json["logo_url"] as String;
      }

      return null;
    }();

    return LogoInfo(
      name: name,
      domain: domain,
      imageUrl: imageUrl,
    );
  }
}
