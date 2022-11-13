part of 'dolphin_bloc.dart';

abstract class DolphinEvent extends Equatable {
  const DolphinEvent();

  @override
  List<Object> get props => [];
}

class LoadInitialState extends DolphinEvent {
  const LoadInitialState();

  @override
  List<Object> get props => [];
}

class Play extends DolphinEvent {
  const Play({required this.duration, required this.images});
  final List<DolphinModel> images;
  final int duration;
  @override
  List<Object> get props => [duration, images];
}

class Pause extends DolphinEvent {
  const Pause({required this.duration, required this.images});
  final List<DolphinModel> images;
  final int duration;
  @override
  List<Object> get props => [duration, images];
}

class Rewind extends DolphinEvent {
  const Rewind({required this.duration, required this.images});
  final List<DolphinModel> images;
  final int duration;
  @override
  List<Object> get props => [duration, images];
}

class RewindEnd extends DolphinEvent {
  const RewindEnd();

  @override
  List<Object> get props => [];
}

class TimerTicked extends DolphinEvent {
  const TimerTicked({
    required this.duration,
    required this.images,
  });
  final int duration;
  final List<DolphinModel> images;
  @override
  List<Object> get props => [duration, images];
}
