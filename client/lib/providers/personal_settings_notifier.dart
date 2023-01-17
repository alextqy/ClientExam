import 'package:client/models/base.dart';
import 'package:client/providers/base_notifier.dart';

class PersonalSettingsNotifier extends BaseNotifier {
  Future<BaseModel> fetchManager() async {
    return await managerApi.managerInfo();
  }

  void updatePersonalData(
      {required String name, required int permission}) async {
    operationStatus.value = OperationStatus.loading;
    try {
      result = await managerApi.updateManagerInfo(
          name: name, permission: permission);
      if (result.state = true) {
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

  void updatePersonalPassword({required String newPassword}) async {
    operationStatus.value = OperationStatus.loading;
    try {
      result = await managerApi.managerChangePassword(newPassword: newPassword);
      if (result.state = true) {
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
