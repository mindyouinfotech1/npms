import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../routes/appRoutes.dart';

class AuthMiddleware extends GetMiddleware {
  @override
  int? priority = 1;

  @override
  RouteSettings? redirect(String? route) {
    if (route == AppRoutes.login) {
      return null;
    }

    return const RouteSettings(name: AppRoutes.login);
  }

  @override
  Future<GetNavConfig?> redirectDelegate(GetNavConfig route) async {
    return route;
  }
}