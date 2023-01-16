import 'package:client/providers/base_notifier.dart';

class LoginNotifier extends BaseNotifier {
  void request(String account, String password) async {
    state.value = OperationStatus.loading;
    if (account.isEmpty || password.isEmpty) {
      state.value = OperationStatus.failure;
      return;
    }
    try {
      result = await managerApi.managerSignIn(account, password);
      state.value = OperationStatus.failure;
      if (result.state = true) {
        if (result.data != null && (result.data as String).isNotEmpty) {
          state.value = OperationStatus.success;
        }
      }
    } catch (e) {
      state.value = OperationStatus.failure;
    } finally {
      notifyListeners();
    }
  }
}
