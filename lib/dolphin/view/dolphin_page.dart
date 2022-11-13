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
                    Expanded(flex: 2, child: Actions()),
                  ]),
            ])));
  }
}

class ImageView extends StatelessWidget {
  const ImageView({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DolphinBloc, DolphinState>(builder: (context, state) {
      int index = state.duration - 1;

      if (state is InitialState) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }

      if (state is PlayState) {
        String imageUrl = state.images[index].url;
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text((state.duration).toString()),
            CachedNetworkImage(
              imageUrl: imageUrl,
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ],
        );
      }

      if (state is RewindState) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text((state.duration).toString()),
            CachedNetworkImage(
              imageUrl: state.images[index].url,
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ],
        );
      }

      if (state is PauseState) {
        String imageUrl = state.images[index].url;
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text((state.duration).toString()),
            CachedNetworkImage(
              imageUrl: imageUrl,
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ],
        );
      }

      if (state is RewindEndState) {
        return const Center(
          child: Text('Cannot remember any more dolphins'),
        );
      }

      if (state is ErrorState) {
        return Center(
          child: Text(state.error),
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
            if (state is PauseState) ...[
              FloatingActionButton(
                  child: const Icon(Icons.play_arrow),
                  onPressed: () => context.read<DolphinBloc>().add(
                      Play(duration: state.duration, images: state.images))),
              FloatingActionButton(
                  child: const Icon(Icons.fast_rewind),
                  onPressed: () => context.read<DolphinBloc>().add(
                      Rewind(duration: state.duration, images: state.images))),
            ],
            if (state is PlayState) ...[
              FloatingActionButton(
                  child: const Icon(Icons.pause),
                  onPressed: () => context.read<DolphinBloc>().add(
                      Pause(duration: state.duration, images: state.images))),
              FloatingActionButton(
                  child: const Icon(Icons.fast_rewind),
                  onPressed: () => context.read<DolphinBloc>().add(
                      Rewind(duration: state.duration, images: state.images))),
            ],
            if (state is RewindState) ...[
              FloatingActionButton(
                  child: const Icon(Icons.play_arrow),
                  onPressed: () => context.read<DolphinBloc>().add(
                      Play(duration: state.duration, images: state.images))),
              FloatingActionButton(
                  child: const Icon(Icons.pause),
                  onPressed: () => context.read<DolphinBloc>().add(
                      Pause(duration: state.duration, images: state.images))),
            ],
            if (state is RewindEndState) ...[
              FloatingActionButton(
                  child: const Icon(Icons.restart_alt_sharp),
                  onPressed: () => context
                      .read<DolphinBloc>()
                      .add(const LoadInitialState())),
            ],
          ],
        );
      },
    );
  }
}
