import 'package:logo_search/redux/store.dart';
import 'package:logo_search/view_model/api_middleware.dart';
import 'package:logo_search/view_model/logo_search_action.dart';
import 'package:logo_search/view_model/logo_search_state.dart';

LogoSearchState _reducer(LogoSearchState state, dynamic action) {
  if (action is LogoSearchActionSearchResponse) {
    final logoInfos = action.logoInfos;

    state.updateLogoInfos(logoInfos);
  }

  return state;
}

typedef LogoSearchStore = Store<LogoSearchState, dynamic>;

final kLogoSearchStore =
    LogoSearchStore(LogoSearchState(), _reducer, middlewares: [
  apiMiddleware(),
]);
