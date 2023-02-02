// ignore_for_file: file_names

import 'package:client/providers/base_notifier.dart';
import 'package:client/models/data_list.dart';
import 'package:client/models/data.dart';

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

  Future<DataListModel> teacherClassList({
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

  // 获取当前班级下教师列表
  Future<DataModel> teachers({
    int classID = 0,
  }) async {
    return await teacherClassApi.teachers(
      classID: classID,
    );
  }

  // 获取当前教师所在班级列表
  Future<DataModel> teacherclasses({
    int teacherID = 0,
  }) async {
    return await teacherClassApi.teacherclasses(
      teacherID: teacherID,
    );
  }
}
