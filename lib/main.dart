import 'package:ankabootmobile/src/app.dart';
import 'package:ankabootmobile/src/di/injection_container.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();

  runApp(
    const AnkabootApp(),
  );
}
