import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:dolphin_app/dolphin/dolphin.dart';

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
      tickerSubscription = ticker
          .play(ticks: duration)
          .listen((duration) => add(Play(duration: duration, images: images)));
    }

    void streamRewind(duration, images) {
      tickerSubscription?.cancel();
      tickerSubscription = ticker.rewind(ticks: duration).listen(
          (duration) => add(Rewind(duration: duration, images: images)));
    }

    on<LoadInitialState>((event, emit) async {
      try {
        List<DolphinModel> newImages = await getDolphinImages();
        add(Play(duration: defaultDuration, images: newImages));
      } catch (error) {
        emit(ErrorState(error.toString()));
      }
    });

    on<Pause>((event, emit) {
      emit(PauseState(event.duration, event.images));
      tickerSubscription?.pause();
    });

    on<Play>((event, emit) {
      if (event.duration == 0) {
        add(const LoadInitialState());
      } else {
        emit(PlayState(event.duration, event.images));
        streamPlay(event.duration, event.images);
      }
    });

    on<Rewind>((event, emit) {
      if (event.duration > 5) {
        add(const RewindEnd());
      } else {
        emit(RewindState(event.duration, event.images));
        streamRewind(event.duration, event.images);
      }
    });

    on<RewindEnd>((event, emit) {
      emit(const RewindEndState());
      tickerSubscription?.cancel();
    });
  }
}

class Ticker {
  const Ticker();
  Stream<int> play({required int ticks}) {
    return Stream.periodic(const Duration(seconds: 2), (x) => ticks - x - 1)
        .take(ticks);
  }

  Stream<int> rewind({required int ticks}) {
    return Stream.periodic(const Duration(seconds: 2), (x) => ticks + x + 1)
        .take(ticks);
  }
}
