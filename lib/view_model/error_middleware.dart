import 'package:logo_search/redux/store.dart';
import 'package:logo_search/models/http_exception.dart';
import 'package:logo_search/view_model/logo_search_action.dart';
import 'package:logo_search/view_model/logo_search_state.dart';
import 'package:logo_search/view_model/logo_search_error.dart';

Middleware<LogoSearchState, LogoSearchAction>
    errorMiddleware<S extends LogoSearchState, A extends LogoSearchAction>() {
  return (Store<LogoSearchState, LogoSearchAction> store,
      Processor<LogoSearchAction> next) {
    return (LogoSearchAction action) {
      if (action is LogoSearchActionFetchApiException) {
        LogoSearchAction newAction = _parseException(action);

        next(newAction);
        return;
      }

      next(action);
    };
  };
}

LogoSearchAction _parseException(LogoSearchActionFetchApiException action) {
  final exception = action.content;

  if (exception is HttpException) {
    LogoSearchError error = (exception.statusCode.code, exception.message);

    return LogoSearchAction.error(error);
  }

  LogoSearchError error = (-1, 'Unknown error');

  return LogoSearchAction.error(error);
}
