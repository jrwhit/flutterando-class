import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutterando_class/app/core/themes/theme_app.dart';

import 'app/core/constants/colors.dart';

import 'app/app_module.dart';

final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

void main() => runApp(ModularApp(
      module: AppModule(),
    ));

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: AppColors.primary,
      ),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorObservers: [routeObserver],
        onGenerateRoute: Modular.generateRoute,
        navigatorKey: Modular.navigatorKey,
        initialRoute: Modular.initialRoute,
        theme: lightTheme,
        darkTheme: darkTheme,
      ),
    );
  }
}
