import 'dart:convert';
import 'package:client/Views/common/page_dropdown_button.dart';
import 'package:client/Views/common/search.dart';
import 'package:client/models/manager_model.dart';
import 'package:client/providers/manager_notifier.dart';
import 'package:client/public/lang.dart';
import 'package:flutter/material.dart';
import 'package:client/Views/common/menu.dart';

PerPageDataDropdownButton perPageDataDropdownButton =
    PerPageDataDropdownButton();
StateDataDropdownButton stateDataDropdownButton = StateDataDropdownButton();

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
  int rowsPerPage = 10;
  ManagerNotifier managerNotifier = ManagerNotifier();

  @override
  void initState() {
    super.initState();
    managerNotifier.fetchManagerList().then((value) {
      setState(() {
        managerNotifier.managerListModel =
            ManagerModel().fromJsonList(jsonEncode(value.data));
      });
    });
  }

  int countPageSize() {
    if (managerNotifier.managerListModel.isNotEmpty &&
        rowsPerPage >= managerNotifier.managerListModel.length) {
      return managerNotifier.managerListModel.length;
    } else {
      return rowsPerPage;
    }
  }

  mainWidget(BuildContext context) {
    ManagerSourceData managerSourceData =
        ManagerSourceData(managerNotifier.managerListModel);

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
                        rowsPerPage: countPageSize(), // 每页展示数据量
                        // headingRowHeight: 50, // 标题栏高度
                        // dataRowHeight: 50, // 数据栏高度
                        // horizontalMargin: 50, // 表格外边距
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
                          const SizedBox(width: 10),
                          Tooltip(
                            message: Lang().rowsPerPage,
                            child: perPageDataDropdownButton,
                          ),
                          const SizedBox(width: 10),
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
                            onSort: (columnIndex, ascending) {
                              setState(
                                () {
                                  sortColumnIndex = columnIndex;
                                  sortAscending = ascending;
                                  managerSourceData.sortData(
                                    (obj) => obj.id,
                                    ascending,
                                  );
                                },
                              );
                            },
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
      body: mainWidget(context),
    );
  }
}
