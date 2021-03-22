import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'counter_state.dart';

class CounterCubit extends Cubit<CounterState> {
  CounterCubit() : super(CounterState(counterValue: 0));

  // add 1 to current counterValue
  void increment() => emit(CounterState(counterValue: state.counterValue + 1));

  // subtract 1 from current counterValue
  void decrement() => emit(CounterState(counterValue: state.counterValue - 1));
}
