part of 'counter_cubit.dart';

// Equatable overrides the equal operator so it will compare
// the values instead of pointers to memory locations.
class CounterState extends Equatable {
  int counterValue;
  bool wasIncremented;

  CounterState({
    @required this.counterValue,
    this.wasIncremented,
  });

  @override
  List<Object> get props => [this.counterValue, this.wasIncremented];
}
