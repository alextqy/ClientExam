import 'package:client/models/base_list.dart';
import 'package:client/providers/base_notifier.dart';

class ExamLogNotifier extends BaseNotifier {
  Future<BaseListModel> examLogList({
    int page = 1,
    int pageSize = 10,
    String stext = '',
    int type = 0,
  }) async {
    return await examLogApi.examLogList(
      page: page,
      pageSize: pageSize,
      stext: stext,
      type: type,
    );
  }

  void examLogInfo({
    int id = 0,
  }) async {
    operationStatus.value = OperationStatus.loading;
    try {
      result = await examLogApi.examLogInfo(
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
