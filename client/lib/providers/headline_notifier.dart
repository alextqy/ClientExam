// ignore_for_file: file_names

import 'package:client/models/data.dart';
import 'package:client/providers/base_notifier.dart';
import 'package:client/models/data_list.dart';

class HeadlineNotifier extends BaseNotifier {
  void newHeadline({
    required String content,
  }) async {
    operationStatus.value = OperationStatus.loading;
    try {
      result = await headlineApi.newHeadline(
        content: content,
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

  void updateHeadlineInfo({
    required int id,
    required String content,
  }) async {
    operationStatus.value = OperationStatus.loading;
    try {
      result = await headlineApi.updateHeadlineInfo(
        id: id,
        content: content,
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

  Future<DataListModel> headlineList({
    int page = 1,
    int pageSize = 10,
    String stext = '',
  }) async {
    return await headlineApi.headlineList(
      page: page,
      pageSize: pageSize,
      stext: stext,
    );
  }

  Future<DataModel> headlineInfo({
    required id,
  }) async {
    return await headlineApi.headlineInfo(id: id);
  }

  Future<DataModel> headlines() async {
    return await headlineApi.headlines();
  }
}
