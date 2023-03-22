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
import 'package:client/providers/paper_notifier.dart';
import 'package:client/providers/subject_notifier.dart';

import 'package:client/models/paper_model.dart';
import 'package:client/models/subject_model.dart';

import 'package:client/Views/manager/paper_rule.dart';

// ignore: must_be_immutable
class Paper extends StatefulWidget {
  late String headline;
  Paper({super.key, required this.headline});

  @override
  State<Paper> createState() => PaperState();
}

class PaperState extends State<Paper> {
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
  int subjectID = 0;

  TextEditingController jumpToController = TextEditingController();
  TextEditingController cupertinoSearchTextFieldController = TextEditingController();

  PaperNotifier paperNotifier = PaperNotifier();
  SubjectNotifier subjectNotifier = SubjectNotifier();

  basicListener() async {
    if (paperNotifier.operationStatus.value == OperationStatus.loading) {
      Toast().show(context, message: Lang().loading);
    } else if (paperNotifier.operationStatus.value == OperationStatus.success) {
      fetchData();
      Toast().show(context, message: Lang().theOperationCompletes);
    } else {
      Toast().show(context, message: paperNotifier.operationMemo);
    }
  }

  void fetchData() {
    paperNotifier
        .paperList(
      page: page,
      pageSize: pageSize,
      stext: searchText,
      subjectID: subjectID,
      paperState: state,
    )
        .then((value) {
      setState(() {
        paperNotifier.paperListModel = PaperModel().fromJsonList(jsonEncode(value.data));
        selected = List<bool>.generate(paperNotifier.paperListModel.length, (int index) => false);
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

  void subjectsData() {
    subjectNotifier.subjects().then((value) {
      setState(() {
        subjectNotifier.subjectListModel = SubjectModel().fromJsonList(jsonEncode(value.data));
      });
    });
  }

  @override
  void initState() {
    super.initState();
    paperNotifier.addListener(basicListener);
    fetchData();
    subjectsData();
  }

  @override
  void dispose() {
    paperNotifier.dispose();
    paperNotifier.removeListener(basicListener);
    super.dispose();
  }

  // 生成列表
  List<DataRow> generateList() {
    return List<DataRow>.generate(
      paperNotifier.paperListModel.length,
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
          DataCell(Text(overflow: TextOverflow.ellipsis, maxLines: 1, paperNotifier.paperListModel[index].id.toString())),
          DataCell(
            SizedBox(width: 150, child: Text(overflow: TextOverflow.ellipsis, maxLines: 1, paperNotifier.paperListModel[index].paperName)),
            showEditIcon: true,
            // placeholder: true, // 内容浅色显示
            onTap: () {
              updateAlertDialog(
                context,
                id: paperNotifier.paperListModel[index].id,
                paperName: paperNotifier.paperListModel[index].paperName,
                totalScore: paperNotifier.paperListModel[index].totalScore,
                passLine: paperNotifier.paperListModel[index].passLine,
                examDuration: paperNotifier.paperListModel[index].examDuration,
                type: 1,
              );
            },
          ),
          DataCell(Text(overflow: TextOverflow.ellipsis, maxLines: 1, paperNotifier.paperListModel[index].paperCode)),
          DataCell(Text(overflow: TextOverflow.ellipsis, maxLines: 1, paperNotifier.paperListModel[index].subjectName)),
          DataCell(
            CupertinoSwitch(
              value: paperNotifier.paperListModel[index].paperState == 1 ? true : false,
              onChanged: (bool? value) {
                setState(() {
                  paperNotifier.paperDisabled(id: paperNotifier.paperListModel[index].id);
                });
              },
            ),
          ),
          DataCell(
            Text(overflow: TextOverflow.ellipsis, maxLines: 1, paperNotifier.paperListModel[index].totalScore.toString()),
            showEditIcon: true,
            onTap: () {
              updateAlertDialog(
                context,
                id: paperNotifier.paperListModel[index].id,
                paperName: paperNotifier.paperListModel[index].paperName,
                totalScore: paperNotifier.paperListModel[index].totalScore,
                passLine: paperNotifier.paperListModel[index].passLine,
                examDuration: paperNotifier.paperListModel[index].examDuration,
                type: 2,
              );
            },
          ),
          DataCell(
            Text(overflow: TextOverflow.ellipsis, maxLines: 1, paperNotifier.paperListModel[index].passLine.toString()),
            showEditIcon: true,
            onTap: () {
              updateAlertDialog(
                context,
                id: paperNotifier.paperListModel[index].id,
                paperName: paperNotifier.paperListModel[index].paperName,
                totalScore: paperNotifier.paperListModel[index].totalScore,
                passLine: paperNotifier.paperListModel[index].passLine,
                examDuration: paperNotifier.paperListModel[index].examDuration,
                type: 3,
              );
            },
          ),
          DataCell(
            Text(overflow: TextOverflow.ellipsis, maxLines: 1, paperNotifier.paperListModel[index].examDuration.toString()),
            showEditIcon: true,
            onTap: () {
              updateAlertDialog(
                context,
                id: paperNotifier.paperListModel[index].id,
                paperName: paperNotifier.paperListModel[index].paperName,
                totalScore: paperNotifier.paperListModel[index].totalScore,
                passLine: paperNotifier.paperListModel[index].passLine,
                examDuration: paperNotifier.paperListModel[index].examDuration,
                type: 4,
              );
            },
          ),
          DataCell(Text(overflow: TextOverflow.ellipsis, maxLines: 1, Tools().timestampToStr(paperNotifier.paperListModel[index].createTime))),
          DataCell(Text(overflow: TextOverflow.ellipsis, maxLines: 1, Tools().timestampToStr(paperNotifier.paperListModel[index].updateTime))),
          DataCell(
            Row(
              children: [
                const SizedBox(width: 40),
                IconButton(
                  icon: const Icon(Icons.list),
                  onPressed: () {
                    setState(() {
                      Navigator.of(context)
                          .push(
                        MaterialPageRoute(
                          builder: (context) => PaperRules(
                            id: paperNotifier.paperListModel[index].id,
                            paperName: paperNotifier.paperListModel[index].paperName,
                            subjectID: paperNotifier.paperListModel[index].subjectID,
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

  List<DropdownMenuItem<SubjectModel>> subjectDropdownMenuItemList() {
    List<DropdownMenuItem<SubjectModel>> subjectDataDropdownMenuItemList = [];
    for (SubjectModel element in subjectNotifier.subjectListModel) {
      DropdownMenuItem<SubjectModel> data = DropdownMenuItem(
        value: element,
        child: SizedBox(
          width: 100,
          child: Text(
            element.subjectName,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ),
      );
      subjectDataDropdownMenuItemList.add(data);
    }
    return subjectDataDropdownMenuItemList;
  }

  // 新建
  void addAlertDialog(BuildContext context) {
    TextEditingController newPaperNameController = TextEditingController();
    int newSubjectID = 0;
    TextEditingController newTotalScoreController = TextEditingController();
    TextEditingController newPassLineController = TextEditingController();
    TextEditingController newExamDurationController = TextEditingController();
    String newSubjectSelectedName = Lang().notSelected;
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
                height: 250,
                child: Column(
                  children: [
                    SizedBox(
                      child: TextField(
                        maxLines: 1,
                        controller: newPaperNameController,
                        decoration: InputDecoration(
                          hintText: Lang().paperName,
                          suffixIcon: IconButton(
                            iconSize: 20,
                            onPressed: () => newPaperNameController.clear(),
                            icon: const Icon(Icons.clear),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      child: TextField(
                        maxLines: 1,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(5),
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                        ],
                        controller: newTotalScoreController,
                        decoration: InputDecoration(
                          hintText: Lang().totalScore,
                          suffixIcon: IconButton(
                            iconSize: 20,
                            onPressed: () => newTotalScoreController.clear(),
                            icon: const Icon(Icons.clear),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      child: TextField(
                        maxLines: 1,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(5),
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                        ],
                        controller: newExamDurationController,
                        decoration: InputDecoration(
                          hintText: Lang().examDuration,
                          suffixIcon: IconButton(
                            iconSize: 20,
                            onPressed: () => newExamDurationController.clear(),
                            icon: const Icon(Icons.clear),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      child: TextField(
                        maxLines: 1,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(5),
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                        ],
                        controller: newPassLineController,
                        decoration: InputDecoration(
                          hintText: Lang().passingLine,
                          suffixIcon: IconButton(
                            iconSize: 20,
                            onPressed: () => newPassLineController.clear(),
                            icon: const Icon(Icons.clear),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Tooltip(
                      message: Lang().examSubjects,
                      child: Row(
                        children: [
                          SizedBox(
                            child: DropdownButton<SubjectModel>(
                              hint: SizedBox(
                                width: 100,
                                child: Text(
                                  newSubjectSelectedName,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: const TextStyle(color: Colors.black),
                                ),
                              ),
                              icon: const Icon(Icons.arrow_drop_down),
                              style: const TextStyle(color: Colors.black),
                              // elevation: 16,
                              underline: Container(
                                height: 0,
                                // color: Colors.deepPurpleAccent,
                              ),
                              onChanged: (SubjectModel? value) {
                                state(() {
                                  if (value!.id > 0) {
                                    newSubjectSelectedName = value.subjectName;
                                    newSubjectID = value.id;
                                  }
                                });
                              },
                              items: subjectDropdownMenuItemList(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    if (newPaperNameController.text.isNotEmpty && newTotalScoreController.text.isNotEmpty && newPassLineController.text.isNotEmpty && newExamDurationController.text.isNotEmpty && newSubjectID > 0) {
                      paperNotifier.newPaper(
                        paperName: newPaperNameController.text,
                        totalScore: int.parse(newTotalScoreController.text),
                        passLine: int.parse(newPassLineController.text),
                        examDuration: int.parse(newExamDurationController.text),
                        subjectID: newSubjectID,
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

  // 修改
  void updateAlertDialog(
    BuildContext context, {
    required int id,
    required String paperName,
    required double totalScore,
    required double passLine,
    required int examDuration,
    required int type,
  }) {
    bool showPaperName = false;
    bool showTotalScore = false;
    bool showPassLine = false;
    bool showExamDuration = false;

    TextEditingController updatePaperNameController = TextEditingController();
    TextEditingController updateTotalScoreController = TextEditingController();
    TextEditingController updatePassLineController = TextEditingController();
    TextEditingController updateExamDurationController = TextEditingController();

    updatePaperNameController.text = paperName;
    updateTotalScoreController.text = totalScore.toString();
    updatePassLineController.text = passLine.toString();
    updateExamDurationController.text = examDuration.toString();

    if (type == 1) {
      showPaperName = true;
    } else if (type == 2) {
      showTotalScore = true;
    } else if (type == 3) {
      showPassLine = true;
    } else if (type == 4) {
      showExamDuration = true;
    } else {
      showPaperName = false;
      showTotalScore = false;
      showPassLine = false;
      showExamDuration = false;
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
                height: 50,
                child: Column(
                  children: [
                    Visibility(
                      visible: showPaperName,
                      child: TextField(
                        maxLines: 1,
                        controller: updatePaperNameController,
                        decoration: InputDecoration(
                          hintText: Lang().paperName,
                          suffixIcon: IconButton(
                            iconSize: 20,
                            onPressed: () => updatePaperNameController.clear(),
                            icon: const Icon(Icons.clear),
                          ),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: showTotalScore,
                      child: TextField(
                        maxLines: 1,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(6),
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
                        ],
                        controller: updateTotalScoreController,
                        decoration: InputDecoration(
                          hintText: Lang().totalScore,
                          suffixIcon: IconButton(
                            iconSize: 20,
                            onPressed: () => updateTotalScoreController.clear(),
                            icon: const Icon(Icons.clear),
                          ),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: showPassLine,
                      child: TextField(
                        maxLines: 1,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(6),
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
                        ],
                        controller: updatePassLineController,
                        decoration: InputDecoration(
                          hintText: Lang().passingLine,
                          suffixIcon: IconButton(
                            iconSize: 20,
                            onPressed: () => updatePassLineController.clear(),
                            icon: const Icon(Icons.clear),
                          ),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: showExamDuration,
                      child: TextField(
                        maxLines: 1,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(5),
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                        ],
                        controller: updateExamDurationController,
                        decoration: InputDecoration(
                          hintText: Lang().examDuration,
                          suffixIcon: IconButton(
                            iconSize: 20,
                            onPressed: () => updateExamDurationController.clear(),
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
                    if (updatePaperNameController.text.isNotEmpty && updateTotalScoreController.text.isNotEmpty && updatePassLineController.text.isNotEmpty && updateExamDurationController.text.isNotEmpty) {
                      paperNotifier.updatePaperInfo(
                        id: id,
                        paperName: updatePaperNameController.text,
                        totalScore: double.parse(updateTotalScoreController.text),
                        passLine: double.parse(updatePassLineController.text),
                        examDuration: int.parse(updateExamDurationController.text),
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

  // 数据排序
  onSortColum(int columnIndex, bool ascending) {
    if (columnIndex == 0) {
      if (ascending) {
        paperNotifier.paperListModel.sort((a, b) => a.id.compareTo(b.id));
      } else {
        paperNotifier.paperListModel.sort((a, b) => b.id.compareTo(a.id));
      }
    }
    // 重置全选
    selected = List<bool>.generate(
      paperNotifier.paperListModel.length,
      (int index) {
        paperNotifier.paperListModel[index].selected = false;
        showSelected = 0;
        return false;
      },
    );
  }

  Widget mainWidget(BuildContext context) {
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
                            if (value != null && stateMemo != value) {
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
                        items: stateDropList.map<DropdownMenuItem<String>>((String value) {
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
                          stateMemo = stateDropList.first;
                          state = 0;
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
                              Lang().paperName,
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
                              Lang().paperCode,
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
                              Lang().paperStatus,
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
                              Lang().totalScore,
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
                              Lang().passingLine,
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
                              Lang().examDuration,
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
                              Lang().quizPaperRules,
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
                        maxLines: 1,
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
      drawer: ManagerMenu().drawer(context, headline: widget.headline),
      appBar: AppBar(title: Text(Lang().paper)),
      body: mainWidget(context),
    );
  }
}
