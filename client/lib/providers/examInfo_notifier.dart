// ignore_for_file: file_names

import 'package:client/providers/base_notifier.dart';
import 'package:client/models/data_list.dart';

class ExamInfoNotifier extends BaseNotifier {
  void newExamInfo({
    required String subjectName,
    required String examNo,
    required int examineeID,
    required int examType,
  }) async {
    operationStatus.value = OperationStatus.loading;
    try {
      result = await examInfoApi.newExamInfo(
        subjectName: subjectName,
        examNo: examNo,
        examineeID: examineeID,
        examType: examType,
      );
      if (result.state == true) {
        operationStatus.value = OperationStatus.success;
      } else {
        operationStatus.value = OperationStatus.failure;
        operationMemo = result.memo;
      }
    } catch (e) {
      operationStatus.value = OperationStatus.failure;
      operationMemo = e.toString();
    } finally {
      notifyListeners();
    }
  }

  void examInfoDisabled({
    required int id,
  }) async {
    operationStatus.value = OperationStatus.loading;
    try {
      result = await examInfoApi.examInfoDisabled(
        id: id,
      );
      if (result.state == true) {
        operationStatus.value = OperationStatus.success;
      } else {
        operationStatus.value = OperationStatus.failure;
        operationMemo = result.memo;
      }
    } catch (e) {
      operationStatus.value = OperationStatus.failure;
      operationMemo = e.toString();
    } finally {
      notifyListeners();
    }
  }

  Future<DataListModel> examInfoList({
    int page = 1,
    int pageSize = 10,
    String stext = '',
    int examState = 0,
    int examType = 0,
    int pass = 0,
    int startState = 0,
    int suspendedState = 0,
  }) async {
    return await examInfoApi.examInfoList(
      page: page,
      pageSize: pageSize,
      stext: stext,
      examState: examState,
      examType: examType,
      pass: pass,
      startState: startState,
      suspendedState: suspendedState,
    );
  }

  void examInfo({
    required int id,
  }) async {
    operationStatus.value = OperationStatus.loading;
    try {
      result = await examInfoApi.examInfo(
        id: id,
      );
      if (result.state == true) {
        operationStatus.value = OperationStatus.success;
      } else {
        operationStatus.value = OperationStatus.failure;
        operationMemo = result.memo;
      }
    } catch (e) {
      operationStatus.value = OperationStatus.failure;
      operationMemo = e.toString();
    } finally {
      notifyListeners();
    }
  }

  void generateTestPaper({
    required int id,
  }) async {
    operationStatus.value = OperationStatus.loading;
    try {
      result = await examInfoApi.generateTestPaper(
        id: id,
      );
      if (result.state == true) {
        operationStatus.value = OperationStatus.success;
      } else {
        operationStatus.value = OperationStatus.failure;
        operationMemo = result.memo;
      }
    } catch (e) {
      operationStatus.value = OperationStatus.failure;
      operationMemo = e.toString();
    } finally {
      notifyListeners();
    }
  }

  void resetExamQuestionData({
    required int id,
  }) async {
    operationStatus.value = OperationStatus.loading;
    try {
      result = await examInfoApi.generateTestPaper(
        id: id,
      );
      if (result.state == true) {
        operationStatus.value = OperationStatus.success;
      } else {
        operationStatus.value = OperationStatus.failure;
        operationMemo = result.memo;
      }
    } catch (e) {
      operationStatus.value = OperationStatus.failure;
      operationMemo = e.toString();
    } finally {
      notifyListeners();
    }
  }

  void examIntoHistory({
    required int id,
  }) async {
    operationStatus.value = OperationStatus.loading;
    try {
      result = await examInfoApi.examIntoHistory(
        id: id,
      );
      if (result.state == true) {
        operationStatus.value = OperationStatus.success;
      } else {
        operationStatus.value = OperationStatus.failure;
        operationMemo = result.memo;
      }
    } catch (e) {
      operationStatus.value = OperationStatus.failure;
      operationMemo = e.toString();
    } finally {
      notifyListeners();
    }
  }

  void gradeTheExam({
    required int id,
  }) async {
    operationStatus.value = OperationStatus.loading;
    try {
      result = await examInfoApi.gradeTheExam(
        id: id,
      );
      if (result.state == true) {
        operationStatus.value = OperationStatus.success;
      } else {
        operationStatus.value = OperationStatus.failure;
        operationMemo = result.memo;
      }
    } catch (e) {
      operationStatus.value = OperationStatus.failure;
      operationMemo = e.toString();
    } finally {
      notifyListeners();
    }
  }

  void importExamInfo({
    required String filePath,
  }) async {
    operationStatus.value = OperationStatus.loading;
    try {
      bool result = await examInfoApi.importExamInfo(
        filePath: filePath,
      );
      if (result == true) {
        operationStatus.value = OperationStatus.success;
      } else {
        operationStatus.value = OperationStatus.failure;
        // operationMemo = result.memo;
      }
    } catch (e) {
      operationStatus.value = OperationStatus.failure;
      operationMemo = e.toString();
    } finally {
      notifyListeners();
    }
  }

  void downloadExamInfoDemo() async {
    operationStatus.value = OperationStatus.loading;
    try {
      result = await examInfoApi.downloadExamInfoDemo();
      if (result.state == true) {
        operationStatus.value = OperationStatus.success;
      } else {
        operationStatus.value = OperationStatus.failure;
        operationMemo = result.memo;
      }
    } catch (e) {
      operationStatus.value = OperationStatus.failure;
      operationMemo = e.toString();
    } finally {
      notifyListeners();
    }
  }
}