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
import 'package:client/providers/teacher_notifier.dart';
import 'package:client/providers/class_notifier.dart';
import 'package:client/providers/teacher_class_notifier.dart';

import 'package:client/models/teacher_model.dart';
import 'package:client/models/class_model.dart';

// ignore: must_be_immutable
class Teacher extends StatefulWidget {
  late String headline;
  Teacher({super.key, required this.headline});

  @override
  State<Teacher> createState() => TeacherState();
}

class TeacherState extends State<Teacher> {
  bool sortAscending = false;
  int sortColumnIndex = 0;
  int showSelected = 0;
  List<bool> selected = [];
  List<bool> classSelected = [];

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
  TextEditingController passworController = TextEditingController();
  TextEditingController newAccountController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController newNameController = TextEditingController();

  TeacherNotifier teacherNotifier = TeacherNotifier();
  ClassNotifier classNotifier = ClassNotifier();
  TeacherClassNotifier teacherClassNotifier = TeacherClassNotifier();

  basicListener() async {
    if (teacherNotifier.operationStatus.value == OperationStatus.loading) {
      Toast().show(context, message: Lang().loading);
    } else if (teacherNotifier.operationStatus.value ==
        OperationStatus.success) {
      fetchData();
      Toast().show(context, message: Lang().theOperationCompletes);
    } else {
      Toast().show(context, message: teacherNotifier.operationMemo);
    }
  }

  void fetchData() {
    teacherNotifier
        .teacherList(
      page: page,
      pageSize: pageSize,
      stext: searchText,
      state: state,
    )
        .then((value) {
      setState(() {
        teacherNotifier.teacherListModel =
            TeacherModel().fromJsonList(jsonEncode(value.data));
        selected = List<bool>.generate(
            teacherNotifier.teacherListModel.length, (int index) => false);
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
    teacherNotifier.addListener(basicListener);
    fetchData();
    classesData();
  }

  @override
  void dispose() {
    teacherNotifier.dispose();
    teacherNotifier.removeListener(basicListener);
    super.dispose();
  }

  // 生成列表
  List<DataRow> generateList() {
    return List<DataRow>.generate(
      teacherNotifier.teacherListModel.length,
      (int index) => DataRow(
        cells: <DataCell>[
          DataCell(Text(teacherNotifier.teacherListModel[index].id.toString())),
          DataCell(Text(teacherNotifier.teacherListModel[index].account)),
          DataCell(
            SizedBox(
              width: 150,
              child: Text(
                teacherNotifier.teacherListModel[index].name,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
            showEditIcon: true,
            // placeholder: true, // 内容浅色显示
            onTap: () {
              nameController.clear();
              nameAlertDialog(
                context,
                id: teacherNotifier.teacherListModel[index].id,
                name: teacherNotifier.teacherListModel[index].name,
                password: '',
              );
            },
          ),
          DataCell(Text(Tools().timestampToStr(
              teacherNotifier.teacherListModel[index].createTime))),
          DataCell(Text(Tools().timestampToStr(
              teacherNotifier.teacherListModel[index].updateTime))),
          DataCell(
            Text(Lang().setUp),
            // placeholder: true, // 内容浅色显示
            onTap: () {
              classAlertDialog(
                context,
                teacherID: teacherNotifier.teacherListModel[index].id,
              );
            },
          ),
          DataCell(
            CupertinoSwitch(
              value: teacherNotifier.teacherListModel[index].state == 1
                  ? true
                  : false,
              onChanged: (bool? value) {
                setState(() {
                  teacherNotifier.teacherDisabled(
                      id: teacherNotifier.teacherListModel[index].id);
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
    required String password,
  }) {
    nameController.clear();
    passworController.clear();
    nameController.text = name;
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
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
                  controller: passworController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: Lang().password,
                    suffixIcon: IconButton(
                      iconSize: 20,
                      onPressed: () => passworController.clear(),
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
                teacherNotifier.updateTeacherInfo(
                  id: id,
                  name: nameController.text,
                  password: password,
                );
                Navigator.of(context).pop();
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
  }

  void classAlertDialog(
    BuildContext context, {
    required int teacherID,
  }) {
    teacherClassNotifier.teacherclasses(teacherID: teacherID).then((value) {
      List<ClassModel> teacherClassListData =
          ClassModel().fromJsonList(jsonEncode(value.data)); // 当前归属班级列表
      classSelected = List<bool>.generate(
          classNotifier.classListModel.length, (int index) => false);

      for (int i = 0; i < classSelected.length; i++) {
        for (int j = 0; j < teacherClassListData.length; j++) {
          if (teacherClassListData[j].id ==
              classNotifier.classListModel[i].id) {
            classSelected[i] = true;
            break;
          }
        }
      }

      setState(() {
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
                    child: ListView.separated(
                      padding: const EdgeInsets.all(0),
                      itemCount: classNotifier.classListModel.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.all(5),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 180,
                                child: Text(
                                  classNotifier.classListModel[index].className,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ),
                              const Expanded(child: SizedBox()),
                              Checkbox(
                                value: classSelected[index],
                                onChanged: (bool? value) => {
                                  state(() {
                                    int classID =
                                        classNotifier.classListModel[index].id;
                                    if (classSelected[index]) {
                                      // 删除数据
                                      teacherClassNotifier.deleteByTeacherClass(
                                        classID: classID,
                                        teacherID: teacherID,
                                      );
                                    } else {
                                      // 添加数据
                                      teacherClassNotifier.newTeacherClass(
                                        teacherID: teacherID,
                                        classID: classID,
                                      );
                                    }
                                    classSelected[index] =
                                        !classSelected[index];
                                  }),
                                },
                              ),
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) =>
                          const Divider(height: 0.5, color: Colors.black12),
                    ),
                  ),
                );
              },
            );
          },
        );
      });
    });
  }

  void addAlertDialog(BuildContext context) {
    newAccountController.clear();
    newPasswordController.clear();
    newNameController.clear();
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(Lang().title),
          content: SizedBox(
            width: 100,
            height: 150,
            child: Column(
              children: [
                SizedBox(
                  child: TextField(
                    controller: newAccountController,
                    decoration: InputDecoration(
                      hintText: Lang().account,
                      suffixIcon: IconButton(
                        iconSize: 20,
                        onPressed: () => newAccountController.clear(),
                        icon: const Icon(Icons.clear),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  child: TextField(
                    controller: newPasswordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: Lang().password,
                      suffixIcon: IconButton(
                        iconSize: 20,
                        onPressed: () => newPasswordController.clear(),
                        icon: const Icon(Icons.clear),
                      ),
                    ),
                  ),
                ),
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
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (newAccountController.text.isNotEmpty &&
                    newPasswordController.text.isNotEmpty &&
                    newNameController.text.isNotEmpty) {
                  teacherNotifier.newTeacher(
                    account: newAccountController.text,
                    password: newPasswordController.text,
                    name: newNameController.text,
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
  }

  // 数据排序
  onSortColum(int columnIndex, bool ascending) {
    if (columnIndex == 0) {
      if (ascending) {
        teacherNotifier.teacherListModel.sort((a, b) => a.id.compareTo(b.id));
      } else {
        teacherNotifier.teacherListModel.sort((a, b) => b.id.compareTo(a.id));
      }
    }
    // 重置全选
    selected = List<bool>.generate(
      teacherNotifier.teacherListModel.length,
      (int index) {
        teacherNotifier.teacherListModel[index].selected = false;
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
                              message: Lang().status,
                              child: DropdownButton<String>(
                                itemHeight: 50,
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
                                    .map<DropdownMenuItem<String>>(
                                        (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
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
                          DataColumn(
                            label: Text(
                              Lang().classes,
                              style: const TextStyle(
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              Lang().status,
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
                                        onSubmittedData <= totalPage &&
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
      appBar: AppBar(title: Text(Lang().teachers)),
      body: mainWidget(context),
    );
  }
}
