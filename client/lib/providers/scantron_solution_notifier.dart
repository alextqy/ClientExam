// ignore_for_file: file_names

import 'package:client/models/data.dart';
import 'package:client/providers/base_notifier.dart';
import 'package:client/models/data_list.dart';

class ScantronSolutionNotifier extends BaseNotifier {
  Future<DataListModel> scantronSolutionList({
    int page = 1,
    int pageSize = 10,
    int scantronID = 0,
    int position = 0,
  }) async {
    return await scantronSolutionApi.scantronSolutionList(
      page: page,
      pageSize: pageSize,
      scantronID: scantronID,
      position: position,
    );
  }

  void scantronSolutionInfo({
    int id = 0,
  }) async {
    operationStatus.value = OperationStatus.loading;
    try {
      result = await scantronSolutionApi.scantronSolutionInfo(
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

  Future<DataModel> scantronSolutionViewAttachments({
    String optionAttachment = '',
  }) async {
    return await scantronSolutionApi.scantronSolutionViewAttachments(
      optionAttachment: optionAttachment,
    );
  }
}
