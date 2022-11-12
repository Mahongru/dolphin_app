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
              ..add(LoadInitialState()),
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
      if (state is InitialState) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }

      if (state is InProgress) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text((state.duration).toString()),
            CachedNetworkImage(
              imageUrl: state.dolphins[state.duration].url,
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ],
        );
      }

      if (state is ProgressPaused) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text((state.duration).toString()),
            CachedNetworkImage(
              imageUrl: state.dolphins[state.duration].url,
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ],
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
            if (state is ProgressPaused) ...[
              FloatingActionButton(
                  child: const Icon(Icons.play_arrow),
                  onPressed: () => context.read<DolphinBloc>().add(Play(
                      duration: state.duration, dolphins: state.dolphins))),
              FloatingActionButton(
                  child: const Icon(Icons.fast_rewind),
                  onPressed: () => context.read<DolphinBloc>().add(Rewind(
                      duration: state.duration, dolphins: state.dolphins))),
            ],
            if (state is InProgress) ...[
              FloatingActionButton(
                  child: const Icon(Icons.pause),
                  onPressed: () => context.read<DolphinBloc>().add(Pause(
                      duration: state.duration, dolphins: state.dolphins))),
              FloatingActionButton(
                  child: const Icon(Icons.fast_rewind),
                  onPressed: () => context.read<DolphinBloc>().add(Rewind(
                      duration: state.duration, dolphins: state.dolphins))),
            ],
          ],
        );
      },
    );
  }
}
