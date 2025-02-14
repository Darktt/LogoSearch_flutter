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

  // MARK: - Methods -

  LogoInfo({String? name, String? domain}) {
    _name = name;
    _domain = domain;
  }

  factory LogoInfo.fromJson(Map<String, dynamic> json) {
    return LogoInfo(
      name: json["name"],
      domain: json["domain"],
    );
  }
}
