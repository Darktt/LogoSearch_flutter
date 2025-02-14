import 'package:logo_search/models/brand_search_response.dart';

class LogoSearchState {
  // - Properties -

  List<LogoInfo> _logoInfos = [];

  List<LogoInfo> get logoInfos => _logoInfos;

  // - Methods -

  void updateLogoInfos(List<LogoInfo> logoInfos) {
    _logoInfos = logoInfos;
  }
}
