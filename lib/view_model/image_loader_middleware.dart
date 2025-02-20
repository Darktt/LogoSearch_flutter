import 'package:http/http.dart' as http;
import 'package:logo_search/models/http_exception.dart';
import 'package:logo_search/redux/store.dart';
import 'package:logo_search/view_model/logo_search_action.dart';
import 'package:logo_search/view_model/logo_search_state.dart';

Middleware<LogoSearchState, LogoSearchAction> imageLoaderMiddleware<
    S extends LogoSearchState, A extends LogoSearchAction>() {
  return (Store<LogoSearchState, LogoSearchAction> store,
      Processor<LogoSearchAction> next) {
    return (LogoSearchAction action) {
      if (action is LogoSearchActionImageRequest) {
        _imageRequest(action).then((newAction) {
          next(newAction);
        });
      }

      next(action);
    };
  };
}

Future<LogoSearchAction> _imageRequest(
    LogoSearchActionImageRequest action) async {
  final uri = Uri.parse(action.content.url);
  final response = await http.get(uri);
  final statusCode = response.statusCode;
  if (statusCode != 200) {
    HttpStatusCode code = HttpStatusCode.statusCode(statusCode);
    final exception = HttpException(code);

    LogoSearchAction newAction = LogoSearchAction.fetchApiException(exception);

    return newAction;
  }

  final bodyBytes = response.bodyBytes;
  LogoSearchAction newAction = LogoSearchAction.imageResponse(bodyBytes);

  return newAction;
}
