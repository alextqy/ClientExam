// ignore_for_file: file_names

import 'package:client/providers/base_notifier.dart';
import 'package:client/models/base_list.dart';

class SysLogNotifier extends BaseNotifier {
  Future<BaseListModel> sysLogList({
    int page = 1,
    int pageSize = 10,
    String stext = '',
    int type = 0,
    int managerID = 0,
  }) async {
    return await sysLogApi.sysLogList(
      page: page,
      pageSize: pageSize,
      stext: stext,
      type: type,
      managerID: managerID,
    );
  }

  void sysLogInfo({
    required int id,
  }) async {
    operationStatus.value = OperationStatus.loading;
    try {
      result = await sysLogApi.sysLogInfo(
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
