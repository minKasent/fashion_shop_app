import 'package:fashion_shop/data/datasource/local/secure_storage.dart';
import 'package:fashion_shop/di/injector.dart';
import 'package:fashion_shop/domain/core/failures.dart';
import 'package:fashion_shop/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../routes/route_name.dart';

/// Maps the failure to a message for the user
/// This is used to show the suer a message about the failure
/// This is used in the UI layer

class FailureMapper {
  final BuildContext context;
  const FailureMapper(this.context);

  String mapFailureToMessage(Failure failure) {
    switch (failure) {
      case NetworkFailure():
        return AppLocalizations.of(context)?.createAccount ?? '';
      case ServerFailure():
        return AppLocalizations.of(context)?.createAccount ?? '';
      case CacheFailure():
        return AppLocalizations.of(context)?.createAccount ?? '';
      case UnauthorizedFailure():
        _navigateToLoginScreen();
        return AppLocalizations.of(context)?.createAccount ?? '';
      case ForbiddenFailure():
        return AppLocalizations.of(context)?.createAccount ?? '';
      case NoInternetConnectionFailure():
        return AppLocalizations.of(context)?.createAccount ?? '';
      case UnknownFailure():
        return AppLocalizations.of(context)?.createAccount ?? '';
      default:
        return AppLocalizations.of(context)?.createAccount ?? '';
    }
  }

  void _navigateToLoginScreen() {
    getIt<SecureStorage>().saveAccessToken('');
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.go(RouteName.login);
    });
  }
}
