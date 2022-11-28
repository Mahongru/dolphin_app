import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:dolphin_app/dolphin/dolphin.dart';

part 'dolphin_event.dart';
part 'dolphin_state.dart';

class DolphinBloc extends Bloc<DolphinEvent, DolphinState> {
  final DolphinService _dolphinService;

  DolphinBloc(this._dolphinService) : super(const InitialState('')) {
    const Ticker ticker = Ticker();
    List<String> images = [];
    int pointer = 0;

    StreamSubscription<int>? tickerSubscription;

    Future<DolphinModel> getDolphinImage() async =>
        _dolphinService.getDolphinImage();

    // --  Mock API
    Future<String> fetchImage(int pointer) =>
        Future.delayed(const Duration(microseconds: 100), () async {
          String output = 'Dolphin.$pointer';
          return output;
        });

    void streamPlay(duration) {
      tickerSubscription?.cancel();
      tickerSubscription =
          ticker.play(duration: duration).listen((duration) async {
        if (pointer == 0 && images.isEmpty) {
          // DolphinModel imageUrl = await getDolphinImage();
          // images.add(imageUrl.url);
          String imageUrl = await fetchImage(pointer);
          images.add(imageUrl);
          pointer++;
          add(const Play());
        }
        if (images.isNotEmpty) {
          if (pointer == images.length && pointer < 5) {
            // DolphinModel imageUrl = await getDolphinImage();
            // images.add(imageUrl.url);
            String imageUrl = await fetchImage(pointer);
            images.add(imageUrl);
            pointer++;
            add(const Play());
          } else if (pointer == 5) {
            // DolphinModel imageUrl = await getDolphinImage();
            // images.removeAt(0);
            // images.add(imageUrl.url);
            String imageUrl = await fetchImage(pointer);
            images.removeAt(0);
            images.add(imageUrl);
            pointer = 5;
            add(const Play());
          } else {
            pointer++;
            add(const Play());
          }
        }
      });
    }

    void streamRewind(duration) {
      tickerSubscription?.cancel();
      tickerSubscription =
          ticker.rewind(duration: duration).listen((duration) async {
        if (pointer == 1) {
          add(const RewindEnd());
        } else {
          pointer--;
          add(const Rewind());
        }
      });
    }

    on<LoadInitialState>((event, emit) async {
      streamPlay(pointer);
    });

    on<Play>((event, emit) async {
      emit(PlayState(images[pointer - 1]));
      streamPlay(pointer);
    });

    on<Pause>((event, emit) {
      tickerSubscription?.pause();
      emit(PauseState(images[pointer - 1]));
    });

    on<Rewind>((event, emit) async {
      emit(RewindState(images[pointer - 1]));
      streamRewind(pointer);
    });

    on<RewindEnd>((event, emit) async {
      emit(const StopState());
    });
  }
}

class Ticker {
  const Ticker();
  Stream<int> play({required int duration}) {
    if (duration == 0) {
      return Stream.periodic(const Duration(seconds: 2), (x) => x + 1);
    } else {
      return Stream.periodic(const Duration(seconds: 2), (x) => x)
          .take(duration);
    }
  }

  Stream<int> rewind({required int duration}) {
    return Stream.periodic(const Duration(seconds: 2), (x) => x - 1)
        .take(duration);
  }
}
