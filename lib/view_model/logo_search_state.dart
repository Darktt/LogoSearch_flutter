import 'package:logo_search/redux/store.dart';
import 'package:logo_search/models/brand_search_response.dart';
import 'package:logo_search/view_model/logo_search_error.dart';

class LogoSearchState extends State {
  // - Properties -

  List<LogoInfo> _logoInfos = [];

  List<LogoInfo> get logoInfos => _logoInfos;

  LogoSearchError? error;

  // - Methods -

  void updateLogoInfos(List<LogoInfo> logoInfos) {
    _logoInfos = logoInfos;
  }
}
