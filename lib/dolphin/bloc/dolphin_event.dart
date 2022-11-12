part of 'dolphin_bloc.dart';

abstract class DolphinEvent extends Equatable {
  const DolphinEvent();

  @override
  List<Object> get props => [];
}

class InitialApiCall extends DolphinEvent {
  @override
  List<Object> get props => [];
}

class NextImage extends DolphinEvent {
  const NextImage(this.dolphins, this.pointer);
  final List<DolphinModel> dolphins;
  final int pointer;

  @override
  List<Object> get props => [dolphins];
}

class TimerStarted extends DolphinEvent {
  const TimerStarted({required this.duration, required this.dolphins});
  final List<DolphinModel> dolphins;
  final int duration;
}

class TimerPaused extends DolphinEvent {
  const TimerPaused();
}

class TimerTicked extends DolphinEvent {
  const TimerTicked({
    required this.duration,
    required this.dolphins,
  });
  final int duration;
  final List<DolphinModel> dolphins;
  @override
  List<Object> get props => [duration];
}
