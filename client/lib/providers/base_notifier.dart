import 'package:client/models/base.dart';
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
  var state = ValueNotifier(OperationStatus.loading);
  var memo = '';
  var code = 0;

  late BaseModel result;
  var managerModel = ManagerModel();

  ManagerApi managerApi = ManagerApi();
}
