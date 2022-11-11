import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'dolphin_event.dart';
part 'dolphin_state.dart';

class DolphinBloc extends Bloc<DolphinEvent, DolphinState> {
  DolphinBloc() : super(const DolphinInitial(_url)) {
    on<DolphinEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
  static const String _url =
      'https://images.unsplash.com/photo-1584956861158-bfacdddce445?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwzNzY4MDd8MHwxfHJhbmRvbXx8fHx8fHx8fDE2NjgxNzYwMzA&ixlib=rb-4.0.3&q=80&w=400';
}
