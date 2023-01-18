import 'package:client/models/base.dart';
import 'package:client/models/base_list.dart';
import 'package:client/models/manager_model.dart';
import 'package:client/requests/manager_api.dart';
import 'package:flutter/widgets.dart';

enum OperationStatus {
  /// 加载中
  init,

  /// 加载中
  loading,

  /// 加载成功
  success,

  /// 加载成功，但数据为空
  empty,

  /// 加载失败
  failure,

  /// 请求失败
  disconnection,
}

class ApiResponse<T> {
  OperationStatus status;
  T? data;
  String? message;

  ApiResponse.init(this.message) : status = OperationStatus.init;

  ApiResponse.loading(this.message) : status = OperationStatus.loading;

  ApiResponse.success(this.data) : status = OperationStatus.success;

  ApiResponse.empty(this.message) : status = OperationStatus.empty;

  ApiResponse.failure(this.message) : status = OperationStatus.failure;

  ApiResponse.disconnection(this.message)
      : status = OperationStatus.disconnection;
}

class BaseNotifier extends ChangeNotifier {
  ValueNotifier operationStatus = ValueNotifier(OperationStatus.loading);
  String operationMemo = '';
  int operationCode = 0;

  late BaseModel result;
  late BaseListModel resultList;
  ManagerModel managerModel = ManagerModel();
  List<ManagerModel> managerListModel = [];

  ManagerApi managerApi = ManagerApi();
}
