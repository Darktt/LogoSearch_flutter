final class APIName {
  // - Properties -

  static APIName seartch = APIName._(url: 'https://api.logo.dev/search');

  final String url;

  // - Methods -
  static APIName image(String domain) {
    String url = 'https://img.logo.dev/$domain';

    return APIName._(url: url);
  }

  APIName._({required this.url});
}
