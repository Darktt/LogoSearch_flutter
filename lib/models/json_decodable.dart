import 'dart:convert';

/// JsonDecodable 通用接口
abstract class JsonDecodable {
  /// 從 JSON 解析對應物件
  static T decode<T extends JsonDecodable>(
      String json, T Function(dynamic) fromJson) {
    final dynamic jsonData = jsonDecode(json);
    return fromJson(jsonData);
  }
}
