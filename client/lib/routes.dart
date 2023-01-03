import 'package:flutter/material.dart';

import 'package:client/models/route_args.dart';
import 'Views/common/animation.dart';
import 'package:client/main.dart';
import 'package:client/Views/manager/login.dart' as manager_login;
import 'package:client/Views/manager/index.dart' as manager_index;
import 'package:client/Views/teacher/index.dart' as teacher_index;

// 注册命名路由
// Map<String, WidgetBuilder> routerMap = {
//   "/manager/index": (context) {
//     return const manager_index.Index();
//   },
// };

class RouteHelper {
  dynamic generate(String routeName, [routeArgs]) {
    switch (routeName) {
      case '/':
        // return MaterialPageRoute(builder: (_) => Entrance());
        return Entrance();
      // ===================================================================
      case '/manager/login':
        return RouteSlide(const manager_login.Login());
      case '/manager/index':
        return RouteSlide(manager_index.Index(routeArgs: routeArgs));
      // ===================================================================
      case '/teacher/index':
        return RouteSlide(const teacher_index.Index());
      // ===================================================================
      default:
        // return MaterialPageRoute(
        //   builder: (_) => Scaffold(
        //     body: Center(
        //       child: Text('No route defined for $routeName'),
        //     ),
        //   ),
        // );
        return Scaffold(
          body: Center(child: Text('No route defined for $routeName')),
        );
    }
  }
}
