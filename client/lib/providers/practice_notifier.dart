// ignore_for_file: file_names

import 'package:client/providers/base_notifier.dart';
// import 'package:client/models/base_list.dart';

class PracticeNotifier extends BaseNotifier {
  void signInPractice({
    required String examineeNo,
  }) async {
    operationStatus.value = OperationStatus.loading;
    try {
      result = await practiceApi.signInPractice(
        examineeNo: examineeNo,
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

  void newPractice({
    required int questionType,
  }) async {
    operationStatus.value = OperationStatus.loading;
    try {
      result = await practiceApi.newPractice(
        questionType: questionType,
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

  void practiceInfo({
    required int id,
  }) async {
    operationStatus.value = OperationStatus.loading;
    try {
      result = await practiceApi.practiceInfo(
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

  void practiceAnswer({
    required int practiceID,
    required int id,
    required String answer,
  }) async {
    operationStatus.value = OperationStatus.loading;
    try {
      result = await practiceApi.practiceAnswer(
        practiceID: practiceID,
        id: id,
        answer: answer,
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

  void gradeThePractice({
    required int id,
  }) async {
    operationStatus.value = OperationStatus.loading;
    try {
      result = await practiceApi.gradeThePractice(
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

  void practiceDelete({
    required int id,
  }) async {
    operationStatus.value = OperationStatus.loading;
    try {
      result = await practiceApi.practiceDelete(
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
