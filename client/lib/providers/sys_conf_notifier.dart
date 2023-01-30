// ignore_for_file: file_names

import 'package:client/providers/base_notifier.dart';
// import 'package:client/models/base_list.dart';

class SysConfNotifier extends BaseNotifier {
  void configInfo({
    required String key,
  }) async {
    operationStatus.value = OperationStatus.loading;
    try {
      result = await sysConfApi.configInfo(
        key: key,
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
