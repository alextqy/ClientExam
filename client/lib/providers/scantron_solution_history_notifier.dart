// ignore_for_file: file_names

import 'package:client/providers/base_notifier.dart';
import 'package:client/models/data_list.dart';

class ScantronSolutionHistoryNotifier extends BaseNotifier {
  Future<DataListModel> scantronSolutionHistoryList({
    int page = 1,
    int pageSize = 10,
    int scantronID = 0,
    int position = 0,
  }) async {
    return await scantronSolutionHistoryApi.scantronSolutionHistoryList(
      page: page,
      pageSize: pageSize,
      scantronID: scantronID,
      position: position,
    );
  }

  void scantronSolutionHistoryInfo({
    required int id,
  }) async {
    operationStatus.value = OperationStatus.loading;
    try {
      result = await scantronSolutionHistoryApi.scantronSolutionHistoryInfo(
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
