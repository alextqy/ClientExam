import 'package:flutter/material.dart';

import 'package:client/main.dart';
import 'package:client/Views/manager/index.dart' as manager;
import 'package:client/Views/teacher/index.dart' as teacher;

class RouteHelper {
  Route<dynamic> generate(String routeName) {
    switch (routeName) {
      case '/':
        return MaterialPageRoute(builder: (_) => Entrance());
      case '/manager/index':
        return MaterialPageRoute(builder: (_) => const manager.Index());
      case '/teacher/index':
        return MaterialPageRoute(builder: (_) => const teacher.Index());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
              body: Center(child: Text('No route defined for $routeName'))),
        );
    }
  }
}
