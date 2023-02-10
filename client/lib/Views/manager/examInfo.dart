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
import 'package:client/providers/examinfo_notifier.dart';

import 'package:client/models/examinfo_model.dart';

// ignore: must_be_immutable
class ExamInfo extends StatefulWidget {
  late String headline;
  ExamInfo({super.key, required this.headline});

  @override
  State<ExamInfo> createState() => ExamInfoState();
}

class ExamInfoState extends State<ExamInfo> {
  bool sortAscending = false;
  int sortColumnIndex = 0;
  int showSelected = 0;
  List<bool> selected = [];

  int page = 1;
  int pageSize = perPageDropList.first;
  String searchText = '';
  int examState = 0;
  int examType = 0;
  int pass = 0;
  int startState = 0;
  int suspendedState = 0;
  int totalPage = 0;

  String examStatusMemo = examStatusList.first;
  String examTypeMemo = examTypeList.first;

  TextEditingController jumpToController = TextEditingController();
  TextEditingController cupertinoSearchTextFieldController =
      TextEditingController();

  ExamInfoNotifier examInfoNotifier = ExamInfoNotifier();

  basicListener() async {
    if (examInfoNotifier.operationStatus.value == OperationStatus.loading) {
      Toast().show(context, message: Lang().loading);
    } else if (examInfoNotifier.operationStatus.value ==
        OperationStatus.success) {
      fetchData();
      Toast().show(context, message: Lang().theOperationCompletes);
    } else {
      Toast().show(context, message: examInfoNotifier.operationMemo);
    }
  }

  void fetchData() {
    examInfoNotifier
        .examInfoList(
      page: page,
      pageSize: pageSize,
      stext: searchText,
      examState: examState,
      examType: examType,
      pass: pass,
      startState: startState,
      suspendedState: suspendedState,
    )
        .then((value) {
      setState(() {
        examInfoNotifier.examInfoListModel =
            ExamInfoModel().fromJsonList(jsonEncode(value.data));
        selected = List<bool>.generate(
            examInfoNotifier.examInfoListModel.length, (int index) => false);
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
    examInfoNotifier.addListener(basicListener);
    fetchData();
  }

  @override
  void dispose() {
    examInfoNotifier.dispose();
    examInfoNotifier.removeListener(basicListener);
    super.dispose();
  }

  String checkPass(int pass) {
    if (pass == 1) {
      return Lang().no;
    } else if (pass == 2) {
      return Lang().yes;
    } else {
      return '';
    }
  }

  String checkExamState(int examState) {
    if (examState == 1) {
      return Lang().noAnswerCards;
    } else if (examState == 2) {
      return Lang().notExamined;
    } else if (examState == 3) {
      return Lang().examined;
    } else if (examState == 4) {
      return Lang().examVoided;
    } else {
      return '';
    }
  }

  String checkExamType(int examType) {
    if (examType == 1) {
      return Lang().officialExams;
    } else if (examType == 2) {
      return Lang().dailyPractice;
    } else {
      return '';
    }
  }

  String checkStartState(int startState) {
    if (startState == 1) {
      return Lang().notStarted;
    } else if (startState == 2) {
      return Lang().started;
    } else {
      return '';
    }
  }

  // 生成列表
  List<DataRow> generateList() {
    return List<DataRow>.generate(
      examInfoNotifier.examInfoListModel.length,
      (int index) => DataRow(
        cells: <DataCell>[
          DataCell(
            Text(
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                examInfoNotifier.examInfoListModel[index].id.toString()),
          ),
          DataCell(
            Text(
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                examInfoNotifier.examInfoListModel[index].subjectName),
          ),
          DataCell(
            Text(
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                examInfoNotifier.examInfoListModel[index].examNo),
          ),
          DataCell(
            Text(
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                examInfoNotifier.examInfoListModel[index].totalScore
                    .toString()),
          ),
          DataCell(
            Text(
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                examInfoNotifier.examInfoListModel[index].passLine.toString()),
          ),
          DataCell(
            Text(
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                examInfoNotifier.examInfoListModel[index].examDuration
                    .toString()),
          ),
          DataCell(
            Text(
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                Tools().timestampToStr(
                    examInfoNotifier.examInfoListModel[index].startTime)),
          ),
          DataCell(
            Text(
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                Tools().timestampToStr(
                    examInfoNotifier.examInfoListModel[index].endTime)),
          ),
          DataCell(
            Text(
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                examInfoNotifier.examInfoListModel[index].actualScore
                    .toString()),
          ),
          DataCell(
            Text(
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                examInfoNotifier.examInfoListModel[index].actualDuration
                    .toString()),
          ),
          DataCell(
            Text(
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              checkPass(examInfoNotifier.examInfoListModel[index].pass),
            ),
          ),
          DataCell(
            Text(
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                examInfoNotifier.examInfoListModel[index].examineeID
                    .toString()),
          ),
          DataCell(
            Text(
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                checkExamState(
                    examInfoNotifier.examInfoListModel[index].examState)),
          ),
          DataCell(
            Text(
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                checkExamType(
                    examInfoNotifier.examInfoListModel[index].examType)),
          ),
          DataCell(
            Text(
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                Tools().timestampToStr(
                    examInfoNotifier.examInfoListModel[index].createTime)),
          ),
          DataCell(
            Text(
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                Tools().timestampToStr(
                    examInfoNotifier.examInfoListModel[index].updateTime)),
          ),
          DataCell(
            Text(
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                checkStartState(
                    examInfoNotifier.examInfoListModel[index].startState)),
          ),
          // DataCell(
          //   Text(
          //       overflow: TextOverflow.ellipsis,
          //       maxLines: 1,
          //       examInfoNotifier.examInfoListModel[index].suspendedState
          //           .toString()),
          // ),
          DataCell(
            CupertinoSwitch(
              value:
                  examInfoNotifier.examInfoListModel[index].suspendedState == 1
                      ? false
                      : true,
              onChanged: (bool? value) {
                setState(() {
                  examInfoNotifier.examInfoSuspend(
                      id: examInfoNotifier.examInfoListModel[index].id);
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

  // 数据排序
  onSortColum(int columnIndex, bool ascending) {
    if (columnIndex == 0) {
      if (ascending) {
        examInfoNotifier.examInfoListModel.sort((a, b) => a.id.compareTo(b.id));
      } else {
        examInfoNotifier.examInfoListModel.sort((a, b) => b.id.compareTo(a.id));
      }
    }
    // 重置全选
    selected = List<bool>.generate(
      examInfoNotifier.examInfoListModel.length,
      (int index) {
        examInfoNotifier.examInfoListModel[index].selected = false;
        showSelected = 0;
        return false;
      },
    );
  }

  mainWidget(BuildContext context) {
    double widgetWidth = MediaQuery.of(context).size.width;
    double percentage = .15;
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
                      message: Lang().examStatus,
                      child: DropdownButton<String>(
                        itemHeight: 50,
                        value: examStatusMemo,
                        icon: const Icon(Icons.arrow_drop_down),
                        style: const TextStyle(color: Colors.black),
                        // elevation: 16,
                        underline: Container(
                          height: 0,
                          // color: Colors.deepPurpleAccent,
                        ),
                        onChanged: (String? value) {
                          setState(() {
                            if (examStatusMemo != value!) {
                              examStatusMemo = value;
                              if (value == Lang().noAnswerCards) {
                                examState = 1;
                              } else if (value == Lang().notExamined) {
                                examState = 2;
                              } else if (value == Lang().examined) {
                                examState = 3;
                              } else if (value == Lang().examVoided) {
                                examState = 4;
                              } else {
                                examState = 0;
                                examStatusMemo = Lang().notSelected;
                              }
                              page = 1;
                              fetchData();
                            }
                          });
                        },
                        items: examStatusList
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Tooltip(
                      message: Lang().examType,
                      child: DropdownButton<String>(
                        itemHeight: 50,
                        value: examTypeMemo,
                        icon: const Icon(Icons.arrow_drop_down),
                        style: const TextStyle(color: Colors.black),
                        // elevation: 16,
                        underline: Container(
                          height: 0,
                          // color: Colors.deepPurpleAccent,
                        ),
                        onChanged: (String? value) {
                          setState(() {
                            if (examTypeMemo != value!) {
                              examTypeMemo = value;
                              if (value == Lang().officialExams) {
                                examType = 1;
                              } else if (value == Lang().dailyPractice) {
                                examType = 2;
                              } else {
                                examType = 0;
                                examTypeMemo = Lang().notSelected;
                              }
                              page = 1;
                              fetchData();
                            }
                          });
                        },
                        items: examTypeList
                            .map<DropdownMenuItem<String>>((String value) {
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
                      onPressed: () => print('fuck'),
                      // onPressed: () => addAlertDialog(context),
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
                              Lang().examNumber,
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
                              Lang().startTime,
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
                              Lang().endTime,
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
                              Lang().actualScore,
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
                              Lang().actualDuration,
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
                              Lang().passedOrNot,
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
                              Lang().examinee,
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
                              Lang().examStatus,
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
                              Lang().examType,
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
                              Lang().startState,
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
                              Lang().SuspendStatus,
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
      appBar: AppBar(title: Text(Lang().examRegistrations)),
      body: mainWidget(context),
    );
  }
}
