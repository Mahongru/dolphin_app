import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:dolphin_app/app.dart';

void main() async {
  // To load the .env file contents into dotenv.
  await dotenv.load();
  runApp(const App());
}
