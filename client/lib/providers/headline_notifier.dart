// ignore_for_file: file_names

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

  void headlineInfo({
    required id,
  }) async {
    operationStatus.value = OperationStatus.loading;
    try {
      result = await headlineApi.headlineInfo(
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

  void headlines() async {
    operationStatus.value = OperationStatus.loading;
    try {
      result = await headlineApi.headlines();
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
