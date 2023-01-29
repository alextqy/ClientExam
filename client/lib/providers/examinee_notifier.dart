import 'package:client/models/base_list.dart';
import 'package:client/providers/base_notifier.dart';

class ExamineeNotifier extends BaseNotifier {
  void newExaminee({
    required String examineeNo,
    required String name,
    required int classID,
    required String contact,
  }) async {
    operationStatus.value = OperationStatus.loading;
    try {
      result = await examineeApi.newExaminee(
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

  void updateExaminee({
    required int id,
    required String name,
    required String contact,
  }) async {
    operationStatus.value = OperationStatus.loading;
    try {
      result = await examineeApi.updateExaminee(
        id: id,
        name: name,
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

  Future<BaseListModel> examineeList({
    int page = 1,
    int pageSize = 10,
    String stext = '',
    int classID = 0,
  }) async {
    return await examineeApi.examineeList(
      page: page,
      pageSize: pageSize,
      stext: stext,
      classID: classID,
    );
  }

  void examineeInfo({
    required int id,
  }) async {
    operationStatus.value = OperationStatus.loading;
    try {
      result = await examineeApi.examineeInfo(
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

  void examinees() async {
    operationStatus.value = OperationStatus.loading;
    try {
      result = await examineeApi.examinees();
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
