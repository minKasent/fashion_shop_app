import 'package:fashion_shop/app.dart';
import 'package:fashion_shop/di/injector.dart';
import 'package:flutter/cupertino.dart';

import 'di/env_module.dart';

Future<void>main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies(env: prod.name);
  runApp(const MyApp());
}