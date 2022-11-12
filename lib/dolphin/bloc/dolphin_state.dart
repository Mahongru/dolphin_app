part of 'dolphin_bloc.dart';

abstract class DolphinState extends Equatable {
  final int index;
  const DolphinState(this.index);

  @override
  List<Object> get props => [index];
}

class InitialState extends DolphinState {
  const InitialState() : super(0);
}

class DataLoadedState extends DolphinState {
  final List<DolphinModel> dolphins;
  final int index;

  const DataLoadedState(this.dolphins, this.index) : super(0);
  @override
  List<Object> get props => [dolphins, index];
}

class DataErrorState extends DolphinState {
  final String error;

  const DataErrorState(this.error) : super(0);
  @override
  List<Object> get props => [error];
}

class TimerProgress extends DolphinState {
  const TimerProgress(int index) : super(index);

  @override
  List<Object> get props => [index];
}

class TimerComplete extends DolphinState {
  const TimerComplete() : super(0);
}
