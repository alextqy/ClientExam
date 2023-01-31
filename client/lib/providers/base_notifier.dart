// ignore_for_file: file_names

import 'package:flutter/widgets.dart';

import 'package:client/requests/class_api.dart';
import 'package:client/requests/exam_log_api.dart';
import 'package:client/requests/examinee_api.dart';
import 'package:client/requests/examinee_token_api.dart';
import 'package:client/requests/examinfo_api.dart';
import 'package:client/requests/examinfo_history_api.dart';
import 'package:client/requests/headline_api.dart';
import 'package:client/requests/knowledge_api.dart';
import 'package:client/requests/manager_api.dart';
import 'package:client/requests/paper_api.dart';
import 'package:client/requests/paper_rule_api.dart';
import 'package:client/requests/practice_api.dart';
import 'package:client/requests/question_api.dart';
import 'package:client/requests/question_solution_api.dart';
import 'package:client/requests/scantron_api.dart';
import 'package:client/requests/scantron_history_api.dart';
import 'package:client/requests/scantron_solution_api.dart';
import 'package:client/requests/scantron_solution_history_api.dart';
import 'package:client/requests/subject_api.dart';
import 'package:client/requests/sysConf_api.dart';
import 'package:client/requests/sysLog_api.dart';
import 'package:client/requests/teacher_api.dart';
import 'package:client/requests/teacher_class_api.dart';

import 'package:client/models/data.dart';
import 'package:client/models/data_list.dart';

import 'package:client/models/manager_model.dart';

enum OperationStatus {
  /// 加载中
  init,

  /// 加载中
  loading,

  /// 加载成功
  success,

  /// 加载成功，但数据为空
  empty,

  /// 加载失败
  failure,

  /// 请求失败
  disconnection,
}

class ApiResponse<T> {
  OperationStatus status;
  T? data;
  String? message;

  ApiResponse.init(this.message) : status = OperationStatus.init;

  ApiResponse.loading(this.message) : status = OperationStatus.loading;

  ApiResponse.success(this.data) : status = OperationStatus.success;

  ApiResponse.empty(this.message) : status = OperationStatus.empty;

  ApiResponse.failure(this.message) : status = OperationStatus.failure;

  ApiResponse.disconnection(this.message)
      : status = OperationStatus.disconnection;
}

class BaseNotifier extends ChangeNotifier {
  ValueNotifier operationStatus = ValueNotifier(OperationStatus.loading);
  String operationMemo = '';
  int operationCode = 0;

  late DataModel result;
  late DataListModel resultList;

  ManagerModel managerModel = ManagerModel();
  List<ManagerModel> managerListModel = [];

  ClassApi classApi = ClassApi();
  ExamLogApi examLogApi = ExamLogApi();
  ExamineeApi examineeApi = ExamineeApi();
  ExamineeTokenApi examineeTokenApi = ExamineeTokenApi();
  ExamInfoApi examInfoApi = ExamInfoApi();
  ExamInfoHistoryApi examInfoHistoryApi = ExamInfoHistoryApi();
  HeadlineApi headlineApi = HeadlineApi();
  KnowledgeApi knowledgeApi = KnowledgeApi();
  ManagerApi managerApi = ManagerApi();
  PaperApi paperApi = PaperApi();
  PaperRuleApi paperRuleApi = PaperRuleApi();
  PracticeApi practiceApi = PracticeApi();
  QuestionApi questionApi = QuestionApi();
  QuestionSolutionApi questionSolutionApi = QuestionSolutionApi();
  ScantronApi scantronApi = ScantronApi();
  ScantronHistoryApi scantronHistoryApi = ScantronHistoryApi();
  ScantronSolutionApi scantronSolutionApi = ScantronSolutionApi();
  ScantronSolutionHistoryApi scantronSolutionHistoryApi =
      ScantronSolutionHistoryApi();
  SubjectApi subjectApi = SubjectApi();
  SysConfApi sysConfApi = SysConfApi();
  SysLogApi sysLogApi = SysLogApi();
  TeacherApi teacherApi = TeacherApi();
  TeacherClassApi teacherClassApi = TeacherClassApi();
}
