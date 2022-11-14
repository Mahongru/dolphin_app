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
  final int duration;
  final List<DolphinModel> images;
  const Play({required this.duration, required this.images});

  @override
  List<Object> get props => [duration, images];
}

class Pause extends DolphinEvent {
  final int duration;
  final List<DolphinModel> images;
  const Pause({required this.duration, required this.images});

  @override
  List<Object> get props => [duration, images];
}

class Rewind extends DolphinEvent {
  final int duration;
  final List<DolphinModel> images;
  const Rewind({required this.duration, required this.images});

  @override
  List<Object> get props => [duration, images];
}

class RewindEnd extends DolphinEvent {
  const RewindEnd();

  @override
  List<Object> get props => [];
}
