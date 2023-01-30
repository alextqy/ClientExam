// ignore_for_file: file_names

import 'package:client/providers/base_notifier.dart';
import 'package:client/models/base_list.dart';

class QuestionNotifier extends BaseNotifier {
  void newQuestion({
    required String questionTitle,
    required int questionType,
    required int knowledgeID,
    required String description,
    required String language,
    required String languageVersion,
  }) async {
    operationStatus.value = OperationStatus.loading;
    try {
      result = await questionApi.newQuestion(
        questionTitle: questionTitle,
        questionType: questionType,
        knowledgeID: knowledgeID,
        description: description,
        language: language,
        languageVersion: languageVersion,
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

  void questionAttachment({
    required int id,
    required String filePath,
  }) async {
    operationStatus.value = OperationStatus.loading;
    try {
      bool result = await questionApi.questionAttachment(
        id: id,
        filePath: filePath,
      );
      if (result == true) {
        operationStatus.value = OperationStatus.success;
      } else {
        operationStatus.value = OperationStatus.failure;
        // operationMemo = result.memo;
      }
    } catch (e) {
      operationStatus.value = OperationStatus.failure;
      operationMemo = e.toString();
    } finally {
      notifyListeners();
    }
  }

  void questionViewAttachments({
    required String filePath,
  }) async {
    operationStatus.value = OperationStatus.loading;
    try {
      result = await questionApi.questionViewAttachments(
        filePath: filePath,
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

  void questionDisabled({
    required int id,
  }) async {
    operationStatus.value = OperationStatus.loading;
    try {
      result = await questionApi.questionDisabled(
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

  void updateQuestionInfo({
    required int id,
    required String questionTitle,
    required int questionType,
    required String description,
    required String language,
    required String languageVersion,
  }) async {
    operationStatus.value = OperationStatus.loading;
    try {
      result = await questionApi.updateQuestionInfo(
        id: id,
        questionTitle: questionTitle,
        questionType: questionType,
        description: description,
        language: language,
        languageVersion: languageVersion,
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

  Future<BaseListModel> questionList({
    int page = 1,
    int pageSize = 10,
    String stext = '',
    int questionType = 0,
    int questionState = 0,
    int knowledgeID = 0,
  }) async {
    return await questionApi.questionList(
      page: page,
      pageSize: pageSize,
      stext: stext,
      questionType: questionType,
      questionState: questionState,
      knowledgeID: knowledgeID,
    );
  }

  void questionInfo({
    required int id,
  }) async {
    operationStatus.value = OperationStatus.loading;
    try {
      result = await questionApi.questionInfo(
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
