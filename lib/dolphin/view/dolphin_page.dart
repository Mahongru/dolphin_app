import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dolphin_app/dolphin/dolphin.dart';

part 'widgets/background.dart';

class DolphinPage extends StatelessWidget {
  const DolphinPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) =>
            DolphinBloc(RepositoryProvider.of<DolphinService>(context))
              ..add(const LoadInitialState()),
        child: Scaffold(
            appBar: AppBar(
              title: const Text('Dolphin App'),
            ),
            body: Stack(children: [
              const Background(),
              Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const <Widget>[
                    Expanded(flex: 6, child: ImageView()),
                    Expanded(flex: 1, child: StatusBar()),
                    Expanded(flex: 1, child: Actions()),
                  ]),
            ])));
  }
}

class ImageView extends StatelessWidget {
  const ImageView({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DolphinBloc, DolphinState>(builder: (context, state) {
      if (state is InitialState) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }

      if (state is PlayState) {
        return Center(
          // child: CachedNetworkImage(
          //   imageUrl: state.imageUrl,
          //   errorWidget: (context, url, error) => const Icon(Icons.error),
          // ),
          child: Text(state.imageUrl),
        );
      }

      if (state is RewindState) {
        return Center(
          // child: CachedNetworkImage(
          //   imageUrl: state.imageUrl,
          //   errorWidget: (context, url, error) => const Icon(Icons.error),
          // ),
          child: Text(state.imageUrl),
        );
      }

      if (state is PauseState) {
        return Center(
          // child: CachedNetworkImage(
          //   imageUrl: state.imageUrl,
          //   errorWidget: (context, url, error) => const Icon(Icons.error),
          // ),
          child: Text(state.imageUrl),
        );
      }

      if (state is StopState) {
        return const Center(
          child: Text('Cannot remember any more dolphins'),
        );
      }

      if (state is ErrorState) {
        return const Center(
          child: Text('Error: Please check console for error type'),
        );
      }
      return Container();
    });
  }
}

class StatusBar extends StatelessWidget {
  const StatusBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DolphinBloc, DolphinState>(builder: (context, state) {
      if (state is PlayState) {
        return const Center(
          child: Text('Playing'),
        );
      }
      if (state is PauseState) {
        return const Center(
          child: Text('Paused'),
        );
      }
      if (state is StopState) {
        return const Center(
          child: Text('Stopped'),
        );
      }
      if (state is RewindState) {
        return const Center(
          child: Text('Rewinding'),
        );
      }
      return Container();
    });
  }
}

class Actions extends StatelessWidget {
  const Actions({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DolphinBloc, DolphinState>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            if (state is StopState) ...[
              FloatingActionButton(
                  key: const Key('playButton'),
                  child: const Icon(Icons.play_arrow),
                  onPressed: () =>
                      context.read<DolphinBloc>().add(const Play())),
              FloatingActionButton(
                  key: const Key('rewindButton'),
                  child: const Icon(Icons.fast_rewind),
                  onPressed: () =>
                      context.read<DolphinBloc>().add(const Rewind())),
            ],
            if (state is PauseState) ...[
              FloatingActionButton(
                  key: const Key('playButton'),
                  child: const Icon(Icons.play_arrow),
                  onPressed: () => context.read<DolphinBloc>().add(Play())),
              FloatingActionButton(
                  key: const Key('rewindButton'),
                  child: const Icon(Icons.fast_rewind),
                  onPressed: () =>
                      context.read<DolphinBloc>().add(const Rewind())),
            ],
            if (state is PlayState) ...[
              FloatingActionButton(
                  key: const Key('pauseButton'),
                  child: const Icon(Icons.pause),
                  onPressed: () => context.read<DolphinBloc>().add(Pause())),
              FloatingActionButton(
                  key: const Key('rewindButton'),
                  child: const Icon(Icons.fast_rewind),
                  onPressed: () =>
                      context.read<DolphinBloc>().add(const Rewind())),
            ],
            if (state is RewindState) ...[
              FloatingActionButton(
                  key: const Key('playButton'),
                  child: const Icon(Icons.play_arrow),
                  onPressed: () => context.read<DolphinBloc>().add(Play())),
              FloatingActionButton(
                  key: const Key('pauseButton'),
                  child: const Icon(Icons.pause),
                  onPressed: () => context.read<DolphinBloc>().add(Pause())),
            ],
          ],
        );
      },
    );
  }
}
