part of 'dolphin_bloc.dart';

abstract class DolphinState extends Equatable {
  const DolphinState();

  @override
  List<Object> get props => [];
}

class InitialState extends DolphinState {
  final String imageUrl;
  const InitialState(this.imageUrl);

  @override
  List<Object> get props => [imageUrl];
}

class ErrorState extends DolphinState {
  final String error;
  const ErrorState(this.error);

  @override
  List<Object> get props => [error];
}

class PlayState extends DolphinState {
  final String imageUrl;

  const PlayState(this.imageUrl);

  @override
  List<Object> get props => [imageUrl];
}

class PauseState extends DolphinState {
  final String imageUrl;
  const PauseState(this.imageUrl);

  @override
  List<Object> get props => [imageUrl];
}

class RewindState extends DolphinState {
  final String imageUrl;
  const RewindState(this.imageUrl);

  @override
  List<Object> get props => [imageUrl];
}

class StopState extends DolphinState {
  const StopState();

  @override
  List<Object> get props => [];
}
