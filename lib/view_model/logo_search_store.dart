import 'package:logo_search/redux/store.dart';
import 'package:logo_search/view_model/logo_search_state.dart';

LogoSearchState _reducer(LogoSearchState state, dynamic action) {
  return state;
}

typedef LogoSearchStore = Store<LogoSearchState, dynamic>;

final kLogoSearchStore = LogoSearchStore(LogoSearchState(), _reducer);
