import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'dolphin_event.dart';
part 'dolphin_state.dart';

class DolphinBloc extends Bloc<DolphinEvent, DolphinState> {
  DolphinBloc() : super(DolphinInitial()) {
    on<DolphinEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
