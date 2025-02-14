// 定義 Action 處理函式
import 'package:flutter/material.dart';

abstract class Action {}

abstract class State {}

typedef Processor<A extends Action> = void Function(A action);

// 定義 Middleware 類型
typedef Middleware<S extends State, A extends Action> = Processor<A> Function(
  Store<S, A> store,
  Processor<A> next,
);

// 定義 Reducer 類型
typedef Reducer<S extends State, A extends Action> = S Function(
    S state, A action);

// Redux Store 類別
class Store<S extends State, A extends Action> extends ChangeNotifier {
  S _state;
  final Reducer<S, A> _reducer;
  final List<Middleware<S, A>> _middlewares;
  late Processor<A> _dispatch;

  Store(this._state, this._reducer,
      {List<Middleware<S, A>> middlewares = const []})
      : _middlewares = middlewares {
    _dispatch = _createDispatch();
  }

  S get state => _state;

  void dispatch(A action) => _dispatch(action);

  Processor<A> _createDispatch() {
    Processor<A> baseDispatch = (A action) {
      _state = _reducer(_state, action);
      notifyListeners();
    };

    for (final middleware in _middlewares.reversed) {
      baseDispatch = middleware(this, baseDispatch);
    }

    return baseDispatch;
  }
}
