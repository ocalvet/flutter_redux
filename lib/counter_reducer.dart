import 'package:flutter_redux_example/counter_actions.dart';
import 'package:flutter_redux_example/counter_state.dart';
import 'package:redux/redux.dart';

int incrementCounter(int state, IncrementAction action) {
  return state + 1;
}

int decrementCounter(int state, DecrementAction action) {
  return state == 0 ? 0 : state - 1;
}

Reducer<int> counterReducer = combineReducers([
  TypedReducer<int, IncrementAction>(incrementCounter),
  TypedReducer<int, DecrementAction>(decrementCounter),
]);

CounterState appReducer(CounterState state, action) => 
  CounterState(counterReducer(state.counter, action));