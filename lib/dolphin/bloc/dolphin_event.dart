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
