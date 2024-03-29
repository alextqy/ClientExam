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

import 'package:client/Views/manager/class_examinee.dart';

// ignore: must_be_immutable
class Class extends StatefulWidget {
  late String headline;
  Class({super.key, required this.headline});

  @override
  State<Class> createState() => ClassState();
}

class ClassState extends State<Class> {
  bool sortAscending = false;
  int sortColumnIndex = 0;
  int showSelected = 0;
  List<bool> selected = [];
  List<bool> teacherSelected = [];

  int page = 1;
  int pageSize = perPageDropList.first;
  String searchText = '';
  String stateMemo = stateDropList.first;
  int totalPage = 0;

  TextEditingController jumpToController = TextEditingController();
  TextEditingController cupertinoSearchTextFieldController = TextEditingController();

  ClassNotifier classNotifier = ClassNotifier();
  TeacherNotifier teacherNotifier = TeacherNotifier();
  TeacherClassNotifier teacherClassNotifier = TeacherClassNotifier();

  basicListener() async {
    if (classNotifier.operationStatus.value == OperationStatus.loading) {
      Toast().show(context, message: Lang().loading);
    } else if (classNotifier.operationStatus.value == OperationStatus.success) {
      fetchData();
      Toast().show(context, message: Lang().theOperationCompletes);
    } else {
      Toast().show(context, message: classNotifier.operationMemo);
    }
  }

  void fetchData() {
    classNotifier
        .classList(
      page: page,
      pageSize: pageSize,
      stext: searchText,
    )
        .then((value) {
      setState(() {
        classNotifier.classListModel = ClassModel().fromJsonList(jsonEncode(value.data));
        selected = List<bool>.generate(classNotifier.classListModel.length, (int index) => false);
        totalPage = value.totalPage;
        showSelected = 0;
        searchText = '';
        sortAscending = false;
        if (totalPage == 0) {
          page = 0;
        }
      });
    });
  }

  void teacherData() {
    teacherNotifier.teachers().then((value) {
      setState(() {
        teacherNotifier.teacherListModel = TeacherModel().fromJsonList(jsonEncode(value.data));
      });
    });
  }

  @override
  void initState() {
    super.initState();
    classNotifier.addListener(basicListener);
    fetchData();
    teacherData();
  }

  @override
  void dispose() {
    classNotifier.dispose();
    classNotifier.removeListener(basicListener);
    super.dispose();
  }

  // 生成列表
  List<DataRow> generateList() {
    return List<DataRow>.generate(
      classNotifier.classListModel.length,
      (int index) => DataRow(
        color: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
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
          DataCell(Text(overflow: TextOverflow.ellipsis, maxLines: 1, classNotifier.classListModel[index].id.toString())),
          DataCell(
            Tooltip(
              message: classNotifier.classListModel[index].description,
              child: SizedBox(width: 150, child: Text(overflow: TextOverflow.ellipsis, maxLines: 1, classNotifier.classListModel[index].className)),
            ),
            showEditIcon: true,
            // placeholder: true, // 内容浅色显示
            onTap: () {
              nameAlertDialog(
                context,
                id: classNotifier.classListModel[index].id,
                className: classNotifier.classListModel[index].className,
                description: classNotifier.classListModel[index].description,
              );
            },
          ),
          DataCell(Text(overflow: TextOverflow.ellipsis, maxLines: 1, classNotifier.classListModel[index].classCode)),
          DataCell(Text(overflow: TextOverflow.ellipsis, maxLines: 1, Tools().timestampToStr(classNotifier.classListModel[index].createTime))),
          DataCell(
            Text(overflow: TextOverflow.ellipsis, maxLines: 1, Lang().setUp),
            // placeholder: true, // 内容浅色显示
            onTap: () {
              teacherAlertDialog(
                context,
                classID: classNotifier.classListModel[index].id,
              );
            },
          ),
          DataCell(
            Row(
              children: [
                const SizedBox(width: 10),
                IconButton(
                  icon: const Icon(Icons.list),
                  onPressed: () {
                    setState(() {
                      Navigator.of(context)
                          .push(
                        MaterialPageRoute(
                          builder: (context) => ClassExaminee(
                            className: classNotifier.classListModel[index].className,
                            classID: classNotifier.classListModel[index].id,
                          ),
                        ),
                      )
                          .then(
                        (value) {
                          fetchData();
                        },
                      );
                    });
                  },
                ),
              ],
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
    required String className,
    required String description,
  }) {
    TextEditingController updateClassNameController = TextEditingController();
    TextEditingController updateDescriptionController = TextEditingController();
    updateClassNameController.text = className;
    updateDescriptionController.text = description;
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
                      maxLines: 1,
                      controller: updateClassNameController,
                      decoration: InputDecoration(
                        hintText: Lang().className,
                        hintStyle: const TextStyle(fontWeight: FontWeight.bold),
                        suffixIcon: IconButton(
                          iconSize: 20,
                          onPressed: () => updateClassNameController.clear(),
                          icon: const Icon(Icons.clear),
                        ),
                      ),
                    ),
                    TextField(
                      maxLines: 1,
                      controller: updateDescriptionController,
                      decoration: InputDecoration(
                        hintText: Lang().description,
                        hintStyle: const TextStyle(fontWeight: FontWeight.bold),
                        suffixIcon: IconButton(
                          iconSize: 20,
                          onPressed: () => updateDescriptionController.clear(),
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
                    if (updateClassNameController.text.isNotEmpty) {
                      Toast().show(context, message: Lang().loading);
                      classNotifier.updateClassInfo(
                        id: id,
                        className: updateClassNameController.text,
                        description: updateDescriptionController.text,
                      );
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

  void teacherAlertDialog(
    BuildContext context, {
    required int classID,
  }) {
    teacherClassNotifier.classTeachers(classID: classID).then((value) {
      List<TeacherModel> classTeacherListData = TeacherModel().fromJsonList(jsonEncode(value.data)); // 当前归属教师列表
      teacherSelected = List<bool>.generate(teacherNotifier.teacherListModel.length, (int index) => false);

      for (int i = 0; i < teacherSelected.length; i++) {
        for (int j = 0; j < classTeacherListData.length; j++) {
          if (classTeacherListData[j].id == teacherNotifier.teacherListModel[i].id) {
            teacherSelected[i] = true;
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
                      itemCount: teacherNotifier.teacherListModel.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.all(5),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 180,
                                child: Text(
                                  teacherNotifier.teacherListModel[index].name,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ),
                              const Expanded(child: SizedBox()),
                              Checkbox(
                                value: teacherSelected[index],
                                onChanged: (bool? value) => {
                                  state(() {
                                    int teacherID = teacherNotifier.teacherListModel[index].id;
                                    if (teacherSelected[index]) {
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
                                    teacherSelected[index] = !teacherSelected[index];
                                  }),
                                },
                              ),
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) => const Divider(height: 0.5, color: Colors.black12),
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

  // 新建
  void addAlertDialog(BuildContext context) {
    TextEditingController newClassNameController = TextEditingController();
    TextEditingController newDescriptionController = TextEditingController();
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
                    SizedBox(
                      child: TextField(
                        maxLines: 1,
                        controller: newClassNameController,
                        decoration: InputDecoration(
                          hintText: Lang().className,
                          hintStyle: const TextStyle(fontWeight: FontWeight.bold),
                          suffixIcon: IconButton(
                            iconSize: 20,
                            onPressed: () => newClassNameController.clear(),
                            icon: const Icon(Icons.clear),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      child: TextField(
                        maxLines: 1,
                        controller: newDescriptionController,
                        decoration: InputDecoration(
                          hintText: Lang().description,
                          hintStyle: const TextStyle(fontWeight: FontWeight.bold),
                          suffixIcon: IconButton(
                            iconSize: 20,
                            onPressed: () => newDescriptionController.clear(),
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
                    if (newClassNameController.text.isNotEmpty) {
                      Toast().show(context, message: Lang().loading);
                      classNotifier.newClass(
                        className: newClassNameController.text,
                        description: newDescriptionController.text,
                      );
                      page = 1;
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
        classNotifier.classListModel.sort((a, b) => a.id.compareTo(b.id));
      } else {
        classNotifier.classListModel.sort((a, b) => b.id.compareTo(a.id));
      }
    }
    // 重置全选
    selected = List<bool>.generate(
      classNotifier.classListModel.length,
      (int index) {
        classNotifier.classListModel[index].selected = false;
        showSelected = 0;
        return false;
      },
    );
  }

  Widget mainWidget(BuildContext context) {
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
                        fontWeight: FontWeight.bold,
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
                    const SizedBox(width: 10),
                    Tooltip(
                      message: Lang().rowsPerPage,
                      child: DropdownButton<int>(
                        value: pageSize > 0 ? pageSize : 10,
                        icon: const Icon(Icons.arrow_drop_down),
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
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
                        items: perPageDropList.map<DropdownMenuItem<int>>((int value) {
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
                thumbVisibility: true,
                radius: const Radius.circular(0),
                thickness: 10,
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
                          label: const Row(
                            children: [
                              Text(
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                'ID',
                                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
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
                              Lang().className,
                              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                            ),
                          ),
                        ),
                        DataColumn(
                          label: SizedBox(
                            width: widgetWidth * percentage,
                            child: Text(
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              Lang().classCode,
                              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
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
                              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                            ),
                          ),
                        ),
                        DataColumn(
                          label: SizedBox(
                            width: widgetWidth * percentage,
                            child: Text(
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              Lang().teachers,
                              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                            ),
                          ),
                        ),
                        DataColumn(
                          label: SizedBox(
                            width: widgetWidth * percentage,
                            child: Text(
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              Lang().examinee,
                              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
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
                        maxLines: 1,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(7),
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                        ],
                        decoration: InputDecoration(
                          hintText: Lang().jumpTo,
                          hintStyle: const TextStyle(fontWeight: FontWeight.bold),
                          border: InputBorder.none,
                        ),
                        controller: jumpToController,
                        onSubmitted: (value) {
                          setState(() {
                            int onSubmittedData = int.parse(jumpToController.text);
                            if (onSubmittedData >= 1 && onSubmittedData <= totalPage && onSubmittedData != page) {
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
                            style: const TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.w900),
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
                            style: const TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.w900),
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
      drawer: ManagerMenu().drawer(context, headline: widget.headline),
      appBar: AppBar(
          title: Text(
        Lang().classes,
        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
      )),
      body: mainWidget(context),
    );
  }
}
