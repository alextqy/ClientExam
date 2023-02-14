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
import 'package:client/providers/class_notifier.dart';
import 'package:client/providers/examinee_notifier.dart';

import 'package:client/models/examinee_model.dart';
import 'package:client/models/class_model.dart';

// ignore: must_be_immutable
class Examinee extends StatefulWidget {
  late String headline;
  Examinee({super.key, required this.headline});

  @override
  State<Examinee> createState() => ExamineeState();
}

class ExamineeState extends State<Examinee> {
  bool sortAscending = false;
  int sortColumnIndex = 0;
  int showSelected = 0;
  List<bool> selected = [];
  String classSelectedName = Lang().notSelected;

  int page = 1;
  int pageSize = perPageDropList.first;
  String searchText = '';
  int classID = 0;
  String classMemo = '';
  int totalPage = 0;

  TextEditingController jumpToController = TextEditingController();
  TextEditingController cupertinoSearchTextFieldController =
      TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController newNameController = TextEditingController();
  TextEditingController newContactController = TextEditingController();
  TextEditingController newExamineeNoController = TextEditingController();

  ExamineeNotifier examineeNotifier = ExamineeNotifier();
  ClassNotifier classNotifier = ClassNotifier();

  basicListener() async {
    if (examineeNotifier.operationStatus.value == OperationStatus.loading) {
      Toast().show(context, message: Lang().loading);
    } else if (examineeNotifier.operationStatus.value ==
        OperationStatus.success) {
      fetchData();
      Toast().show(context, message: Lang().theOperationCompletes);
    } else {
      Toast().show(context, message: examineeNotifier.operationMemo);
    }
  }

  void fetchData() {
    examineeNotifier
        .examineeList(
      page: page,
      pageSize: pageSize,
      stext: searchText,
      classID: classID,
    )
        .then((value) {
      setState(() {
        examineeNotifier.examineeListModel =
            ExamineeModel().fromJsonList(jsonEncode(value.data));
        selected = List<bool>.generate(
            examineeNotifier.examineeListModel.length, (int index) => false);
        totalPage = value.totalPage;
        showSelected = 0;
        searchText = '';
        sortAscending = false;
      });
    });
  }

  void classesData() {
    classNotifier.classes().then((value) {
      setState(() {
        classNotifier.classListModel =
            ClassModel().fromJsonList(jsonEncode(value.data));
      });
    });
  }

  @override
  void initState() {
    super.initState();
    examineeNotifier.addListener(basicListener);
    fetchData();
    classesData();
  }

  @override
  void dispose() {
    examineeNotifier.dispose();
    examineeNotifier.removeListener(basicListener);
    super.dispose();
  }

  // 生成列表
  List<DataRow> generateList() {
    return List<DataRow>.generate(
      examineeNotifier.examineeListModel.length,
      (int index) => DataRow(
        cells: <DataCell>[
          DataCell(
            Text(
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                examineeNotifier.examineeListModel[index].id.toString()),
          ),
          DataCell(
            Tooltip(
              message: examineeNotifier.examineeListModel[index].contact,
              child: SizedBox(
                width: 150,
                child: Text(
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  examineeNotifier.examineeListModel[index].name,
                ),
              ),
            ),
            showEditIcon: true,
            // placeholder: true, // 内容浅色显示
            onTap: () {
              nameController.clear();
              nameAlertDialog(
                context,
                id: examineeNotifier.examineeListModel[index].id,
                name: examineeNotifier.examineeListModel[index].name,
                contact: examineeNotifier.examineeListModel[index].contact,
                classID: examineeNotifier.examineeListModel[index].classID,
              );
            },
          ),
          DataCell(
            Text(
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                examineeNotifier.examineeListModel[index].examineeNo),
          ),
          DataCell(
            Text(
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                Tools().timestampToStr(
                    examineeNotifier.examineeListModel[index].createTime)),
          ),
          DataCell(
            Text(
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              Lang().setUp,
            ),
            // placeholder: true, // 内容浅色显示
            onTap: () {
              classAlertDialog(
                context,
                id: examineeNotifier.examineeListModel[index].id,
                name: examineeNotifier.examineeListModel[index].name,
                contact: examineeNotifier.examineeListModel[index].contact,
                classID: examineeNotifier.examineeListModel[index].classID,
              );
            },
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

  List<DropdownMenuItem<ClassModel>> classDropdownMenuItemList() {
    List<DropdownMenuItem<ClassModel>> classDataDropdownMenuItemList = [];
    for (var element in classNotifier.classListModel) {
      DropdownMenuItem<ClassModel> data = DropdownMenuItem(
        value: element,
        child: SizedBox(
          width: 100,
          child: Text(
            element.className,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ),
      );
      classDataDropdownMenuItemList.add(data);
    }
    return classDataDropdownMenuItemList;
  }

  // 修改名称
  void nameAlertDialog(
    BuildContext context, {
    required int id,
    required String name,
    required String contact,
    required int classID,
  }) {
    nameController.clear();
    contactController.clear();
    nameController.text = name;
    contactController.text = contact;
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
                height: 100,
                child: Column(
                  children: [
                    TextField(
                      controller: nameController,
                      decoration: InputDecoration(
                        hintText: Lang().name,
                        suffixIcon: IconButton(
                          iconSize: 20,
                          onPressed: () => nameController.clear(),
                          icon: const Icon(Icons.clear),
                        ),
                      ),
                    ),
                    TextField(
                      controller: contactController,
                      decoration: InputDecoration(
                        hintText: Lang().contact,
                        suffixIcon: IconButton(
                          iconSize: 20,
                          onPressed: () => contactController.clear(),
                          icon: const Icon(Icons.clear),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    if (nameController.text.isNotEmpty && classID > 0) {
                      examineeNotifier.updateExaminee(
                        id: id,
                        name: nameController.text,
                        contact: contactController.text,
                        classID: classID,
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

  void classAlertDialog(
    BuildContext context, {
    required int id,
    required String name,
    required String contact,
    required int classID,
  }) {
    setState(() {
      int groupValue = classID;
      ListTile classListTile(ClassModel classData, Function state) {
        return ListTile(
          title: Text(classData.className),
          leading: Radio(
            value: classData.id,
            groupValue: groupValue,
            onChanged: (int? value) {
              state(() {
                groupValue = value!;
                examineeNotifier.updateExaminee(
                  id: id,
                  name: name,
                  contact: contact,
                  classID: groupValue,
                );
              });
            },
          ),
        );
      }

      List<ListTile> showClassList(Function state) {
        List<ListTile> radioList = [];
        for (int i = 0; i < classNotifier.classListModel.length; i++) {
          radioList.add(classListTile(classNotifier.classListModel[i], state));
        }
        return radioList;
      }

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
                  height: 400,
                  child: Padding(
                    padding: const EdgeInsets.all(0),
                    child: ListView(
                      children: showClassList(state),
                    ),
                  ),
                ),
              );
            },
          );
        },
      );
    });
  }

  // 新建
  void addAlertDialog(BuildContext context) {
    newExamineeNoController.clear();
    newNameController.clear();
    newContactController.clear();
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
                height: 200,
                child: Column(
                  children: [
                    SizedBox(
                      child: TextField(
                        controller: newNameController,
                        decoration: InputDecoration(
                          hintText: Lang().name,
                          suffixIcon: IconButton(
                            iconSize: 20,
                            onPressed: () => newNameController.clear(),
                            icon: const Icon(Icons.clear),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      child: TextField(
                        controller: newExamineeNoController,
                        decoration: InputDecoration(
                          hintText: Lang().examineeNo,
                          suffixIcon: IconButton(
                            iconSize: 20,
                            onPressed: () => newExamineeNoController.clear(),
                            icon: const Icon(Icons.clear),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      child: TextField(
                        controller: newContactController,
                        decoration: InputDecoration(
                          hintText: Lang().contact,
                          suffixIcon: IconButton(
                            iconSize: 20,
                            onPressed: () => newContactController.clear(),
                            icon: const Icon(Icons.clear),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Tooltip(
                      message: Lang().classes,
                      child: Row(
                        children: [
                          SizedBox(
                            height: 45,
                            child: DropdownButton(
                              itemHeight: 50,
                              hint: Text(
                                classSelectedName,
                                style: const TextStyle(color: Colors.black),
                              ),
                              icon: const Icon(Icons.arrow_drop_down),
                              style: const TextStyle(color: Colors.black),
                              // elevation: 16,
                              underline: Container(
                                height: 0,
                                // color: Colors.deepPurpleAccent,
                              ),
                              onChanged: (ClassModel? value) {
                                state(() {
                                  if (value!.id > 0) {
                                    classSelectedName = value.className;
                                    classID = value.id;
                                  }
                                });
                              },
                              items: classDropdownMenuItemList(),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    if (newExamineeNoController.text.isNotEmpty &&
                        newNameController.text.isNotEmpty &&
                        classID > 0) {
                      examineeNotifier.newExaminee(
                        examineeNo: newExamineeNoController.text,
                        name: newNameController.text,
                        classID: classID,
                        contact: newContactController.text,
                      );
                      state(() {
                        classSelectedName = Lang().notSelected;
                        classID = 0;
                      });
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
        examineeNotifier.examineeListModel.sort((a, b) => a.id.compareTo(b.id));
      } else {
        examineeNotifier.examineeListModel.sort((a, b) => b.id.compareTo(a.id));
      }
    }
    // 重置全选
    selected = List<bool>.generate(
      examineeNotifier.examineeListModel.length,
      (int index) {
        examineeNotifier.examineeListModel[index].selected = false;
        showSelected = 0;
        return false;
      },
    );
  }

  mainWidget(BuildContext context) {
    double widgetWidth = MediaQuery.of(context).size.width;
    double percentage = 0.2;
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
                      child: DropdownButton<int>(
                        itemHeight: 50,
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
                    Tooltip(
                      message: Lang().classes,
                      child: DropdownButton<ClassModel>(
                        itemHeight: 50,
                        hint: Text(
                          classSelectedName,
                          style: const TextStyle(color: Colors.black),
                        ),
                        icon: const Icon(Icons.arrow_drop_down),
                        style: const TextStyle(color: Colors.black),
                        // elevation: 16,
                        underline: Container(
                          height: 0,
                          // color: Colors.deepPurpleAccent,
                        ),
                        onChanged: (ClassModel? value) {
                          setState(() {
                            if (value!.id > 0) {
                              classID = value.id;
                              page = 1;
                              fetchData();
                              classSelectedName = value.className;
                            }
                          });
                        },
                        items: classDropdownMenuItemList(),
                      ),
                    ),
                    const SizedBox(width: 10),
                    IconButton(
                      icon: const Icon(Icons.refresh),
                      onPressed: () {
                        setState(() {
                          cupertinoSearchTextFieldController.clear();
                          classSelectedName = Lang().notSelected;
                          classID = 0;
                          page = 1;
                          fetchData();
                        });
                      },
                    ),
                    const SizedBox(width: 10),
                    IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () {
                        setState(() {
                          classSelectedName = Lang().notSelected;
                          classID = 0;
                          addAlertDialog(context);
                        });
                      },
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
                              Lang().name,
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
                              Lang().examineeNo,
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
                              Lang().classes,
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
      appBar: AppBar(title: Text(Lang().examinee)),
      body: mainWidget(context),
    );
  }
}
