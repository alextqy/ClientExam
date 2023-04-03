// ignore_for_file: file_names

import 'package:client/models/data.dart';
import 'package:client/providers/base_notifier.dart';

class SysConfNotifier extends BaseNotifier {
  List<Map<String, String>> imageDict = [];

  Future<DataModel> configInfo({
    required String key,
  }) async {
    return await sysConfApi.configInfo(key: key);
  }

  Future<DataModel> imageList() async {
    imageDict = [];
    return await sysConfApi.imageList();
  }

  void imageRemove({
    required String imageID,
  }) async {
    operationStatus.value = OperationStatus.loading;
    try {
      result = await sysConfApi.imageRemove(
        imageID: imageID,
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

  void buildEnvironment({
    required String language,
    required String version,
  }) async {
    operationStatus.value = OperationStatus.loading;
    try {
      result = await sysConfApi.buildEnvironment(
        language: language,
        version: version,
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

  Future<DataModel> codeExecTest({
    required String language,
    required String version,
    required String codeStr,
  }) async {
    return await sysConfApi.codeExecTest(
      language: language,
      version: version,
      codeStr: codeStr,
    );
  }
}
