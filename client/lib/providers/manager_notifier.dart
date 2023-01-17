import 'package:client/models/base_list.dart';
import 'package:client/models/manager_model.dart';
import 'package:client/providers/base_notifier.dart';
import 'package:client/public/lang.dart';
import 'package:client/public/tools.dart';
import 'package:flutter/material.dart';

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

class ManagerSourceData extends DataTableSource {
  int _selectCount = 0; // 当前选中的行数

  late final List<ManagerModel> _sourceData;

  ManagerSourceData(this._sourceData);

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => _sourceData.length;

  @override
  int get selectedRowCount => _selectCount;

  @override
  DataRow? getRow(int index) {
    assert(index >= 0);
    if (index >= _sourceData.length) return null;
    return DataRow.byIndex(
      index: index,
      selected: _sourceData[index].selected,
      onSelectChanged: (bool? selected) {
        if (_sourceData[index].selected != selected) {
          _selectCount += selected! ? 1 : -1;
          assert(_selectCount >= 0);
          _sourceData[index].selected = selected;
          notifyListeners();
        }
      },
      onLongPress: () => print(_sourceData[index].id),
      cells: [
        DataCell(
          Tooltip(
            message: Lang().longPress,
            child: Text(_sourceData[index].id.toString()),
          ),
        ),
        DataCell(
          Tooltip(
            message: Lang().longPress,
            child: Text(_sourceData[index].account),
          ),
        ),
        DataCell(
          Tooltip(
            message: Lang().longPress,
            child: Text(_sourceData[index].name),
          ),
        ),
        DataCell(
          Tooltip(
            message: Lang().longPress,
            child: Text(Tools().timestampToStr(_sourceData[index].createTime)),
          ),
        ),
        DataCell(
          Tooltip(
            message: Lang().longPress,
            child: Text(Tools().timestampToStr(_sourceData[index].updateTime)),
          ),
        ),
      ],
    );
  }

  void sortData<T>(
      Comparable<T> Function(ManagerModel object) getField, bool b) {
    _sourceData.sort((ManagerModel map1, ManagerModel map2) {
      if (!b) {
        // 两个项进行交换
        final ManagerModel temp = map1;
        map1 = map2;
        map2 = temp;
      }
      final Comparable<T> s1Value = getField(map1);
      final Comparable<T> s2Value = getField(map2);
      return Comparable.compare(s1Value, s2Value);
    });
    notifyListeners();
  }

  dynamic selectAll(bool? checked) {
    for (ManagerModel data in _sourceData) {
      data.selected = checked!;
    }
    _selectCount = checked! ? _sourceData.length : 0;
    notifyListeners(); // 通知监听器去刷新
  }
}
