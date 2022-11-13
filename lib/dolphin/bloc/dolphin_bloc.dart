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
    const int defaultDuration = 5;

    StreamSubscription<int>? tickerSubscription;

    Future<List<DolphinModel>> getDolphinImages() async =>
        _dolphinService.getDolphinImages();

    void streamPlay(duration, images) {
      tickerSubscription?.cancel();
      tickerSubscription = ticker.tick(ticks: duration).listen(
          (duration) => add(TimerTicked(duration: duration, images: images)));
    }

    void streamRewind(duration, images) {
      tickerSubscription?.cancel();
      tickerSubscription = ticker.reverseTick(ticks: duration).listen(
          (duration) => add(TimerTicked(duration: duration, images: images)));
    }

    on<LoadInitialState>((event, emit) async {
      try {
        List<DolphinModel> newImages = await getDolphinImages();

        emit(PlayState(defaultDuration, newImages));
        streamPlay(defaultDuration, newImages);
      } catch (error) {
        emit(ErrorState(error.toString()));
      }
    });

    on<Pause>((event, emit) {
      tickerSubscription?.pause();
      emit(PauseState(event.duration, event.images));
    });

    on<Play>((event, emit) {
      emit(PlayState(event.duration, event.images));
      streamPlay(event.duration, event.images);
    });

    on<Rewind>((event, emit) {
      emit(RewindState(event.duration, event.images));
      streamRewind(event.duration, event.images);
    });

    on<RewindEnd>((event, emit) {
      tickerSubscription?.cancel();
      emit(const RewindEndState());
    });

    on<TimerTicked>((event, emit) async {
      if (state is PlayState) {
        if (event.duration == 0) {
          add(const LoadInitialState());
        } else {
          emit(PlayState(event.duration, event.images));
        }
      }
      if (state is RewindState) {
        if (event.duration > 5) {
          add(const RewindEnd());
        } else {
          emit(RewindState(event.duration, event.images));
        }
      }
    });
  }
}
