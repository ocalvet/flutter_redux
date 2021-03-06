import 'package:flutter_redux_example/counter_actions.dart';
import 'package:redux/redux.dart';

class ViewModel {
  final Store _store;
  ViewModel(this._store);
  void increment() {
    this._store.dispatch(IncrementAction());
  }
  void decrement() {
    this._store.dispatch(DecrementAction());
  }
  factory ViewModel.create(Store store) {
    return ViewModel(store);
  }
}