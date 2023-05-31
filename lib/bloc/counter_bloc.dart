import 'counter_event.dart';
import 'counter_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(const CounterState(count: 0)) {
    on<Increment>((event, emit) => emit(CounterState(count: state.count + 1)));
    on<Decrement>((event, emit) => emit(CounterState(count: state.count - 1)));
    on<Reset>((event, emit) => emit(const CounterState(count: 0)));
  }
}
