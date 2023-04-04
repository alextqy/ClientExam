// ignore_for_file: file_names

import 'package:client/models/data.dart';
import 'package:client/providers/base_notifier.dart';
import 'package:client/models/data_list.dart';
import 'package:client/public/file.dart';
import 'package:client/public/lang.dart';

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
    DataModel result = DataModel();
    operationStatus.value = OperationStatus.loading;
    try {
      String fileType = FileHelper().type(filePath) ?? '';
      if (fileType != 'image/jpeg' && fileType != 'image/png' && fileType != 'image/gif') {
        operationStatus.value = OperationStatus.failure;
        operationMemo = Lang().wrongFileType;
      } else if (FileHelper().size(filePath) > 1024 * 1024 * 0.25 * 0.5 * 0.5) {
        operationStatus.value = OperationStatus.failure;
        operationMemo = Lang().theFileIsTooLarge;
      } else {
        result = await questionApi.questionAttachment(
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

  Future<DataModel> questionViewAttachments({
    required String filePath,
  }) async {
    return await questionApi.questionViewAttachments(
      filePath: filePath,
    );
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

  Future<DataListModel> questionList({
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
