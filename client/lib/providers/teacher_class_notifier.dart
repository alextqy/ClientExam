// ignore_for_file: file_names

import 'package:client/providers/base_notifier.dart';
import 'package:client/models/base_list.dart';

class TeacherClassNotifier extends BaseNotifier {
  void newTeacherClass({
    int teacherID = 0,
    int classID = 0,
  }) async {
    operationStatus.value = OperationStatus.loading;
    try {
      result = await teacherClassApi.newTeacherClass(
        teacherID: teacherID,
        classID: classID,
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

  void deleteTeacherClass({
    required int id,
  }) async {
    operationStatus.value = OperationStatus.loading;
    try {
      result = await teacherClassApi.deleteTeacherClass(
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

  Future<BaseListModel> teacherClassList({
    int page = 1,
    int pageSize = 10,
    int teacherID = 0,
    int classID = 0,
  }) async {
    return await teacherClassApi.teacherClassList(
      page: page,
      pageSize: pageSize,
      teacherID: teacherID,
      classID: classID,
    );
  }
}
