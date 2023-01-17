import 'package:client/providers/base_notifier.dart';

class LoginNotifier extends BaseNotifier {
  void request(String account, String password) async {
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
}
