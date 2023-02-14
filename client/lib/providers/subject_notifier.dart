// ignore_for_file: file_names

import 'package:client/providers/base_notifier.dart';
import 'package:client/models/data_list.dart';
import 'package:client/models/data.dart';

class SubjectNotifier extends BaseNotifier {
  void newSubject({
    required String subjectName,
  }) async {
    operationStatus.value = OperationStatus.loading;
    try {
      result = await subjectApi.newSubject(
        subjectName: subjectName,
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

  void subjectDisabled({
    required int id,
  }) async {
    operationStatus.value = OperationStatus.loading;
    try {
      result = await subjectApi.subjectDisabled(
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

  void updateSubjectInfo({
    int id = 0,
    String subjectName = '',
  }) async {
    operationStatus.value = OperationStatus.loading;
    try {
      result = await subjectApi.updateSubjectInfo(
        id: id,
        subjectName: subjectName,
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

  Future<DataListModel> subjectList({
    int page = 1,
    int pageSize = 10,
    String stext = '',
    int subjectState = 0,
  }) async {
    return await subjectApi.subjectList(
      page: page,
      pageSize: pageSize,
      stext: stext,
      subjectState: subjectState,
    );
  }

  void subjectInfo({
    required int id,
  }) async {
    operationStatus.value = OperationStatus.loading;
    try {
      result = await subjectApi.subjectInfo(
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

  Future<DataModel> subjects() async {
    return await subjectApi.subjects();
  }
}
