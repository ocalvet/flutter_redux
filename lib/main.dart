import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

enum Actions { Increment, Decrement }

int counterReducer(int state, dynamic action) {
  if (action == Actions.Increment) {
    return state + 1;
  } else if (action == Actions.Decrement) {
    return  state == 0 ? 0 : state - 1;
  }
  return state;
}

void main() {
  final store = new Store<int>(counterReducer, initialState: 0);

  runApp(new MyApp(
    title: 'Flutter Redux Example',
    store: store
  ));
}

class MyApp extends StatelessWidget {
  final Store<int> store;
  final String title;

  MyApp({Key key, this.store, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new StoreProvider<int>(
      store: this.store,
      child: new MaterialApp(
        title: this.title,
        theme: new ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: new MyHomePage(title: 'Flutter Demo Home Page'),
      )
    );
  }
}

class MyHomePage extends StatelessWidget {
  final String title;
  MyHomePage({this.title});

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(this.title),
      ),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text('You have pushed the button this many times:'),
            new StoreConnector<int, String>(
                  converter: (store) => store.state.toString(),
                  builder: (context, count) {
                    return new Text('$count', style: Theme.of(context).textTheme.display1);
                  }
            )
          ],
        ),
      ),
      floatingActionButton:  new StoreConnector<int, ViewModel>(
        converter: (store) {
          return ViewModel.create(store);
        },
        builder: (context, vm) {
          return Column(
            verticalDirection: VerticalDirection.down,
            children: <Widget>[
              FloatingActionButton(
                onPressed: vm.increment,
                tooltip: 'Increment',
                child: new Icon(Icons.add),
              ),
              FloatingActionButton(
                onPressed: vm.decrement,
                tooltip: 'Decrement',
                child: new Icon(Icons.remove),
              ),
            ]
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