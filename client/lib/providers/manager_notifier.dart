import 'package:client/models/base_list.dart';
import 'package:client/providers/base_notifier.dart';

class ManagerNotifier extends BaseNotifier {
  Future<BaseListModel> fetchManagerList({
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

  void updateManagerData({
    required int id,
    required String name,
    required int permission,
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

  void managerDisabled({required int id}) async {
    operationStatus.value = OperationStatus.loading;
    try {
      result = await managerApi.managerDisabled(id: id);
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
