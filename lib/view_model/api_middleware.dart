import 'package:logo_search/models/api_handler.dart';
import 'package:logo_search/redux/store.dart';
import 'package:logo_search/view_model/logo_search_action.dart';

Middleware<S, A> apiMiddleware<S, A>() {
  return (Store<S, A> store, Processor<A> next) {
    return (A action) {
      if (action is LogoSearchActionSearch) {
        _searchRequest(action).then((aciton) {
          next(action);
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
      await apiHandler.sendRequest(action.request).then((response) {
    LogoSearchAction newAction = LogoSearchAction.searchResponse(response);

    return newAction;
  }).catchError((error) {
    LogoSearchAction newAction = LogoSearchAction.fetchApiError(error);

    return newAction;
  });

  return newAction;
}
