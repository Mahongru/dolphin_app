import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dolphin_app/dolphin/dolphin.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Dolphin App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: const Color.fromRGBO(109, 234, 255, 1),
          colorScheme: const ColorScheme.light(
            secondary: Color.fromRGBO(72, 74, 126, 1),
          ),
        ),
        home: MultiRepositoryProvider(
          providers: [
            // Injecting dependency in the upper context
            RepositoryProvider(create: (context) => DolphinService())
          ],
          child: const DolphinPage(),
        ));
  }
}
