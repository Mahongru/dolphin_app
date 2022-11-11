part of 'dolphin_bloc.dart';

abstract class DolphinState extends Equatable {
  const DolphinState();

  @override
  List<Object> get props => [];
}

class InitialState extends DolphinState {
  const InitialState();
}

class DataLoadedState extends DolphinState {
  final String id;
  final String regularLink;
  final Map urls;

  const DataLoadedState(
      {required this.id, required this.regularLink, required this.urls});
  @override
  List<Object> get props => [id, regularLink, urls];
}
