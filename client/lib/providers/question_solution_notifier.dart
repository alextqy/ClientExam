// ignore_for_file: file_names

import 'package:client/providers/base_notifier.dart';
import 'package:client/models/data_list.dart';
import 'package:client/models/data.dart';
import 'package:client/public/file.dart';
import 'package:client/public/lang.dart';

class QuestionSolutionNotifier extends BaseNotifier {
  void newQuestionSolution({
    required int questionID,
    required String option,
    required int correctAnswer,
    required String correctItem,
    required double scoreRatio,
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
    DataModel result = DataModel();
    operationStatus.value = OperationStatus.loading;
    try {
      var fileType = FileHelper().type(filePath);
      if (fileType != 'image/jpeg' && fileType != 'image/png' && fileType != 'image/gif') {
        operationStatus.value = OperationStatus.failure;
        operationMemo = Lang().wrongFileType;
      } else if (FileHelper().size(filePath) > 1024 * 1024 * 0.25 * 0.5) {
        operationStatus.value = OperationStatus.failure;
        operationMemo = Lang().theFileIsTooLarge;
      } else {
        result = await questionSolutionApi.questionSolutionAttachment(
          id: id,
          filePath: filePath,
          contentType: fileType ?? '',
        );
        if (result.state == true) {
          operationStatus.value = OperationStatus.success;
        } else {
          operationStatus.value = OperationStatus.failure;
          operationMemo = result.memo;
        }
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

  Future<DataModel> questionSolutionViewAttachments({
    required String filePath,
  }) async {
    return await questionSolutionApi.questionSolutionViewAttachments(
      filePath: filePath,
    );
  }

  void setScoreRatio({
    required int id,
    required double scoreRatio,
  }) async {
    operationStatus.value = OperationStatus.loading;
    try {
      result = await questionSolutionApi.setScoreRatio(
        id: id,
        scoreRatio: scoreRatio,
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

  void setCorrectItem({
    required int id,
    required String correctItem,
  }) async {
    operationStatus.value = OperationStatus.loading;
    try {
      result = await questionSolutionApi.setCorrectItem(
        id: id,
        correctItem: correctItem,
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
