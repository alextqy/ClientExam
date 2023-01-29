import 'package:client/models/base_list.dart';
import 'package:client/providers/base_notifier.dart';

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

  Future<BaseListModel> classList({
    required int page,
    required int pageSize,
    required String stext,
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

  void classes() async {
    operationStatus.value = OperationStatus.loading;
    try {
      result = await classApi.classes();
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
