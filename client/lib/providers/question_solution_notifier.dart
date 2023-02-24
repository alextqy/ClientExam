// ignore_for_file: file_names

import 'package:client/providers/base_notifier.dart';
import 'package:client/models/data_list.dart';
import 'package:client/models/data.dart';

class QuestionSolutionNotifier extends BaseNotifier {
  void newQuestionSolution({
    required int questionID,
    required String option,
    required int correctAnswer,
    required String correctItem,
    required int scoreRatio,
    required int position,
  }) async {
    operationStatus.value = OperationStatus.loading;
    try {
      result = await questionSolutionApi.newQuestionSolution(
        questionID: questionID,
        option: option,
        correctAnswer: correctAnswer,
        correctItem: correctItem,
        scoreRatio: scoreRatio,
        position: position,
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

  void questionSolutionAttachment({
    required int id,
    required String filePath,
  }) async {
    operationStatus.value = OperationStatus.loading;
    try {
      DataModel result = await questionSolutionApi.questionSolutionAttachment(
        id: id,
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

  void questionSolutionDelete({
    required int id,
  }) async {
    operationStatus.value = OperationStatus.loading;
    try {
      result = await questionSolutionApi.questionSolutionDelete(
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

  Future<DataListModel> questionSolutionList({
    int page = 1,
    int pageSize = 10,
    int questionID = 0,
  }) async {
    return await questionSolutionApi.questionSolutionList(
      page: page,
      pageSize: pageSize,
      questionID: questionID,
    );
  }

  Future<DataModel> questionSolutions({
    required int questionID,
    int position = 0,
  }) async {
    return await questionSolutionApi.questionSolutions(
      questionID: questionID,
      position: position,
    );
  }

  void questionSolutionViewAttachments({
    required String filePath,
  }) async {
    operationStatus.value = OperationStatus.loading;
    try {
      result = await questionSolutionApi.questionSolutionViewAttachments(
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
}
