import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_redux_example/counter_state.dart';
import 'package:flutter_redux_example/home_page.dart';
import 'package:redux/redux.dart';

class ReduxApp extends StatelessWidget {
  final Store<CounterState> store;
  final String title;
  ReduxApp({Key key, this.store, this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return StoreProvider<CounterState>(
      store: this.store,
      child: MaterialApp(
        title: this.title,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomePage(title: 'FlutterRedux'),
      )
    );
  }
}