// ignore_for_file: file_names

import 'package:client/providers/base_notifier.dart';
import 'package:client/models/data_list.dart';
import 'package:client/models/data.dart';

class ClassNotifier extends BaseNotifier {
  void newClass({
    required String className,
    required String description,
  }) async {
    operationStatus.value = OperationStatus.loading;
    try {
      result = await classApi.newClass(
        className: className,
        description: description,
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

  void updateClassInfo({
    required int id,
    required String className,
    required String description,
  }) async {
    operationStatus.value = OperationStatus.loading;
    try {
      result = await classApi.updateClassInfo(
        id: id,
        className: className,
        description: description,
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

  Future<DataListModel> classList({
    int page = 1,
    int pageSize = 10,
    String stext = '',
  }) async {
    return await classApi.classList(
      page: page,
      pageSize: pageSize,
      stext: stext,
    );
  }

  void classInfo({
    required int id,
  }) async {
    operationStatus.value = OperationStatus.loading;
    try {
      result = await classApi.classInfo(
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

  Future<DataModel> classes() async {
    return await classApi.classes();
  }
}
