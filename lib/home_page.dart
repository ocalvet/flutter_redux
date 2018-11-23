 import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_redux_example/counter_state.dart';
import 'package:flutter_redux_example/view_model.dart';

class HomePage extends StatelessWidget {
  final String title;
  HomePage({this.title});
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