// ignore_for_file: file_names

import 'package:client/providers/base_notifier.dart';
import 'package:client/models/data.dart';
import 'package:client/models/data_list.dart';

class ManagerNotifier extends BaseNotifier {
  void managerSignIn(
    String account,
    String password,
  ) async {
    operationStatus.value = OperationStatus.loading;
    try {
      result = await managerApi.managerSignIn(account, password);
      if (result.state = true && result.data != null) {
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

  Future<DataListModel> managerList({
    int page = 1,
    int pageSize = 5,
    String stext = '',
    int state = 0,
    int permission = 0,
  }) async {
    return await managerApi.managerList(
      page: page,
      pageSize: pageSize,
      stext: stext,
      state: state,
      permission: permission,
    );
  }

  Future<DataModel> managerInfo() async {
    return await managerApi.managerInfo();
  }

  Future<DataModel> managers() async {
    return await managerApi.managers();
  }

  void updateManagerInfo({
    required String name,
    required int permission,
    int id = 0,
  }) async {
    operationStatus.value = OperationStatus.loading;
    try {
      result = await managerApi.updateManagerInfo(
        id: id,
        name: name,
        permission: permission,
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

  void managerDisabled({
    required int id,
  }) async {
    operationStatus.value = OperationStatus.loading;
    try {
      result = await managerApi.managerDisabled(
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

  void newManager({
    required String account,
    required String password,
    required String name,
  }) async {
    operationStatus.value = OperationStatus.loading;
    try {
      result = await managerApi.newManager(
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

  void managerChangePassword({
    String newPassword = '',
    int id = 0,
  }) async {
    operationStatus.value = OperationStatus.loading;
    try {
      result = await managerApi.managerChangePassword(
        newPassword: newPassword,
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
}
