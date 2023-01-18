import 'dart:convert';
import 'package:client/Views/common/page_dropdown_button.dart';
import 'package:client/models/manager_model.dart';
import 'package:client/providers/manager_notifier.dart';
import 'package:client/public/lang.dart';
import 'package:client/public/tools.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:client/Views/common/menu.dart';
import 'package:flutter/services.dart';

PerPageDataDropdownButton perPageDataDropdownButton =
    PerPageDataDropdownButton();
StateDataDropdownButton stateDataDropdownButton = StateDataDropdownButton();

// ignore: must_be_immutable
class Manager extends StatefulWidget {
  late String headline;
  Manager({super.key, required this.headline});

  @override
  State<Manager> createState() => ManagerState();
}

class ManagerState extends State<Manager> {
  bool sortAscending = false;
  int sortColumnIndex = 0;
  int showSelected = 0;
  List<bool> selected = [];

  int page = 1;
  int pageSize = 3;
  String searchText = '';
  int state = 0;
  int totalPage = 0;

  TextEditingController jumpToController = TextEditingController();
  TextEditingController cupertinoSearchTextFieldController =
      TextEditingController();

  ManagerNotifier managerNotifier = ManagerNotifier();

  void fetchData() {
    managerNotifier
        .fetchManagerList(
      page: page,
      pageSize: pageSize,
      stext: searchText,
      state: state,
    )
        .then((value) {
      setState(() {
        totalPage = value.totalPage;
        managerNotifier.managerListModel =
            ManagerModel().fromJsonList(jsonEncode(value.data));
        selected = List<bool>.generate(
            managerNotifier.managerListModel.length, (int index) => false);
        showSelected = 0;
        searchText = '';
      });
    });
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  void dispose() {
    managerNotifier.dispose();
    super.dispose();
  }

  // 生成列表
  List<DataRow> generateList() {
    return List<DataRow>.generate(
      managerNotifier.managerListModel.length,
      (int index) => DataRow(
        cells: <DataCell>[
          DataCell(Text(managerNotifier.managerListModel[index].id.toString())),
          DataCell(Text(managerNotifier.managerListModel[index].account)),
          DataCell(
            Text(managerNotifier.managerListModel[index].name),
            showEditIcon: true,
            // placeholder: true, // 内容浅色显示
            onTap: () => print(
                'name is: ${managerNotifier.managerListModel[index].name}'),
          ),
          DataCell(Text(Tools().timestampToStr(
              managerNotifier.managerListModel[index].createTime))),
          DataCell(Text(Tools().timestampToStr(
              managerNotifier.managerListModel[index].updateTime))),
        ],
        selected: selected[index],
        onSelectChanged: (bool? value) {
          setState(() {
            showSelected += value! ? 1 : -1;
            selected[index] = value;
          });
        },
        onLongPress: () => print(managerNotifier.managerListModel[index].id),
      ),
    );
  }

  // 数据排序
  onSortColum(int columnIndex, bool ascending) {
    if (columnIndex == 0) {
      if (ascending) {
        managerNotifier.managerListModel.sort((a, b) => a.id.compareTo(b.id));
      } else {
        managerNotifier.managerListModel.sort((a, b) => b.id.compareTo(a.id));
      }
    }
    // 重置全选
    selected = List<bool>.generate(
      managerNotifier.managerListModel.length,
      (int index) {
        managerNotifier.managerListModel[index].selected = false;
        showSelected = 0;
        return false;
      },
    );
  }

  mainWidget(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: const EdgeInsets.all(0),
      margin: const EdgeInsets.all(0),
      color: Colors.grey,
      child: Container(
        margin: const EdgeInsets.all(10),
        color: Colors.white70,
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
                    /// header
                    SizedBox(
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          children: [
                            const SizedBox(width: 25),
                            Text(
                              '$showSelected items selected',
                              style: const TextStyle(
                                fontSize: 20,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                            const Expanded(child: SizedBox()),
                            SizedBox(
                              width: 200,
                              child: CupertinoSearchTextField(
                                controller: cupertinoSearchTextFieldController,
                                onSubmitted: (String value) {
                                  setState(() {
                                    searchText = value;
                                    fetchData();
                                  });
                                },
                              ),
                            ),
                            const SizedBox(width: 20),
                            Tooltip(
                              message: Lang().rowsPerPage,
                              child: perPageDataDropdownButton,
                            ),
                            const SizedBox(width: 10),
                            Tooltip(
                              message: Lang().status,
                              child: stateDataDropdownButton,
                            ),
                            const SizedBox(width: 10),
                            IconButton(
                              icon: const Icon(Icons.refresh),
                              onPressed: () {
                                setState(() {
                                  cupertinoSearchTextFieldController.clear();
                                  page = 1;
                                  fetchData();
                                });
                              },
                            ),
                            const SizedBox(width: 10),
                            IconButton(
                              icon: const Icon(Icons.add),
                              onPressed: () => print('add'),
                            ),
                            const SizedBox(width: 10),
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () => print('delete'),
                            ),
                          ],
                        ),
                      ),
                    ),

                    /// body
                    SizedBox(
                      width: double.infinity,
                      // height: double.infinity,
                      child: DataTable(
                        // headingRowHeight: 20, // 标题栏高度
                        // dataRowHeight: 50, // 数据栏高度
                        // horizontalMargin: 50, // 表格外边距
                        // columnSpacing: 50, // 单元格间距
                        showCheckboxColumn: true, // 是否展示复选框
                        checkboxHorizontalMargin: 50, // 复选框边距
                        sortAscending: sortAscending, // 升序降序
                        sortColumnIndex: sortColumnIndex, // 表格索引
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
                              setState(() {
                                sortColumnIndex = columnIndex;
                                sortAscending = ascending;
                                onSortColum(columnIndex, ascending);
                              });
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
                        rows: generateList(),
                      ),
                    ),

                    /// footer
                    SizedBox(
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.all(50),
                        child: Row(
                          children: [
                            const Expanded(child: SizedBox()),
                            SizedBox(
                              width: 65,
                              child: TextField(
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(7),
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'[0-9]')),
                                ],
                                decoration: InputDecoration(
                                  hintText: Lang().jumpTo,
                                  border: InputBorder.none,
                                ),
                                controller: jumpToController,
                                onSubmitted: (value) {
                                  setState(() {
                                    int onSubmittedData =
                                        int.parse(jumpToController.text);
                                    if (onSubmittedData >= 1 &&
                                        onSubmittedData <= pageSize &&
                                        onSubmittedData != page) {
                                      page = onSubmittedData;
                                      jumpToController.clear();
                                      fetchData();
                                    }
                                  });
                                },
                              ),
                            ),
                            const SizedBox(width: 20),
                            Text(page.toString()),
                            const Text('/'),
                            Text(totalPage.toString()),
                            const SizedBox(width: 20),
                            IconButton(
                              icon: const Icon(Icons.first_page),
                              onPressed: () {
                                setState(() {
                                  if (page != 1) {
                                    page = 1;
                                    fetchData();
                                  }
                                });
                              },
                            ),
                            const SizedBox(width: 20),
                            SizedBox(
                              child: TextButton(
                                  child: Text(
                                    Lang().previous,
                                    style: const TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                    ),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      if (page > 1) {
                                        page--;
                                        fetchData();
                                      }
                                    });
                                  }),
                            ),
                            const SizedBox(width: 20),
                            SizedBox(
                              child: TextButton(
                                  child: Text(
                                    Lang().next,
                                    style: const TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                    ),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      if (page < totalPage) {
                                        page++;
                                        fetchData();
                                      }
                                    });
                                  }),
                            ),
                          ],
                        ),
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
