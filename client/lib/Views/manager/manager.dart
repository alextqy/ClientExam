import 'dart:convert';
import 'package:client/Views/common/error_page.dart';
import 'package:client/Views/common/page_dropdown_button.dart';
import 'package:client/models/base_list.dart';
import 'package:client/models/manager_model.dart';
import 'package:client/public/lang.dart';
import 'package:client/public/tools.dart';
import 'package:client/requests/manager_api.dart';
import 'package:flutter/material.dart';
import 'package:client/Views/common/menu.dart';

var perPageDataDropdownButton = PerPageDataDropdownButton();
var stateDataDropdownButton = StateDataDropdownButton();

// ignore: must_be_immutable
class Manager extends StatefulWidget {
  late String headline;
  Manager({super.key, required this.headline});

  @override
  // ignore: no_logic_in_create_state
  State<Manager> createState() => ManagerState(headline: headline);
}

class ManagerState extends State<Manager> {
  late String headline;
  int page = 1;
  int pageSize = 10;
  bool sortAscending = true;
  ManagerState({this.headline = ''});

  mainWidget(BuildContext context, {dynamic data}) {
    data as List<ManagerModel>;
    var managerSourceData = ManagerSourceData(data);

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
                          columnSpacing: 100, // 单元格间距
                          showCheckboxColumn: true, // 是否展示复选框
                          checkboxHorizontalMargin: 50, // 复选框边距
                          // sortAscending: sortAscending, // 升序降序
                          // sortColumnIndex: 1, // 表格索引
                          // 每页展示数据量选项
                          availableRowsPerPage: const [10, 50, 100],
                          // onRowsPerPageChanged: (value) =>
                          //     setState(() => pageSize = value!), // 每页数据量变更回调
                          // 全选
                          // onSelectAll: (state) => setState(
                          //   () => managerSourceData.selectAll(state!),
                          // ),
                          // 表头
                          header: const Text(
                            'List',
                            style: TextStyle(fontStyle: FontStyle.italic),
                          ),
                          // 功能按钮
                          actions: [
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
                                    style:
                                        TextStyle(fontStyle: FontStyle.italic),
                                  ),
                                  // SizedBox(child: Icon(Icons.arrow_drop_down)),
                                ],
                              ),
                              // onSort: (columnIndex, ascending) {
                              //   setState(
                              //     () {
                              //       sortAscending = ascending;
                              //       managerSourceData.sortData(
                              //         (map) => map['ID'],
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
        ));
  }

  @override
  Widget build(BuildContext context) {
    var result = ManagerApi().managerList(page: page, pageSize: pageSize);

    return Scaffold(
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
      drawer: Menu().drawer(context, headline: headline),
    );
  }
}

class ManagerSourceData extends DataTableSource {
  int _selectCount = 0; // 当前选中的行数

  late List<Map<String, dynamic>> _sourceData;

  @override
  bool get isRowCountApproximate => false;

  @override
  late int rowCount;

  @override
  late int selectedRowCount;

  late List<ManagerModel> list;

  ManagerSourceData(this.list) {
    _sourceData = dataForeach(list);
    rowCount = _sourceData.length;
    selectedRowCount = _selectCount;
  }

  List<Map<String, dynamic>> dataForeach(List<ManagerModel> list) {
    return List<Map<String, dynamic>>.generate(
      list.length,
      (index) => {
        'ID': list[index].id.toString(),
        'account': list[index].account,
        'name': list[index].name,
        'createTime': Tools().timestampToStr(list[index].createTime),
        'updateTime': Tools().timestampToStr(list[index].updateTime),
        'selected': false,
      },
    );
  }

  @override
  DataRow getRow(int index) => DataRow.byIndex(
        index: index,
        selected: _sourceData[index]['selected'],
        onSelectChanged: (selected) {
          _sourceData[index]['selected'] = selected;
          notifyListeners();
        },
        cells: [
          DataCell(Text(list[index].id.toString())),
          DataCell(Text(list[index].account)),
          DataCell(Text(list[index].name)),
          DataCell(Text(Tools().timestampToStr(list[index].createTime))),
          DataCell(Text(Tools().timestampToStr(list[index].updateTime))),
        ],
      );

  void sortData<T>(
      Comparable<T> Function(Map<String, dynamic> map) getField, bool b) {
    _sourceData.sort((Map<String, dynamic> map1, Map<String, dynamic> map2) {
      if (!b) {
        // 两个项进行交换
        final Map<String, dynamic> temp = map1;
        map1 = map2;
        map2 = temp;
      }
      final Comparable<T> s1Value = getField(map1);
      final Comparable<T> s2Value = getField(map2);
      return Comparable.compare(s1Value, s2Value);
    });
    notifyListeners();
  }

  void selectAll(bool checked) {
    for (var data in _sourceData) {
      data['selected'] = checked;
    }
    _selectCount = checked ? _sourceData.length : 0;
    notifyListeners(); // 通知监听器去刷新
  }
}
