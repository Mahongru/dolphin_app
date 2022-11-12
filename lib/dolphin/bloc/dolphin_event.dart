part of 'dolphin_bloc.dart';

abstract class DolphinEvent extends Equatable {
  const DolphinEvent();

  @override
  List<Object> get props => [];
}

class LoadInitialState extends DolphinEvent {
  @override
  List<Object> get props => [];
}

class Play extends DolphinEvent {
  const Play({required this.duration, required this.dolphins});
  final List<DolphinModel> dolphins;
  final int duration;
  @override
  List<Object> get props => [duration, dolphins];
}

class Pause extends DolphinEvent {
  const Pause({required this.duration, required this.dolphins});
  final List<DolphinModel> dolphins;
  final int duration;
  @override
  List<Object> get props => [duration, dolphins];
}

class Rewind extends DolphinEvent {
  const Rewind({required this.duration, required this.dolphins});
  final List<DolphinModel> dolphins;
  final int duration;
  @override
  List<Object> get props => [duration, dolphins];
}

class TimerTicked extends DolphinEvent {
  const TimerTicked({
    required this.duration,
    required this.dolphins,
  });
  final int duration;
  final List<DolphinModel> dolphins;
  @override
  List<Object> get props => [duration, dolphins];
}
