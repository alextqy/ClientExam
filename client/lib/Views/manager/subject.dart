// ignore_for_file: file_names

import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:client/public/lang.dart';
import 'package:client/public/tools.dart';
import 'package:client/Views/common/basic_info.dart';
import 'package:client/Views/common/toast.dart';
import 'package:client/Views/common/menu.dart';

import 'package:client/providers/base_notifier.dart';
import 'package:client/providers/subject_notifier.dart';

import 'package:client/models/subject_model.dart';

// ignore: must_be_immutable
class Subject extends StatefulWidget {
  late String headline;
  Subject({super.key, required this.headline});

  @override
  State<Subject> createState() => SubjectState();
}

class SubjectState extends State<Subject> {
  bool sortAscending = false;
  int sortColumnIndex = 0;
  int showSelected = 0;
  List<bool> selected = [];

  int page = 1;
  int pageSize = perPageDropList.first;
  String searchText = '';
  int state = 0;
  String stateMemo = stateDropList.first;
  int totalPage = 0;

  TextEditingController jumpToController = TextEditingController();
  TextEditingController cupertinoSearchTextFieldController =
      TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController newNameController = TextEditingController();

  SubjectNotifier subjectNotifier = SubjectNotifier();

  basicListener() async {
    if (subjectNotifier.operationStatus.value == OperationStatus.loading) {
      Toast().show(context, message: Lang().loading);
    } else if (subjectNotifier.operationStatus.value ==
        OperationStatus.success) {
      fetchData();
      Toast().show(context, message: Lang().theOperationCompletes);
    } else {
      Toast().show(context, message: subjectNotifier.operationMemo);
    }
  }

  void fetchData() {
    subjectNotifier
        .subjectList(
      page: page,
      pageSize: pageSize,
      stext: searchText,
      subjectState: state,
    )
        .then((value) {
      setState(() {
        subjectNotifier.subjectListModel =
            SubjectModel().fromJsonList(jsonEncode(value.data));
        selected = List<bool>.generate(
            subjectNotifier.subjectListModel.length, (int index) => false);
        totalPage = value.totalPage;
        showSelected = 0;
        searchText = '';
        sortAscending = false;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    subjectNotifier.addListener(basicListener);
    fetchData();
  }

  @override
  void dispose() {
    subjectNotifier.dispose();
    subjectNotifier.removeListener(basicListener);
    super.dispose();
  }

  // 生成列表
  List<DataRow> generateList() {
    return List<DataRow>.generate(
      subjectNotifier.subjectListModel.length,
      (int index) => DataRow(
        color: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
          // All rows will have the same selected color.
          if (states.contains(MaterialState.selected)) {
            return Theme.of(context).colorScheme.primary.withOpacity(0.2);
          }
          // Even rows will have a grey color.
          // if (index.isEven) {
          //   return Colors.grey.withOpacity(0.3);
          // }
          return null; // Use default value for other states and odd rows.
        }),
        cells: <DataCell>[
          DataCell(
            Text(
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                subjectNotifier.subjectListModel[index].id.toString()),
          ),
          DataCell(
            SizedBox(
              width: 150,
              child: Text(
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  subjectNotifier.subjectListModel[index].subjectName),
            ),
            showEditIcon: true,
            // placeholder: true, // 内容浅色显示
            onTap: () {
              nameController.clear();
              nameAlertDialog(
                context,
                id: subjectNotifier.subjectListModel[index].id,
                name: subjectNotifier.subjectListModel[index].subjectName,
              );
            },
          ),
          DataCell(
            Text(
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                subjectNotifier.subjectListModel[index].subjectCode),
          ),
          DataCell(
            Text(
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                Tools().timestampToStr(
                    subjectNotifier.subjectListModel[index].createTime)),
          ),
          DataCell(
            Text(
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                Tools().timestampToStr(
                    subjectNotifier.subjectListModel[index].updateTime)),
          ),
          DataCell(
            CupertinoSwitch(
              value: subjectNotifier.subjectListModel[index].subjectState == 1
                  ? true
                  : false,
              onChanged: (bool? value) {
                setState(() {
                  subjectNotifier.subjectDisabled(
                      id: subjectNotifier.subjectListModel[index].id);
                });
              },
            ),
          ),
        ],
        selected: selected[index],
        onSelectChanged: (bool? value) {
          setState(() {
            showSelected += value! ? 1 : -1;
            selected[index] = value;
          });
        },
      ),
    );
  }

  // 修改名称
  void nameAlertDialog(
    BuildContext context, {
    required int id,
    required String name,
  }) {
    nameController.clear();
    nameController.text = name;
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, Function state) {
            return AlertDialog(
              title: Text(Lang().title),
              content: SizedBox(
                width: 100,
                child: TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      iconSize: 20,
                      onPressed: () => nameController.clear(),
                      icon: const Icon(Icons.clear),
                    ),
                  ),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    if (nameController.text.isNotEmpty) {
                      subjectNotifier.updateSubjectInfo(
                        id: id,
                        subjectName: nameController.text,
                      );
                      Navigator.of(context).pop();
                    }
                  },
                  child: Text(Lang().confirm),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(Lang().cancel),
                ),
              ],
            );
          },
        );
      },
    );
  }

  // 新建
  void addAlertDialog(BuildContext context) {
    newNameController.clear();
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, Function state) {
            return AlertDialog(
              title: Text(Lang().title),
              content: SizedBox(
                width: 100,
                height: 50,
                child: Column(
                  children: [
                    SizedBox(
                      child: TextField(
                        controller: newNameController,
                        decoration: InputDecoration(
                          hintText: Lang().subjectName,
                          suffixIcon: IconButton(
                            iconSize: 20,
                            onPressed: () => newNameController.clear(),
                            icon: const Icon(Icons.clear),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    if (newNameController.text.isNotEmpty) {
                      subjectNotifier.newSubject(
                        subjectName: newNameController.text,
                      );
                      fetchData();
                      Navigator.of(context).pop();
                    }
                  },
                  child: Text(Lang().confirm),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(Lang().cancel),
                ),
              ],
            );
          },
        );
      },
    );
  }

  // 数据排序
  onSortColum(int columnIndex, bool ascending) {
    if (columnIndex == 0) {
      if (ascending) {
        subjectNotifier.subjectListModel.sort((a, b) => a.id.compareTo(b.id));
      } else {
        subjectNotifier.subjectListModel.sort((a, b) => b.id.compareTo(a.id));
      }
    }
    // 重置全选
    selected = List<bool>.generate(
      subjectNotifier.subjectListModel.length,
      (int index) {
        subjectNotifier.subjectListModel[index].selected = false;
        showSelected = 0;
        return false;
      },
    );
  }

  mainWidget(BuildContext context) {
    double widgetWidth = MediaQuery.of(context).size.width;
    double percentage = 0.15;
    ScrollController controllerOutside = ScrollController();
    ScrollController controllerInside = ScrollController();
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: const EdgeInsets.all(0),
      margin: const EdgeInsets.all(0),
      color: Colors.grey,
      child: Container(
        padding: const EdgeInsets.all(0),
        margin: const EdgeInsets.all(10),
        color: Colors.white70,
        child: Column(
          children: [
            /// header
            SizedBox(
              width: double.infinity,
              height: 50,
              child: Container(
                width: double.infinity,
                height: double.infinity,
                padding: const EdgeInsets.all(0),
                margin: const EdgeInsets.all(0),
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
                    Tooltip(
                      message: Lang().status,
                      child: DropdownButton<String>(
                        value: stateMemo,
                        icon: const Icon(Icons.arrow_drop_down),
                        style: const TextStyle(color: Colors.black),
                        // elevation: 16,
                        underline: Container(
                          height: 0,
                          // color: Colors.deepPurpleAccent,
                        ),
                        onChanged: (String? value) {
                          setState(() {
                            if (stateMemo != value!) {
                              stateMemo = value;
                              if (value == Lang().all) {
                                state = 0;
                              } else {
                                state = Lang().normal == value ? 1 : 2;
                              }
                              page = 1;
                              fetchData();
                            }
                          });
                        },
                        items: stateDropList
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                    const SizedBox(width: 10),
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
                    const SizedBox(width: 10),
                    Tooltip(
                      message: Lang().rowsPerPage,
                      child: DropdownButton<int>(
                        value: pageSize,
                        icon: const Icon(Icons.arrow_drop_down),
                        style: const TextStyle(color: Colors.black),
                        // elevation: 16,
                        underline: Container(
                          height: 0,
                          // color: Colors.deepPurpleAccent,
                        ),
                        onChanged: (int? value) {
                          setState(() {
                            pageSize = value!;
                            page = 1;
                            fetchData();
                          });
                        },
                        items: perPageDropList
                            .map<DropdownMenuItem<int>>((int value) {
                          return DropdownMenuItem<int>(
                            value: value,
                            child: Text(value.toString()),
                          );
                        }).toList(),
                      ),
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
                      onPressed: () => addAlertDialog(context),
                    ),
                    // const SizedBox(width: 10),
                    // IconButton(
                    //   icon: const Icon(Icons.delete),
                    //   onPressed: () => print('delete'),
                    // ),
                  ],
                ),
              ),
            ),

            /// body
            Expanded(
              child: Scrollbar(
                controller: controllerOutside,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  controller: controllerOutside,
                  child: SingleChildScrollView(
                    controller: controllerInside,
                    scrollDirection: Axis.vertical,
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
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
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
                          label: SizedBox(
                            width: widgetWidth * percentage,
                            child: Text(
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              Lang().subjectName,
                              style: const TextStyle(
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ),
                        ),
                        DataColumn(
                          label: SizedBox(
                            width: widgetWidth * percentage,
                            child: Text(
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              Lang().subjectCode,
                              style: const TextStyle(
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ),
                        ),
                        DataColumn(
                          label: SizedBox(
                            width: widgetWidth * percentage,
                            child: Text(
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              Lang().createtime,
                              style: const TextStyle(
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ),
                        ),
                        DataColumn(
                          label: SizedBox(
                            width: widgetWidth * percentage,
                            child: Text(
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              Lang().updateTime,
                              style: const TextStyle(
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ),
                        ),
                        DataColumn(
                          label: SizedBox(
                            width: widgetWidth * percentage,
                            child: Text(
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              Lang().status,
                              style: const TextStyle(
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ),
                        ),
                      ],
                      rows: generateList(),
                    ),
                  ),
                ),
              ),
            ),

            /// footer
            SizedBox(
              width: double.infinity,
              height: 50,
              child: Container(
                width: double.infinity,
                height: double.infinity,
                padding: const EdgeInsets.all(0),
                margin: const EdgeInsets.all(0),
                child: Row(
                  children: [
                    const Expanded(child: SizedBox()),
                    SizedBox(
                      width: 65,
                      child: TextField(
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(7),
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
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
                                onSubmittedData <= totalPage &&
                                onSubmittedData != page) {
                              page = onSubmittedData;
                              fetchData();
                            }
                            jumpToController.clear();
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
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Menu().drawer(context, headline: widget.headline),
      appBar: AppBar(title: Text(Lang().examSubjects)),
      body: mainWidget(context),
    );
  }
}
