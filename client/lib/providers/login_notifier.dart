import 'package:client/providers/base_notifier.dart';

class LoginNotifier extends BaseNotifier {
  void request(String account, String password) async {
    state.value = OperationStatus.loading;
    try {
      result = await managerApi.managerSignIn(account, password);
      if (result.state = true && result.data != null) {
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
