import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
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

    on<LoadInitialState>((event, emit) async {
      try {
        List<DolphinModel> dolphins = await _dolphinService.getDolphinImages();

        emit(ProgressPaused(duration, dolphins));
      } catch (error) {
        emit(ErrorState(error.toString()));
      }
    });

    on<Pause>((event, emit) {
      if (state is InProgress) {
        tickerSubscription?.pause();
        emit(ProgressPaused(state.duration, event.dolphins));
      }
    });

    on<Play>((event, emit) {
      emit(InProgress(event.duration, event.dolphins));
      tickerSubscription?.cancel();
      tickerSubscription = ticker.tick(ticks: event.duration).listen(
          (duration) =>
              add(TimerTicked(duration: duration, dolphins: event.dolphins)));
    });

    on<Rewind>((event, emit) {
      emit(InProgress(event.duration, event.dolphins));
      tickerSubscription?.cancel();
      tickerSubscription = ticker.reverseTick(ticks: event.duration).listen(
          (duration) =>
              add(TimerTicked(duration: duration, dolphins: event.dolphins)));
    });

    on<TimerTicked>((event, emit) {
      emit(event.duration < 0
          ? const Complete()
          : InProgress(event.duration, event.dolphins));
    });

    @override
    Future<void> close() {
      tickerSubscription?.cancel();
      return super.close();
    }
  }
}
