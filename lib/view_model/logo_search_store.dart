import 'package:logo_search/redux/store.dart';
import 'package:logo_search/view_model/api_middleware.dart';
import 'package:logo_search/view_model/logo_search_action.dart';
import 'package:logo_search/view_model/logo_search_state.dart';

LogoSearchState _reducer(LogoSearchState state, LogoSearchAction action) {
  state.error = null;

  if (action is LogoSearchActionSearchResponse) {
    final logoInfos = action.content;

    state.updateLogoInfos(logoInfos);
  }

  if (action is LogoSearchActionError) {
    state.error = action.content;
  }

  return state;
}

typedef LogoSearchStore = Store<LogoSearchState, LogoSearchAction>;

final kLogoSearchStore =
    LogoSearchStore(LogoSearchState(), _reducer, middlewares: [
  apiMiddleware(),
]);
