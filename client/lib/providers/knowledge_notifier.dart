// ignore_for_file: file_names

import 'package:client/models/data.dart';
import 'package:client/providers/base_notifier.dart';
import 'package:client/models/data_list.dart';

class KnowledgeNotifier extends BaseNotifier {
  void newKnowledge({
    required String knowledgeName,
    required int subjectID,
  }) async {
    operationStatus.value = OperationStatus.loading;
    try {
      result = await knowledgeApi.newKnowledge(
        knowledgeName: knowledgeName,
        subjectID: subjectID,
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

  void knowledgeDisabled({
    required id,
  }) async {
    operationStatus.value = OperationStatus.loading;
    try {
      result = await knowledgeApi.knowledgeDisabled(
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

  void updateKnowledgeInfo({
    required int id,
    required String knowledgeName,
  }) async {
    operationStatus.value = OperationStatus.loading;
    try {
      result = await knowledgeApi.updateKnowledgeInfo(
        id: id,
        knowledgeName: knowledgeName,
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

  Future<DataListModel> knowledgeList({
    int page = 1,
    int pageSize = 10,
    String stext = '',
    int subjectID = 0,
    int knowledgeState = 0,
  }) async {
    return await knowledgeApi.knowledgeList(
      page: page,
      pageSize: pageSize,
      stext: stext,
      subjectID: subjectID,
      knowledgeState: knowledgeState,
    );
  }

  Future<DataModel> knowledgeInfo({
    required int id,
  }) async {
    return await knowledgeApi.knowledgeInfo(id: id);
  }

  Future<DataModel> knowledge({
    required int subjectID,
  }) async {
    return await knowledgeApi.knowledge(
      subjectID: subjectID,
    );
  }
}
