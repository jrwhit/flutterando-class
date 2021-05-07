import 'package:flutter/material.dart';

import 'package:flutter_modular/flutter_modular.dart';

import '../main.dart';
import 'webservice/user_webservice_impl.dart';
import 'webservice/home_webservice_impl.dart';
import 'repository/user_repository.dart';
import 'repository/home_repository.dart';
import 'view/base/progress_view.dart';
import 'view/base/home_view.dart';
import 'view_model/home_view_model.dart';
import 'view_model/progress_view_model.dart';
import 'app_routes_list.dart' as AppRoutes;
import 'framework/navigation_service.dart';

class AppModule extends MainModule {
  @override
  final List<Bind> binds = AppDependencies.dependencies;

  @override
  Widget get bootstrap => App();

  @override
  List<ModularRouter> get routers => <ModularRouter>[
    ModularRouter(
      Modular.initialRoute,
      child: (_, args) => HomeView(),
      transition: TransitionType.rightToLeft,
    ),
    ModularRouter(
      AppRoutes.progress,
      child: (_, args) => ProgressView(),
      transition: TransitionType.rightToLeft,
    ),
  ];


}

class AppDependencies {
  static bool get testMode => false;

  static List<Bind> get dependencies => [
    Bind<NavigationService>((_) => NavigationService()),
    ...repositoryDependencies,
    ...viewModelDependencies,
    ...webserviceDependencies,
  ];

  static List<Bind> get repositoryDependencies => [
    Bind((i) => HomeRepository(homeWebservice: i.get())),
    Bind((i) => UserRepository(i.get()))
  ];
  static List<Bind> get webserviceDependencies => [
    Bind((_) => HomeWebServiceImpl()),
    Bind((_) => UserWebserviceImpl()),
  ];

  static List<Bind> get viewModelDependencies => [
    Bind((i) => HomeViewModel(i.get(), i.get()), singleton: false),
    Bind((i) => ProgressViewModel(i.get(), i.get()), singleton: false),
  ];
}