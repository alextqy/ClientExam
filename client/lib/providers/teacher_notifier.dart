// ignore_for_file: file_names

import 'package:client/providers/base_notifier.dart';
import 'package:client/models/data_list.dart';
import 'package:client/models/data.dart';

class TeacherNotifier extends BaseNotifier {
  void newTeacher({
    required String account,
    required String password,
    required String name,
  }) async {
    operationStatus.value = OperationStatus.loading;
    try {
      result = await teacherApi.newTeacher(
        account: account,
        password: password,
        name: name,
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

  void teacherDisabled({
    required int id,
  }) async {
    operationStatus.value = OperationStatus.loading;
    try {
      result = await teacherApi.teacherDisabled(
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

  void updateTeacherInfo({
    required String password,
    required String name,
    required int id,
  }) async {
    operationStatus.value = OperationStatus.loading;
    try {
      result = await teacherApi.updateTeacherInfo(
        password: password,
        name: name,
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

  Future<DataListModel> teacherList({
    int page = 1,
    int pageSize = 10,
    String stext = '',
    int state = 0,
  }) async {
    return await teacherApi.teacherList(
      page: page,
      pageSize: pageSize,
      stext: stext,
      state: state,
    );
  }

  void teacherInfo({
    required int id,
  }) async {
    operationStatus.value = OperationStatus.loading;
    try {
      result = await teacherApi.teacherInfo(
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

  Future<DataModel> teachers() async {
    return await teacherApi.teachers();
  }

  void teacherSignIn(
    String account,
    String password,
  ) async {
    operationStatus.value = OperationStatus.loading;
    try {
      result = await teacherApi.teacherSignIn(
        account: account,
        password: password,
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

  void teacherSignOut() async {
    operationStatus.value = OperationStatus.loading;
    try {
      result = await teacherApi.teacherSignOut();
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

  void teacherChangePassword({
    required String newPassword,
  }) async {
    operationStatus.value = OperationStatus.loading;
    try {
      result = await teacherApi.teacherChangePassword(
        newPassword: newPassword,
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
}
