import 'package:fashion_shop/presentation/bloc/locale/locale_bloc.dart';
import 'package:fashion_shop/presentation/bloc/locale/locale_state.dart';
import 'package:fashion_shop/presentation/routes/app_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'l10n/app_localizations.dart';


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context) => LocaleBloc(), child: MyAppView());
  }
}
class MyAppView extends StatelessWidget {
  const MyAppView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocaleBloc, LocaleState>(
      builder: (context, state) {
        return ScreenUtilInit(
          designSize: const Size(413, 896),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, child) {
            return MaterialApp.router(
              debugShowCheckedModeBanner: false,
              title: 'Flutter Demo',
              theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              ),
              routerConfig: AppRouter.router,
              locale: Locale(state.locale),
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: const [Locale('en'), Locale('vi')],
            );
          },
        );
      },
    );
  }
}
