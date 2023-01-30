// ignore_for_file: file_names

import 'package:client/providers/base_notifier.dart';
import 'package:client/models/base_list.dart';

class PaperNotifier extends BaseNotifier {
  void newPaper({
    required String paperName,
    required int subjectID,
    required int totalScore,
    required int passLine,
    required int examDuration,
  }) async {
    operationStatus.value = OperationStatus.loading;
    try {
      result = await paperApi.newPaper(
        paperName: paperName,
        subjectID: subjectID,
        totalScore: totalScore,
        passLine: passLine,
        examDuration: examDuration,
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

  void paperDisabled({
    required id,
  }) async {
    operationStatus.value = OperationStatus.loading;
    try {
      result = await paperApi.paperDisabled(
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

  void updatePaperInfo({
    required id,
    required String paperName,
    required int totalScore,
    required int passLine,
    required int examDuration,
  }) async {
    operationStatus.value = OperationStatus.loading;
    try {
      result = await paperApi.updatePaperInfo(
        id: id,
        paperName: paperName,
        totalScore: totalScore,
        passLine: passLine,
        examDuration: examDuration,
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

  Future<BaseListModel> paperList({
    int page = 1,
    int pageSize = 10,
    String stext = '',
    int subjectID = 0,
    int paperState = 0,
  }) async {
    return await paperApi.paperList(
      page: page,
      pageSize: pageSize,
      stext: stext,
      subjectID: subjectID,
      paperState: paperState,
    );
  }

  void paperInfo({
    required id,
  }) async {
    operationStatus.value = OperationStatus.loading;
    try {
      result = await paperApi.paperInfo(
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
