import 'package:client/models/base_list.dart';
import 'package:client/providers/base_notifier.dart';

class ManagerNotifier extends BaseNotifier {
  Future<BaseListModel> fetchManagerList({
    int page = 1,
    int pageSize = 5,
    String stext = '',
    int state = 0,
    int permission = 0,
  }) async {
    return await managerApi.managerList(
      page: page,
      pageSize: pageSize,
      stext: stext,
      state: state,
      permission: permission,
    );
  }
}
