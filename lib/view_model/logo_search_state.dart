import 'package:logo_search/redux/store.dart';
import 'package:logo_search/models/brand_search_response.dart';
import 'package:logo_search/view_model/logo_search_error.dart';
import 'package:logo_search/models/logo_image_fallback.dart';
import 'package:logo_search/models/logo_image_format.dart';

class LogoSearchState extends State {
  // - Properties -

  List<LogoInfo> _logoInfos = [];

  List<LogoInfo> get logoInfos => _logoInfos;

  LogoSearchError? error;

  LogoInfo? _selectedLogoInfo;

  LogoInfo? get selectedLogoInfo => _selectedLogoInfo;

  double size = 180.0;

  bool isGreyscale = false;

  bool isRetina = false;

  LogoImageFormat format = LogoImageFormat.jpg;

  LogoImageFallback fallback = LogoImageFallback.monogram;

  // - Methods -

  void updateLogoInfos(List<LogoInfo> logoInfos) {
    _logoInfos = logoInfos;
  }

  void selectedLogoInfoAt(int index) {
    _selectedLogoInfo = _logoInfos[index];
  }
}
