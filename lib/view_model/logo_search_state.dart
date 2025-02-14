class LogoSearchState {
  // - Properties -

  List<int> _logos = [];

  List<int> get logos => _logos;

  // - Methods -

  void updateLogos(List<int> logos) {
    _logos = logos;
  }
}
