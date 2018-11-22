import 'package:flutter/material.dart';
import 'package:flutter_redux_example/counter_state.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

enum Actions { Increment, Decrement }

CounterState counterReducer(CounterState state, dynamic action) {
  switch (action) {
    case Actions.Increment:
      return CounterState(counter: state.counter + 1);
    case Actions.Decrement:
      return  state.counter == 0 ? state : CounterState(counter: state.counter - 1);
    default:
      return state;
  }
}

void main() {
  final store = Store<CounterState>(counterReducer, initialState: CounterState(counter: 0));

  runApp(MyApp(
    title: 'FlutterRedux',
    store: store
  ));
}

class MyApp extends StatelessWidget {
  final Store<CounterState> store;
  final String title;
  MyApp({Key key, this.store, this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return StoreProvider<CounterState>(
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
            StoreConnector<CounterState, String>(
                  converter: (store) => store.state.counter.toString(),
                  builder: (context, count) {
                    return Text('$count', style: Theme.of(context).textTheme.display1);
                  }
            )
          ],
        ),
      ),
      floatingActionButton:  StoreConnector<CounterState, ViewModel>(
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