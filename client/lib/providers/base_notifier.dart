import 'package:client/models/base.dart';
import 'package:client/models/base_list.dart';
import 'package:client/models/manager_model.dart';
import 'package:client/requests/manager_api.dart';
import 'package:flutter/widgets.dart';

enum OperationStatus {
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
