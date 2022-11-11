part of 'dolphin_bloc.dart';

abstract class DolphinState extends Equatable {
  const DolphinState(this.url);
  final String url;

  @override
  List<Object> get props => [];
}

class DolphinInitial extends DolphinState {
  const DolphinInitial(super.url);
}
