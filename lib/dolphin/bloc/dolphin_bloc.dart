import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:dolphin_app/dolphin/dolphin.dart';
import 'package:dolphin_app/ticker.dart';

part 'dolphin_event.dart';
part 'dolphin_state.dart';

class DolphinBloc extends Bloc<DolphinEvent, DolphinState> {
  final DolphinService _dolphinService;

  DolphinBloc(this._dolphinService) : super(const InitialState()) {
    const Ticker ticker = Ticker();
    const int duration = 4;

    StreamSubscription<int>? tickerSubscription;

    on<InitialApiCall>((event, emit) async {
      try {
        List<DolphinModel> dolphins = await _dolphinService.getDolphinImages();
        emit(DataLoadedState(dolphins, 0));
      } catch (error) {
        emit(DataErrorState(error.toString()));
      }
    });
    on<NextImage>((event, emit) {
      if (event.pointer > 4) {
        emit(const DataErrorState('No more dolphins'));
      } else {
        int idx = event.pointer + 1;
        emit(DataLoadedState(event.dolphins, idx));
      }
    });
    on<TimerStarted>((event, emit) {
      emit(TimerProgress(event.duration, event.dolphins));
      tickerSubscription?.cancel();
      tickerSubscription = ticker.tick(ticks: event.duration).listen(
          (duration) =>
              add(TimerTicked(duration: duration, dolphins: event.dolphins)));
    });
    on<TimerTicked>((event, emit) {
      emit(event.duration < 0
          ? const TimerComplete()
          : TimerProgress(event.duration, event.dolphins));
    });

    @override
    Future<void> close() {
      tickerSubscription?.cancel();
      return super.close();
    }
  }
}
