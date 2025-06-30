import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jesusvlsco/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);
  runApp(const Jesusvlsco());
}
