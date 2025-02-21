import 'package:flutter/foundation.dart';
import 'package:logo_search/redux/store.dart';
import 'package:logo_search/models/brand_search_response.dart';
import 'package:logo_search/view_model/logo_search_error.dart';
import 'package:logo_search/models/logo_image_fallback.dart';
import 'package:logo_search/models/logo_image_format.dart';

class LogoSearchState extends State {
  // - Properties -

  bool _isQueried = false;

  bool get isQueried => _isQueried;

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

  Uint8List _imageBytes = Uint8List(0);

  Uint8List get imageBytes => _imageBytes;

  // - Methods -

  void updateLogoInfos(List<LogoInfo> logoInfos) {
    _logoInfos = logoInfos;
    _isQueried = true;
  }

  void selectedLogoInfoAt(int index) {
    _selectedLogoInfo = _logoInfos[index];
  }

  void updateImageBytes(Uint8List imageBytes) {
    _imageBytes = imageBytes;
  }
}
