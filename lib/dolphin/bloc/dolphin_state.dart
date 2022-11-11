part of 'dolphin_bloc.dart';

abstract class DolphinState extends Equatable {
  const DolphinState();
  
  @override
  List<Object> get props => [];
}

class DolphinInitial extends DolphinState {}
