// ignore_for_file: file_names

import 'package:client/providers/base_notifier.dart';
import 'package:client/models/base_list.dart';

class ScantronNotifier extends BaseNotifier {
  Future<BaseListModel> scantronList({
    int page = 1,
    int pageSize = 10,
    int examID = 0,
  }) async {
    return await scantronApi.scantronList(
      page: page,
      pageSize: pageSize,
      examID: examID,
    );
  }

  void scantronInfo({
    required int id,
  }) async {
    operationStatus.value = OperationStatus.loading;
    try {
      result = await scantronApi.scantronInfo(
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
