import 'dart:convert';
import 'package:client/Views/common/error_page.dart';
import 'package:client/Views/common/page_dropdown_button.dart';
import 'package:client/Views/common/search.dart';
import 'package:client/models/base_list.dart';
import 'package:client/models/manager_model.dart';
import 'package:client/public/lang.dart';
import 'package:client/public/tools.dart';
import 'package:client/requests/manager_api.dart';
import 'package:flutter/material.dart';
import 'package:client/Views/common/menu.dart';

var perPageDataDropdownButton = PerPageDataDropdownButton();
var stateDataDropdownButton = StateDataDropdownButton();

int page = 1;
int pageSize = 10;
var result = ManagerApi().managerList(page: page, pageSize: pageSize);

// ignore: must_be_immutable
class Manager extends StatefulWidget {
  late String headline;
  Manager({super.key, required this.headline});

  @override
  // ignore: no_logic_in_create_state
  State<Manager> createState() => ManagerState();
}

class ManagerState extends State<Manager> {
  bool isChecked = false;
  bool sortAscending = false;
  int sortColumnIndex = 0;
  String searchText = '';
  late ManagerSourceData managerSourceData;

  mainWidget(BuildContext context, {dynamic data}) {
    data as List<ManagerModel>;
    managerSourceData = ManagerSourceData(data);

    int contPageSize() {
      if (pageSize >= data.length) {
        return data.length;
      } else {
        return pageSize;
      }
    }

    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: const EdgeInsets.all(0),
      margin: const EdgeInsets.all(0),
      color: Colors.grey,
      child: Container(
        margin: const EdgeInsets.all(10),
        color: Colors.white54,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(0),
            child: SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                // child: SingleChildScrollView(
                //   scrollDirection: Axis.horizontal,
                child: Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      // height: double.infinity,
                      child: PaginatedDataTable(
                        rowsPerPage: contPageSize(), // 每页展示数据量
                        headingRowHeight: 50, // 标题栏高度
                        dataRowHeight: 50, // 数据栏高度
                        horizontalMargin: 50, // 表格外边距
                        // columnSpacing: 50, // 单元格间距
                        showCheckboxColumn: true, // 是否展示复选框
                        checkboxHorizontalMargin: 50, // 复选框边距
                        sortAscending: sortAscending, // 升序降序
                        sortColumnIndex: sortColumnIndex, // 表格索引
                        // 每页展示数据量选项
                        // availableRowsPerPage: const [10, 50, 100],
                        // onRowsPerPageChanged: (value) =>
                        //     setState(() => pageSize = value!), // 每页数据量变更回调
                        // 全选
                        onSelectAll: ((value) {
                          isChecked = value!;
                          managerSourceData.selectAll(value);
                        }),
                        // 表头
                        header: const Text(
                          '',
                          style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                        // 功能按钮
                        actions: [
                          SizedBox(
                            width: 200,
                            child: SearchTextField(
                              fieldValue: (String value) {
                                setState(() {
                                  searchText = value;
                                });
                              },
                            ),
                          ),
                          Tooltip(
                            message: Lang().rowsPerPage,
                            child: perPageDataDropdownButton,
                          ),
                          Tooltip(
                            message: Lang().status,
                            child: stateDataDropdownButton,
                          ),
                          IconButton(
                            icon: const Icon(Icons.refresh),
                            onPressed: () => print('refresh'),
                          ),
                          IconButton(
                            icon: const Icon(Icons.add),
                            onPressed: () => print('add'),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () => print('delete'),
                          ),
                        ],
                        // 标题栏
                        columns: [
                          DataColumn(
                            label: Row(
                              children: const [
                                Text(
                                  'ID',
                                  style: TextStyle(fontStyle: FontStyle.italic),
                                ),
                              ],
                            ),
                            // onSort: (columnIndex, ascending) {
                            //   setState(
                            //     () {
                            //       sortColumnIndex = columnIndex;
                            //       sortAscending = ascending;
                            //       managerSourceData.sortData(
                            //         (obj) => obj.id,
                            //         ascending,
                            //       );
                            //     },
                            //   );
                            // },
                          ),
                          DataColumn(
                            label: Text(
                              Lang().account,
                              style: const TextStyle(
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              Lang().name,
                              style: const TextStyle(
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              Lang().createtime,
                              style: const TextStyle(
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              Lang().updateTime,
                              style: const TextStyle(
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ),
                        ],
                        source: managerSourceData,
                      ),
                    ),
                  ],
                ),
                // ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Menu().drawer(context, headline: widget.headline),
      appBar: AppBar(title: Text(Lang().managers)),
      body: FutureBuilder(
        future: result,
        builder: (context, snapshot) {
          Widget widget;
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              widget = errorPage();
            } else {
              BaseListModel basicData = snapshot.data as BaseListModel;
              var managerList = managerFromJsonList(jsonEncode(basicData.data));
              widget = mainWidget(context, data: managerList);
            }
          } else {
            widget = const Padding(
              padding: EdgeInsets.all(20),
              child: CircularProgressIndicator(),
            );
          }
          return Center(child: widget);
        },
      ),
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
    for (var data in _sourceData) {
      data.selected = checked!;
    }
    _selectCount = checked! ? _sourceData.length : 0;
    notifyListeners(); // 通知监听器去刷新
  }
}
