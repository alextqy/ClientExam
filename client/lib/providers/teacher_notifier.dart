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

// ========================================================================= teacher side =========================================================================

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

  Future<DataModel> checkTeacherInfo() async {
    return await teacherApi.checkTeacherInfo();
  }

  void teacherUpdate({
    required String name,
  }) async {
    operationStatus.value = OperationStatus.loading;
    try {
      result = await teacherApi.teacherUpdate(
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

  Future<DataModel> theTeacherClass() async {
    return await teacherApi.theTeacherClass();
  }

  Future<DataListModel> teacherExamineeList({
    int page = 1,
    int pageSize = 10,
    String stext = '',
    int classID = 0,
  }) async {
    return await teacherApi.teacherExamineeList(
      page: page,
      pageSize: pageSize,
      stext: stext,
      classID: classID,
    );
  }

  void teacherNewExaminee({
    required String examineeNo,
    required String name,
    required int classID,
    required String contact,
  }) async {
    operationStatus.value = OperationStatus.loading;
    try {
      result = await teacherApi.teacherNewExaminee(
        examineeNo: examineeNo,
        name: name,
        classID: classID,
        contact: contact,
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

  void teacherUpdateExaminee({
    required int id,
    required String name,
    required String contact,
    required int classID,
  }) async {
    operationStatus.value = OperationStatus.loading;
    try {
      result = await teacherApi.teacherUpdateExaminee(
        id: id,
        name: name,
        contact: contact,
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

  Future<DataListModel> teacherExamInfoList({
    int type = 0,
    int page = 1,
    int pageSize = 10,
    String stext = '',
    int examState = 0,
    int examType = 0,
    int pass = 0,
    int startState = 0,
    int suspendedState = 0,
    int examineeID = 0,
  }) async {
    return await teacherApi.teacherExamInfoList(
      type: type,
      page: page,
      pageSize: pageSize,
      stext: stext,
      examState: examState,
      examType: examType,
      pass: pass,
      startState: startState,
      suspendedState: suspendedState,
      examineeID: examineeID,
    );
  }

  Future<DataListModel> teacherScantronList({
    int type = 0,
    int page = 1,
    int pageSize = 10,
    int examID = 0,
  }) async {
    return await teacherApi.teacherScantronList(
      type: type,
      page: page,
      pageSize: pageSize,
      examID: examID,
    );
  }

  Future<DataModel> teacherScantronViewAttachments({
    required String filePath,
  }) async {
    return await teacherApi.teacherScantronViewAttachments(
      filePath: filePath,
    );
  }

  Future<DataListModel> teacherScantronSolutionList({
    int type = 0,
    int page = 1,
    int pageSize = 10,
    int scantronID = 0,
    int position = 0,
  }) async {
    return await teacherApi.teacherScantronSolutionList(
      type: type,
      page: page,
      pageSize: pageSize,
      scantronID: scantronID,
      position: position,
    );
  }

  Future<DataModel> teacherScantronSolutionViewAttachments({
    required String optionAttachment,
  }) async {
    return await teacherApi.teacherScantronSolutionViewAttachments(
      optionAttachment: optionAttachment,
    );
  }
}
