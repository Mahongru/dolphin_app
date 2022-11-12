part of 'dolphin_bloc.dart';

abstract class DolphinState extends Equatable {
  final int duration;
  const DolphinState(this.duration);

  @override
  List<Object> get props => [duration];
}

class InitialState extends DolphinState {
  const InitialState() : super(0);
}

class ErrorState extends DolphinState {
  final String error;

  const ErrorState(this.error) : super(0);
  @override
  List<Object> get props => [error];
}

class InProgress extends DolphinState {
  final List<DolphinModel> dolphins;
  const InProgress(int duration, this.dolphins) : super(duration);

  @override
  List<Object> get props => [duration, dolphins];
}

class ProgressPaused extends DolphinState {
  final List<DolphinModel> dolphins;
  const ProgressPaused(int duration, this.dolphins) : super(duration);
  @override
  List<Object> get props => [duration, dolphins];
}

class Complete extends DolphinState {
  const Complete() : super(-1);
}
