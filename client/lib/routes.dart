import 'package:flutter/material.dart';
import 'Views/common/animation.dart';
import 'package:client/main.dart';
import 'package:client/Views/manager/login.dart' as manager_login;
import 'package:client/Views/manager/index.dart' as manager_index;
import 'package:client/Views/manager/personal_settings.dart'
    as manager_personal_settings;
import 'package:client/Views/manager/manager.dart' as manager_manager;
import 'package:client/Views/teacher/index.dart' as teacher_index;

// 注册命名路由
// Map<String, WidgetBuilder> routerMap = {
//   '/manager/index': (context) {
//     return const manager_index.Index();
//   },
// };

class RouteHelper {
  dynamic generate(String routeName, {String headline = '', int id = 0}) {
    switch (routeName) {
      case '/':
        // return MaterialPageRoute(builder: (_) => Entrance());
        return const Entrance();
      // ===================================================================
      case '/manager/login':
        return RouteSlide(const manager_login.Login());
      case '/manager/index':
        return RouteSlide(manager_index.Index(headline: headline));
      case '/manager/personal/settings':
        return RouteSlide(
            manager_personal_settings.PersonalSettings(headline: headline));
      case '/manager/manager':
        return RouteSlide(manager_manager.Manager(headline: headline));
      // ===================================================================
      case '/teacher/index':
        return RouteSlide(const teacher_index.Index());
      // ===================================================================
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            backgroundColor: Colors.grey,
            appBar: AppBar(
              title: const Text('ERROR'),
            ),
            body: const Center(
              child: Text(
                'Invalid Page',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
              ),
            ),
          ),
        );
    }
  }
}
