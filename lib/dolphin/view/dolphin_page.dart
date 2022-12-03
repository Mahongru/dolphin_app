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

  Widget imageView(state) {
    return Center(
        // child: CachedNetworkImage(
        //   imageUrl: state.imageUrl,
        //   errorWidget: (context, url, error) => const Icon(Icons.error),
        // ),
        child: Text(state.imageUrl));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DolphinBloc, DolphinState>(builder: (context, state) {
      if (state is InitialState) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }

      if (state is PlayState || state is RewindState || state is PauseState) {
        return imageView(state);
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

  String getStatus(DolphinState state) {
    if (state is PlayState) {
      return 'Playing';
    }
    if (state is PauseState) {
      return 'Paused';
    }
    if (state is RewindState) {
      return 'Rewinding';
    }
    if (state is StopState) {
      return 'Stopped';
    }

    return '';
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DolphinBloc, DolphinState>(builder: (context, state) {
      return Center(
        child: Text(getStatus(state)),
      );
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
            FloatingActionButton(
                key: const Key('ButtonLeft'),
                child: getIcon('ButtonLeft', state),
                onPressed: () => getActionState('ButtonLeft', state, context)),
            FloatingActionButton(
                key: const Key('ButtonRight'),
                child: getIcon('ButtonRight', state),
                onPressed: () => getActionState('ButtonRight', state, context)),
          ],
        );
      },
    );
  }

  Widget getIcon(button, state) {
    if (button == 'ButtonLeft') {
      if (state is PauseState || state is RewindState || state is StopState) {
        return const Icon(Icons.play_arrow);
      } else {
        return const Icon(Icons.pause);
      }
    }

    if (button == 'ButtonRight') {
      if (state is PauseState || state is PlayState || state is StopState) {
        return const Icon(Icons.fast_rewind);
      } else {
        return const Icon(Icons.pause);
      }
    }

    return Container();
  }

  void getActionState(String button, DolphinState state, BuildContext context) {
    if (button == 'ButtonLeft') {
      if (state is PauseState || state is RewindState || state is StopState) {
        context.read<DolphinBloc>().add(const Play());
      }
      if (state is PlayState) {
        context.read<DolphinBloc>().add(const Pause());
      }
    }

    if (button == 'ButtonRight') {
      if (state is PauseState || state is PlayState || state is StopState) {
        context.read<DolphinBloc>().add(const Rewind());
      }
      if (state is PlayState) {
        context.read<DolphinBloc>().add(const Pause());
      }
    }
  }
}
