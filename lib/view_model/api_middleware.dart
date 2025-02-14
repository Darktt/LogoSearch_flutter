import 'package:logo_search/models/api_handler.dart';
import 'package:logo_search/redux/store.dart';
import 'package:logo_search/view_model/logo_search_action.dart';
import 'package:logo_search/view_model/logo_search_state.dart';

Middleware<LogoSearchState, LogoSearchAction>
    apiMiddleware<S extends LogoSearchState, A extends LogoSearchAction>() {
  return (Store<LogoSearchState, LogoSearchAction> store,
      Processor<LogoSearchAction> next) {
    return (LogoSearchAction action) {
      if (action is LogoSearchActionSearch) {
        _searchRequest(action).then((newAction) {
          next(newAction);
        });

        return;
      }

      next(action);
    };
  };
}

Future<LogoSearchAction> _searchRequest(LogoSearchActionSearch action) async {
  ApiHandler apiHandler = ApiHandler.sharedInstance;
  LogoSearchAction newAction =
      await apiHandler.sendRequest(action.content).then((response) {
    LogoSearchAction newAction = LogoSearchAction.searchResponse(response);

    return newAction;
  }).catchError((error) {
    LogoSearchAction newAction = LogoSearchAction.fetchApiException(error);

    return newAction;
  });

  return newAction;
}
