// ignore_for_file: file_names

import 'package:client/providers/base_notifier.dart';
import 'package:client/models/base_list.dart';

class ExamInfoHistoryNotifier extends BaseNotifier {
  Future<BaseListModel> examInfoHistoryList({
    int page = 1,
    int pageSize = 10,
    String stext = '',
    int examState = 0,
    int examType = 0,
    int pass = 0,
  }) async {
    return await examInfoHistoryApi.examInfoHistoryList(
      page: page,
      pageSize: pageSize,
      stext: stext,
      examState: examState,
      examType: examType,
      pass: pass,
    );
  }

  void examInfoHistory({
    required int id,
  }) async {
    operationStatus.value = OperationStatus.loading;
    try {
      result = await examInfoHistoryApi.examInfoHistory(
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
