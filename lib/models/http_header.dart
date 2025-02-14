import 'dart:convert';

final class HttpHeader {
  // - Properties -

  final String field;

  final String value;

  // - Methods -
  static HttpHeader accept(String value) {
    final header = HttpHeader._(field: 'Accept', value: value);

    return header;
  }

  static HttpHeader acceptCharset(String value) {
    final header = HttpHeader._(field: 'Accept-Charset', value: value);

    return header;
  }

  // acceptEncoding
  static HttpHeader acceptEncoding(String value) {
    final header = HttpHeader._(field: 'Accept-Encoding', value: value);

    return header;
  }

  // acceptLanguage
  static HttpHeader acceptLanguage(String value) {
    final header = HttpHeader._(field: 'Accept-Language', value: value);

    return header;
  }

  // authorization
  static HttpHeader authorization(Authorization authorization) {
    final header =
        HttpHeader._(field: 'Authorization', value: authorization.value);

    return header;
  }

  // contentDisposition
  static HttpHeader contentDisposition(String value, String? filename) {
    if (filename != null) {
      value = '$value; filename="$filename"';
    }
    final header = HttpHeader._(field: 'Content-Disposition', value: value);

    return header;
  }

  // contentType
  static HttpHeader contentType(String value) {
    final header = HttpHeader._(field: 'Content-Type', value: value);

    return header;
  }

  // userAgent
  static HttpHeader userAgent(String value) {
    final header = HttpHeader._(field: 'User-Agent', value: value);

    return header;
  }

  HttpHeader._({required this.field, required this.value});

  Map<String, String> toMap() {
    return {field: value};
  }
}

final header =
    HttpHeader.authorization(Authorization.userName("username", "password"));

// Authorization

class Authorization {
  final String value;

  const Authorization(this.value);

  static Authorization userName(String username, String password) {
    final credentials = '$username:$password';
    final token = base64.encode(utf8.encode(credentials));

    return Authorization.token(token, AuthorizationType.basic());
  }

  static Authorization token(String token, AuthorizationType type) {
    final credential = '${type.description} $token';

    return Authorization(credential);
  }
}

// AuthorizationType

sealed class AuthorizationType {
  // - Properties -
  String get description;

  // - Methods -
  const AuthorizationType();

  /// Base64-encoded credentials (RFC 7617)
  factory AuthorizationType.basic() = BasicAuthorization;

  /// OAuth 2.0 Bearer Token (RFC 6750)
  factory AuthorizationType.bearer() = BearerAuthorization;

  /// Digest Authentication (RFC 7616)
  factory AuthorizationType.digest() = DigestAuthorization;

  /// HTTP Origin-Bound Authentication (RFC 7486)
  factory AuthorizationType.hoba() = HobaAuthorization;

  /// Mutual Authentication (RFC 8120)
  factory AuthorizationType.mutual() = MutualAuthorization;

  /// AWS Signature Authorization (AWS docs)
  factory AuthorizationType.awsSignature() = AwsSignatureAuthorization;

  /// Custom authorization type
  factory AuthorizationType.custom(String otherType) = CustomAuthorization;
}

/// 定義各種授權類型的具體類別
class BasicAuthorization extends AuthorizationType {
  @override
  String get description => 'Basic';
}

class BearerAuthorization extends AuthorizationType {
  @override
  String get description => 'Bearer';
}

class DigestAuthorization extends AuthorizationType {
  @override
  String get description => 'Digest';
}

class HobaAuthorization extends AuthorizationType {
  @override
  String get description => 'Hoba';
}

class MutualAuthorization extends AuthorizationType {
  @override
  String get description => 'Mutual';
}

class AwsSignatureAuthorization extends AuthorizationType {
  @override
  String get description => 'AWS4-HMAC-SHA256';
}

/// 自訂授權類型
class CustomAuthorization extends AuthorizationType {
  final String otherType;

  @override
  String get description => otherType;

  CustomAuthorization(this.otherType);
}
