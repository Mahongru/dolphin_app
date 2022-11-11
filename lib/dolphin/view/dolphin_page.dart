import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_app/dolphin/dolphin.dart';

class DolphinPage extends StatelessWidget {
  const DolphinPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Added BlocProvider
    return BlocProvider(
      create: (_) => DolphinBloc(),
      child: const DolphinView(),
    );
  }
}

class DolphinView extends StatelessWidget {
  const DolphinView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DolphinBloc, DolphinState>(
        buildWhen: (prev, state) => prev.runtimeType != state.runtimeType,
        builder: (context, state) {
          return Scaffold(
              appBar: AppBar(
                title: const Text('Dolphin App'),
              ),
              body: Stack(children: const [
                Background(),
                ImageView(),
                Actions(),
              ]));
        });
  }
}

class ImageView extends StatelessWidget {
  const ImageView({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DolphinBloc, DolphinState>(
        buildWhen: (prev, state) => prev.runtimeType != state.runtimeType,
        builder: (context, state) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 100),
                child: Center(child: Image.network(state.url)),
              ),
            ],
          );
        });
  }
}

class Actions extends StatelessWidget {
  const Actions({super.key});
  @override
  Widget build(BuildContext context) {
    // TODO: Implement dolphin feature actions
    return Center();
  }
}

class Background extends StatelessWidget {
  const Background({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.blue.shade50,
              Colors.blue.shade500,
            ],
          ),
        ),
      ),
    );
  }
}
