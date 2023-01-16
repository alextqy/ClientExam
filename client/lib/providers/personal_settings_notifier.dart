import 'package:client/models/base.dart';
import 'package:client/providers/base_notifier.dart';

class PersonalSettingsNotifier extends BaseNotifier {
  Future<BaseModel> fetchmanagerModel() async {
    return await managerApi.managerInfo();
  }

  void updatePersonalData(
      {required String name, required int permission}) async {
    state.value = OperationStatus.loading;
    try {
      result = await managerApi.updateManagerInfo(
          name: name, permission: permission);
      if (result.state = true) {
        state.value = OperationStatus.success;
      } else {
        state.value = OperationStatus.failure;
        memo = result.memo;
      }
    } catch (e) {
      state.value = OperationStatus.failure;
      memo = e.toString();
    } finally {
      notifyListeners();
    }
  }

  void updatePersonalPassword({required String newPassword}) async {
    state.value = OperationStatus.loading;
    try {
      result = await managerApi.managerChangePassword(newPassword: newPassword);
      if (result.state = true) {
        state.value = OperationStatus.success;
      } else {
        state.value = OperationStatus.failure;
        memo = result.memo;
      }
    } catch (e) {
      state.value = OperationStatus.failure;
      memo = e.toString();
    } finally {
      notifyListeners();
    }
  }
}
