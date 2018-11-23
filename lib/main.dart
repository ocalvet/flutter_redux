import 'package:flutter/material.dart';
import 'package:flutter_redux_example/redux_app.dart';
import 'package:flutter_redux_example/counter_state.dart';
import 'package:redux/redux.dart';
import 'counter_reducer.dart';

void main() {
  final store = Store<CounterState>(counterReducer, initialState: CounterState(counter: 0));
  runApp(ReduxApp(
    title: 'FlutterRedux',
    store: store
  ));
}
