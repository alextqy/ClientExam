// ignore_for_file: file_names

import 'package:client/providers/base_notifier.dart';
import 'package:client/models/data_list.dart';

class PaperRuleNotifier extends BaseNotifier {
  void newPaperRule({
    required int headlineID,
    required int questionType,
    required int knowledgeID,
    required int questionNum,
    required double singleScore,
    required int paperID,
    required int serialNumber,
  }) async {
    operationStatus.value = OperationStatus.loading;
    try {
      result = await paperRuleApi.newPaperRule(
        headlineID: headlineID,
        questionType: questionType,
        knowledgeID: knowledgeID,
        questionNum: questionNum,
        singleScore: singleScore,
        paperID: paperID,
        serialNumber: serialNumber,
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

  void paperRuleDisabled({
    required id,
  }) async {
    operationStatus.value = OperationStatus.loading;
    try {
      result = await paperRuleApi.paperRuleDisabled(
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

  void paperRuleDelete({
    required id,
  }) async {
    operationStatus.value = OperationStatus.loading;
    try {
      result = await paperRuleApi.paperRuleDelete(
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

  Future<DataListModel> paperRuleList({
    int page = 1,
    int pageSize = 10,
    int paperID = 0,
    int paperRuleState = 0,
  }) async {
    return await paperRuleApi.paperRuleList(
      page: page,
      pageSize: pageSize,
      paperID: paperID,
      paperRuleState: paperRuleState,
    );
  }

  void paperRules({
    required paperID,
  }) async {
    operationStatus.value = OperationStatus.loading;
    try {
      result = await paperRuleApi.paperRules(
        paperID: paperID,
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

  void updatePaperRule({
    required int id,
    required int questionType,
    required int questionNum,
    required double singleScore,
    required int serialNumber,
  }) async {
    operationStatus.value = OperationStatus.loading;
    try {
      result = await paperRuleApi.updatePaperRule(
        id: id,
        questionType: questionType,
        questionNum: questionNum,
        singleScore: singleScore,
        serialNumber: serialNumber,
      );
      print(result.state);
      print(result.memo);
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
