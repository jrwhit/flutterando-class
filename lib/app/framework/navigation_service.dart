import 'package:flutter_modular/flutter_modular.dart';

import '../../app/app_routes_list.dart' as AppRoutes;

class NavigationService {
  void navigateToProgress(){
    Modular.to.pushNamed(
      AppRoutes.progress,
    );
  }

  void goBack(){
    Modular.to.pop();
  }
}