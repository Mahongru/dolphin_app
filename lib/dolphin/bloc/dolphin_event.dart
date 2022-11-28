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
  const Play();

  @override
  List<Object> get props => [];
}

class Pause extends DolphinEvent {
  const Pause();

  @override
  List<Object> get props => [];
}

class Rewind extends DolphinEvent {
  const Rewind();

  @override
  List<Object> get props => [];
}

class RewindEnd extends DolphinEvent {
  const RewindEnd();

  @override
  List<Object> get props => [];
}
