import 'package:flutter/material.dart';

import 'package:client/main.dart';
import 'package:client/Views/manager/login.dart' as manager_login;
import 'package:client/Views/manager/index.dart' as manager_index;
import 'package:client/Views/teacher/index.dart' as teacher_index;

class RouteHelper {
  // Route<dynamic> generate(String routeName) {
  dynamic generate(String routeName) {
    switch (routeName) {
      case '/':
        // return MaterialPageRoute(builder: (_) => Entrance());
        return Entrance();
      // ===================================================================
      case '/manager/login':
        return const manager_login.Login();
      case '/manager/index':
        // return MaterialPageRoute(builder: (_) => manager_index.Index());
        return const manager_index.Index();
      // ===================================================================
      case '/teacher/index':
        // return MaterialPageRoute(builder: (_) => teacher_index.Index());
        return const teacher_index.Index();
      // ===================================================================
      default:
        // return MaterialPageRoute(
        //   builder: (_) => Scaffold(
        //       body: Center(child: Text('No route defined for $routeName'))),
        // );
        return Scaffold(
            body: Center(child: Text('No route defined for $routeName')));
    }
  }
}
