import 'package:flutter/material.dart';

import 'Views/common/animation.dart';
import 'package:client/main.dart';

import 'package:client/Views/manager/login.dart' as manager_site;
import 'package:client/Views/manager/index.dart' as manager_site;
import 'package:client/Views/manager/personal_settings.dart' as manager_site;
import 'package:client/Views/manager/manager.dart' as manager_site;
import 'package:client/Views/manager/teacher.dart' as manager_site;
import 'package:client/Views/manager/class.dart' as manager_site;
import 'package:client/Views/manager/examinee.dart' as manager_site;
import 'package:client/Views/manager/examinfo.dart' as manager_site;
import 'package:client/Views/manager/old_examInfo.dart' as manager_site;
import 'package:client/Views/manager/subject.dart' as manager_site;
import 'package:client/Views/manager/knowledge_point.dart' as manager_site;
import 'package:client/Views/manager/top_title.dart' as manager_site;
import 'package:client/Views/manager/question.dart' as manager_site;
import 'package:client/Views/manager/paper.dart' as manager_site;
// import 'package:client/Views/manager/answer_cards.dart' as manager_site;
// import 'package:client/Views/manager/old_answer_cards.dart' as manager_site;
import 'package:client/Views/manager/exam_logs.dart' as manager_site;

import 'package:client/Views/teacher/index.dart' as teacher_site;

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
      // 管理员 ===================================================================
      case '/manager/login':
        return RouteSlide(const manager_site.Login());
      case '/manager/index':
        return MaterialPageRoute(builder: (_) => manager_site.Index(headline: headline));
      // return RouteSlide(manager_site.Index(headline: headline));
      case '/manager/personal/settings':
        return MaterialPageRoute(builder: (_) => manager_site.PersonalSettings(headline: headline));
      case '/manager/manager':
        return MaterialPageRoute(builder: (_) => manager_site.Manager(headline: headline));
      case '/manager/teacher':
        return MaterialPageRoute(builder: (_) => manager_site.Teacher(headline: headline));
      case '/manager/class':
        return MaterialPageRoute(builder: (_) => manager_site.Class(headline: headline));
      case '/manager/examinee':
        return MaterialPageRoute(builder: (_) => manager_site.Examinee(headline: headline));
      case '/manager/examInfo':
        return MaterialPageRoute(builder: (_) => manager_site.ExamInfo(headline: headline));
      case '/manager/old/examInfo':
        return MaterialPageRoute(builder: (_) => manager_site.OldExamInfo(headline: headline));
      case '/manager/subject':
        return MaterialPageRoute(builder: (_) => manager_site.Subject(headline: headline));
      case '/manager/knowledge/point':
        return MaterialPageRoute(builder: (_) => manager_site.KnowledgePoint(headline: headline));
      case '/manager/top/title':
        return MaterialPageRoute(builder: (_) => manager_site.TopTitle(headline: headline));
      case '/manager/question':
        return MaterialPageRoute(builder: (_) => manager_site.Question(headline: headline));
      case '/manager/paper':
        return MaterialPageRoute(builder: (_) => manager_site.Paper(headline: headline));
      // case '/manager/answer/cards':
      //   return MaterialPageRoute(builder: (_) => manager_site.AnswerCards(headline: headline));
      // case '/manager/old/answer/cards':
      //   return MaterialPageRoute(builder: (_) => manager_site.OldAnswerCards(headline: headline));
      case '/manager/exam/logs':
        return MaterialPageRoute(builder: (_) => manager_site.ExamLogs(headline: headline));
      // 教师 ===================================================================
      case '/teacher/index':
        return RouteSlide(const teacher_site.Index());
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
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.white),
              ),
            ),
          ),
        );
    }
  }
}
