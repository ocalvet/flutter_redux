import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

enum Actions { Increment, Decrement }

int counterReducer(int state, dynamic action) {
  switch (action) {
    case Actions.Increment:
      return state + 1;
    case Actions.Decrement:
      return  state == 0 ? 0 : state - 1;
    default:
      return state;
  }
}

void main() {
  final store = Store<int>(counterReducer, initialState: 0);

  runApp(MyApp(
    title: 'FlutterRedux',
    store: store
  ));
}

class MyApp extends StatelessWidget {
  final Store<int> store;
  final String title;
  MyApp({Key key, this.store, this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return StoreProvider<int>(
      store: this.store,
      child: MaterialApp(
        title: this.title,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(title: 'FlutterRedux'),
      )
    );
  }
}

class MyHomePage extends StatelessWidget {
  final String title;
  MyHomePage({this.title});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('You have pushed the button this many times:'),
            StoreConnector<int, String>(
                  converter: (store) => store.state.toString(),
                  builder: (context, count) {
                    return Text('$count', style: Theme.of(context).textTheme.display1);
                  }
            )
          ],
        ),
      ),
      floatingActionButton:  StoreConnector<int, ViewModel>(
        converter: (store) {
          return ViewModel.create(store);
        },
        builder: (context, vm) {
          return 
              FloatingActionButton(
                onPressed: vm.increment,
                tooltip: 'Increment',
                child: Icon(Icons.add),
              );
        }),
    );
  }
}

class ViewModel {
  final Store _store;
  ViewModel(this._store);
  void increment() {
    this._store.dispatch(Actions.Increment);
  }
  void decrement() {
    this._store.dispatch(Actions.Decrement);
  }
  factory ViewModel.create(Store store) {
    return ViewModel(store);
  }
}