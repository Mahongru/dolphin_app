import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:new_app/dolphin/dolphin.dart';

part 'dolphin_event.dart';
part 'dolphin_state.dart';

class DolphinBloc extends Bloc<DolphinEvent, DolphinState> {
  final DolphinService _dolphinService;

  DolphinBloc(this._dolphinService) : super(const InitialState()) {
    on<InitialApiCall>((event, emit) async {
      DolphinModel response = await _dolphinService.getDolphinImage();

      emit(DataLoadedState(
          id: response.id,
          regularLink: response.regularLink,
          urls: response.urls));
    });
  }
}
