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

class PlayState extends DolphinState {
  final List<DolphinModel> dolphins;
  const PlayState(int duration, this.dolphins) : super(duration);

  @override
  List<Object> get props => [duration, dolphins];
}

class PauseState extends DolphinState {
  final List<DolphinModel> dolphins;
  const PauseState(int duration, this.dolphins) : super(duration);
  @override
  List<Object> get props => [duration, dolphins];
}

class RewindState extends DolphinState {
  final List<DolphinModel> dolphins;
  const RewindState(int duration, this.dolphins) : super(duration);

  @override
  List<Object> get props => [duration, dolphins];
}

class RewindEndState extends DolphinState {
  const RewindEndState() : super(0);

  @override
  List<Object> get props => [];
}
