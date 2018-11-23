import 'package:flutter_redux_example/counter_actions.dart';
import 'package:flutter_redux_example/counter_state.dart';

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