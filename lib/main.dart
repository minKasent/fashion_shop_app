import 'package:fashion_shop/app.dart';
import 'package:fashion_shop/di/injector.dart';
import 'package:fashion_shop/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await configureDependencies();
  runApp(const MyApp());
}
