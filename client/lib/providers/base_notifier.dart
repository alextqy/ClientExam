// ignore_for_file: file_names
import 'package:flutter/widgets.dart';

import 'package:client/models/data.dart';
import 'package:client/models/data_list.dart';
import 'package:client/models/class_model.dart';
import 'package:client/models/examinfo_history_model.dart';
import 'package:client/models/examinfo_model.dart';
import 'package:client/models/exam_log_model.dart';
import 'package:client/models/examinee_model.dart';
import 'package:client/models/examinee_token_model.dart';
import 'package:client/models/headline_model.dart';
import 'package:client/models/knowledge_model.dart';
import 'package:client/models/manager_model.dart';
import 'package:client/models/paper_model.dart';
import 'package:client/models/paper_rule_model.dart';
import 'package:client/models/practice_model.dart';
import 'package:client/models/practice_solution_model.dart';
import 'package:client/models/question_model.dart';
import 'package:client/models/question_solution_model.dart';
import 'package:client/models/scantron_history_model.dart';
import 'package:client/models/scantron_model.dart';
import 'package:client/models/scantron_solution_history_model.dart';
import 'package:client/models/scantron_solution_model.dart';
import 'package:client/models/subject_model.dart';
import 'package:client/models/sys_conf_model.dart';
import 'package:client/models/sys_log_model.dart';
import 'package:client/models/teacher_class_model.dart';
import 'package:client/models/teacher_model.dart';

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

  ApiResponse.disconnection(this.message) : status = OperationStatus.disconnection;
}

class BaseNotifier extends ChangeNotifier {
  ValueNotifier operationStatus = ValueNotifier(OperationStatus.loading);
  String operationMemo = '';
  int operationCode = 0;

  late DataModel result;
  late DataListModel resultList;

  /// model ===================================================================
  ClassModel classModel = ClassModel();
  ExamLogModel examLogModel = ExamLogModel();
  ExamineeModel examineeModel = ExamineeModel();
  ExamineeTokenModel examineeTokenModel = ExamineeTokenModel();
  ExamInfoHistoryModel examInfoHistoryModel = ExamInfoHistoryModel();
  ExamInfoModel examInfoModel = ExamInfoModel();
  HeadlineModel headlineModel = HeadlineModel();
  KnowledgeModel knowledgeModel = KnowledgeModel();
  ManagerModel managerModel = ManagerModel();
  PaperModel paperModel = PaperModel();
  PaperRuleModel paperRuleModel = PaperRuleModel();
  PracticeModel practiceModel = PracticeModel();
  PracticeSolutionModel practiceSolutionModel = PracticeSolutionModel();
  QuestionModel questionModel = QuestionModel();
  QuestionSolutionModel questionSolutionModel = QuestionSolutionModel();
  ScantronHistoryModel scantronHistoryModel = ScantronHistoryModel();
  ScantronModel scantronModel = ScantronModel();
  ScantronSolutionHistoryModel scantronSolutionHistoryModel = ScantronSolutionHistoryModel();
  ScantronSolutionModel scantronSolutionModel = ScantronSolutionModel();
  SubjectModel subjectModel = SubjectModel();
  SysConfModel sysConfModel = SysConfModel();
  SysLogModel sysLogModel = SysLogModel();
  TeacherClassModel teacherClassModel = TeacherClassModel();
  TeacherModel teacherModel = TeacherModel();

  /// model list ===================================================================
  List<ClassModel> classListModel = [];
  List<ExamLogModel> examLogListModel = [];
  List<ExamineeModel> examineeListModel = [];
  List<ExamineeTokenModel> examineeTokenListModel = [];
  List<ExamInfoHistoryModel> examInfoHistoryListModel = [];
  List<ExamInfoModel> examInfoListModel = [];
  List<HeadlineModel> headlineListModel = [];
  List<KnowledgeModel> knowledgeListModel = [];
  List<ManagerModel> managerListModel = [];
  List<PaperModel> paperListModel = [];
  List<PaperRuleModel> paperRuleListModel = [];
  List<PracticeModel> practiceListModel = [];
  List<PracticeSolutionModel> practiceSolutionListModel = [];
  List<QuestionModel> questionListModel = [];
  List<QuestionSolutionModel> questionSolutionListModel = [];
  List<ScantronHistoryModel> scantronHistoryListModel = [];
  List<ScantronModel> scantronListModel = [];
  List<ScantronSolutionHistoryModel> scantronSolutionHistoryListModel = [];
  List<ScantronSolutionModel> scantronSolutionListModel = [];
  List<SubjectModel> subjectListModel = [];
  List<SysConfModel> sysConfListModel = [];
  List<SysLogModel> sysLogListModel = [];
  List<TeacherClassModel> teacherClassListModel = [];
  List<TeacherModel> teacherListModel = [];

  /// api ===================================================================
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
  ScantronSolutionHistoryApi scantronSolutionHistoryApi = ScantronSolutionHistoryApi();
  SubjectApi subjectApi = SubjectApi();
  SysConfApi sysConfApi = SysConfApi();
  SysLogApi sysLogApi = SysLogApi();
  TeacherApi teacherApi = TeacherApi();
  TeacherClassApi teacherClassApi = TeacherClassApi();
}
