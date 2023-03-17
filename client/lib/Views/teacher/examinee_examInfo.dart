// ignore_for_file: file_names

import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:client/public/lang.dart';
import 'package:client/public/tools.dart';
import 'package:client/public/file.dart';
import 'package:client/Views/common/basic_info.dart';
import 'package:client/Views/common/toast.dart';
import 'package:client/Views/common/menu.dart';

import 'package:client/providers/base_notifier.dart';
import 'package:client/providers/teacher_notifier.dart';
// import 'package:client/providers/subject_notifier.dart';
import 'package:client/providers/examinee_notifier.dart';

import 'package:client/models/examinfo_model.dart';
import 'package:client/models/examinee_model.dart';
// import 'package:client/models/subject_model.dart';

// import 'package:client/Views/teacher/answer_cards.dart';

// ignore: must_be_immutable
class ExamineeExamInfo extends StatefulWidget {
  late String name;
  late int type;
  late int examineeID;
  ExamineeExamInfo({super.key, required this.name, required this.type, required this.examineeID});

  @override
  State<ExamineeExamInfo> createState() => ExamineeExamInfoState();
}

class ExamineeExamInfoState extends State<ExamineeExamInfo> {
  bool sortAscending = false;
  int sortColumnIndex = 0;
  int showSelected = 0;
  List<bool> selected = [];
  int subjectID = 0;

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
  String passMemo = passList.first;
  String startStateMemo = startStateList.first;
  String suspendedStateMemo = suspendedStateList.first;

  TextEditingController jumpToController = TextEditingController();
  TextEditingController cupertinoSearchTextFieldController = TextEditingController();

  TeacherNotifier teacherNotifier = TeacherNotifier();
  ExamineeNotifier examineeNotifier = ExamineeNotifier();
  // SubjectNotifier subjectNotifier = SubjectNotifier();

  double _globlePositionX = 0;
  double _globlePositionY = 0;

  basicListener() async {
    if (teacherNotifier.operationStatus.value == OperationStatus.loading) {
      Toast().show(context, message: Lang().loading);
    } else if (teacherNotifier.operationStatus.value == OperationStatus.success) {
      fetchData();
      Toast().show(context, message: Lang().theOperationCompletes);
    } else {
      Toast().show(context, message: teacherNotifier.operationMemo);
    }
  }

  void fetchData() {
    teacherNotifier
        .teacherExamInfoList(
      type: widget.type,
      page: page,
      pageSize: pageSize,
      stext: searchText,
      examState: examState,
      examType: examType,
      pass: pass,
      startState: startState,
      suspendedState: suspendedState,
      examineeID: widget.examineeID,
    )
        .then((value) {
      setState(() {
        teacherNotifier.examInfoListModel = ExamInfoModel().fromJsonList(jsonEncode(value.data));
        selected = List<bool>.generate(teacherNotifier.examInfoListModel.length, (int index) => false);
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

  // void subjectsData() {
  //   subjectNotifier.subjects().then((value) {
  //     setState(() {
  //       subjectNotifier.subjectListModel = SubjectModel().fromJsonList(jsonEncode(value.data));
  //     });
  //   });
  // }

  @override
  void initState() {
    super.initState();
    teacherNotifier.addListener(basicListener);
    fetchData();
    // subjectsData();
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
      teacherNotifier.examInfoListModel.length,
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
          DataCell(Text(overflow: TextOverflow.ellipsis, maxLines: 1, teacherNotifier.examInfoListModel[index].id.toString())),
          DataCell(Text(overflow: TextOverflow.ellipsis, maxLines: 1, teacherNotifier.examInfoListModel[index].subjectName)),
          DataCell(Text(overflow: TextOverflow.ellipsis, maxLines: 1, teacherNotifier.examInfoListModel[index].examNo)),
          DataCell(Text(overflow: TextOverflow.ellipsis, maxLines: 1, teacherNotifier.examInfoListModel[index].totalScore.toString())),
          DataCell(Text(overflow: TextOverflow.ellipsis, maxLines: 1, teacherNotifier.examInfoListModel[index].passLine.toString())),
          DataCell(Text(overflow: TextOverflow.ellipsis, maxLines: 1, teacherNotifier.examInfoListModel[index].examDuration.toString())),
          DataCell(Text(overflow: TextOverflow.ellipsis, maxLines: 1, Tools().timestampToStr(teacherNotifier.examInfoListModel[index].startTime))),
          DataCell(Text(overflow: TextOverflow.ellipsis, maxLines: 1, Tools().timestampToStr(teacherNotifier.examInfoListModel[index].endTime))),
          DataCell(Text(overflow: TextOverflow.ellipsis, maxLines: 1, teacherNotifier.examInfoListModel[index].actualScore.toString())),
          DataCell(Text(overflow: TextOverflow.ellipsis, maxLines: 1, teacherNotifier.examInfoListModel[index].actualDuration.toString())),
          DataCell(Text(overflow: TextOverflow.ellipsis, maxLines: 1, checkPass(teacherNotifier.examInfoListModel[index].pass))),
          DataCell(IconButton(iconSize: 20, onPressed: () => examineeInfo(context, examineeID: teacherNotifier.examInfoListModel[index].examineeID), icon: const Icon(Icons.people))),
          DataCell(Text(overflow: TextOverflow.ellipsis, maxLines: 1, checkExamState(teacherNotifier.examInfoListModel[index].examState))),
          DataCell(Text(overflow: TextOverflow.ellipsis, maxLines: 1, checkExamType(teacherNotifier.examInfoListModel[index].examType))),
          DataCell(Text(overflow: TextOverflow.ellipsis, maxLines: 1, Tools().timestampToStr(teacherNotifier.examInfoListModel[index].createTime))),
          DataCell(Text(overflow: TextOverflow.ellipsis, maxLines: 1, Tools().timestampToStr(teacherNotifier.examInfoListModel[index].updateTime))),
          DataCell(Text(overflow: TextOverflow.ellipsis, maxLines: 1, checkStartState(teacherNotifier.examInfoListModel[index].startState))),
          DataCell(
            CupertinoSwitch(
              value: teacherNotifier.examInfoListModel[index].suspendedState == 1 ? false : true,
              onChanged: (bool? value) {
                setState(() {
                  /*
                  teacherNotifier.examInfoSuspend(id: teacherNotifier.examInfoListModel[index].id);
                  */
                });
              },
            ),
          ),
          DataCell(
            Row(
              children: [
                const SizedBox(width: 25),
                IconButton(
                  icon: const Icon(Icons.list),
                  onPressed: () {
                    setState(() {
                      /*
                      Navigator.of(context)
                          .push(
                        MaterialPageRoute(
                          builder: (context) => AnswerCards(
                            examNo: teacherNotifier.examInfoListModel[index].examNo,
                            examID: teacherNotifier.examInfoListModel[index].id,
                          ),
                        ),
                      )
                          .then(
                        (value) {
                          fetchData();
                        },
                      );
                      */
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

  // 考生详情
  void examineeInfo(
    BuildContext context, {
    required int examineeID,
  }) {
    if (examineeID == 0) {
      Toast().show(context, message: Lang().noData);
    } else {
      examineeNotifier.examineeInfo(id: examineeID).then((value) {
        ExamineeModel examineeData = ExamineeModel.fromJson(value.data); // 当前归属班级列表
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
                      width: 280,
                      height: 130,
                      child: Container(
                        padding: const EdgeInsets.all(0),
                        margin: const EdgeInsets.all(0),
                        child: SelectableText.rich(
                          TextSpan(
                            children: [
                              TextSpan(text: 'ID: ${examineeData.id}\n'),
                              TextSpan(text: '${Lang().name}: ${examineeData.name}\n'),
                              TextSpan(text: '${Lang().examineeNo}: ${examineeData.examineeNo}\n'),
                              TextSpan(text: '${Lang().createtime}: ${Tools().timestampToStr(examineeData.createTime)}\n'),
                              TextSpan(text: '${Lang().contact}: ${examineeData.contact}\n'),
                            ],
                          ),
                        ),
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
  }

  // 数据排序
  onSortColum(int columnIndex, bool ascending) {
    if (columnIndex == 0) {
      if (ascending) {
        teacherNotifier.examInfoListModel.sort((a, b) => a.id.compareTo(b.id));
      } else {
        teacherNotifier.examInfoListModel.sort((a, b) => b.id.compareTo(a.id));
      }
    }
    // 重置全选
    selected = List<bool>.generate(
      teacherNotifier.examInfoListModel.length,
      (int index) {
        teacherNotifier.examInfoListModel[index].selected = false;
        showSelected = 0;
        return false;
      },
    );
  }

  Widget mainWidget(BuildContext context) {
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
                    Tooltip(
                      message: Lang().examStatus,
                      child: DropdownButton<String>(
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
                            if (value != null && examStatusMemo != value) {
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
                        items: examStatusList.map<DropdownMenuItem<String>>((String value) {
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
                            if (value != null && examTypeMemo != value) {
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
                        items: examTypeList.map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Tooltip(
                      message: Lang().passedOrNot,
                      child: DropdownButton<String>(
                        value: passMemo,
                        icon: const Icon(Icons.arrow_drop_down),
                        style: const TextStyle(color: Colors.black),
                        // elevation: 16,
                        underline: Container(
                          height: 0,
                          // color: Colors.deepPurpleAccent,
                        ),
                        onChanged: (String? value) {
                          setState(() {
                            if (value != null && passMemo != value) {
                              passMemo = value;
                              if (value == Lang().yes) {
                                pass = 2;
                              } else if (value == Lang().no) {
                                pass = 1;
                              } else {
                                pass = 0;
                                passMemo = Lang().notSelected;
                              }
                              page = 1;
                              fetchData();
                            }
                          });
                        },
                        items: passList.map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Tooltip(
                      message: Lang().startState,
                      child: DropdownButton<String>(
                        value: startStateMemo,
                        icon: const Icon(Icons.arrow_drop_down),
                        style: const TextStyle(color: Colors.black),
                        // elevation: 16,
                        underline: Container(
                          height: 0,
                          // color: Colors.deepPurpleAccent,
                        ),
                        onChanged: (String? value) {
                          setState(() {
                            if (value != null && startStateMemo != value) {
                              startStateMemo = value;
                              if (value == Lang().notStarted) {
                                startState = 1;
                              } else if (value == Lang().started) {
                                startState = 2;
                              } else {
                                startState = 0;
                                startStateMemo = Lang().notSelected;
                              }
                              page = 1;
                              fetchData();
                            }
                          });
                        },
                        items: startStateList.map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Tooltip(
                      message: Lang().suspendStatus,
                      child: DropdownButton<String>(
                        value: suspendedStateMemo,
                        icon: const Icon(Icons.arrow_drop_down),
                        style: const TextStyle(color: Colors.black),
                        // elevation: 16,
                        underline: Container(
                          height: 0,
                          // color: Colors.deepPurpleAccent,
                        ),
                        onChanged: (String? value) {
                          setState(() {
                            if (value != null && suspendedStateMemo != value) {
                              suspendedStateMemo = value;
                              if (value == Lang().no) {
                                startState = 1;
                              } else if (value == Lang().yes) {
                                startState = 2;
                              } else {
                                suspendedState = 0;
                                suspendedStateMemo = Lang().notSelected;
                              }
                              page = 1;
                              fetchData();
                            }
                          });
                        },
                        items: suspendedStateList.map<DropdownMenuItem<String>>((String value) {
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
                          examState = 0;
                          examType = 0;
                          pass = 0;
                          startState = 0;
                          suspendedState = 0;

                          examStatusMemo = examStatusList.first;
                          examTypeMemo = examTypeList.first;
                          passMemo = passList.first;
                          startStateMemo = startStateList.first;
                          suspendedStateMemo = suspendedStateList.first;

                          cupertinoSearchTextFieldController.clear();
                          page = 1;
                          fetchData();
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
                              Lang().suspendStatus,
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
                              Lang().answerCards,
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
                    const SizedBox(width: 20),
                    SizedBox(
                      child: TextButton(
                          child: Text(
                            Lang().generateQuizPaperData,
                            style: const TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                            ),
                          ),
                          onPressed: () {
                            /*
                            for (int i = 0; i < selected.length; i++) {
                              if (selected[i]) {
                                teacherNotifier.generateTestPaper(id: teacherNotifier.examInfoListModel[i].id);
                              }
                            }
                            */
                          }),
                    ),
                    const SizedBox(width: 20),
                    SizedBox(
                      child: TextButton(
                          child: Text(
                            Lang().clearData,
                            style: const TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                            ),
                          ),
                          onPressed: () {
                            /*
                            for (int i = 0; i < selected.length; i++) {
                              if (selected[i]) {
                                teacherNotifier.resetExamQuestionData(id: teacherNotifier.examInfoListModel[i].id);
                              }
                            }
                            */
                          }),
                    ),
                    const SizedBox(width: 20),
                    SizedBox(
                      child: TextButton(
                          child: Text(
                            Lang().voidTheData,
                            style: const TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                            ),
                          ),
                          onPressed: () {
                            /*
                            for (int i = 0; i < selected.length; i++) {
                              if (selected[i]) {
                                teacherNotifier.examInfoDisabled(id: teacherNotifier.examInfoListModel[i].id);
                              }
                            }
                            */
                          }),
                    ),
                    const SizedBox(width: 20),
                    SizedBox(
                      child: TextButton(
                          child: Text(
                            Lang().grade,
                            style: const TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                            ),
                          ),
                          onPressed: () {
                            /*
                            for (int i = 0; i < selected.length; i++) {
                              if (selected[i]) {
                                teacherNotifier.gradeTheExam(id: teacherNotifier.examInfoListModel[i].id);
                              }
                            }
                            */
                          }),
                    ),
                    const SizedBox(width: 20),
                    SizedBox(
                      child: TextButton(
                          child: Text(
                            Lang().sendToOldData,
                            style: const TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                            ),
                          ),
                          onPressed: () {
                            /*
                            for (int i = 0; i < selected.length; i++) {
                              if (selected[i]) {
                                teacherNotifier.examIntoHistory(id: teacherNotifier.examInfoListModel[i].id);
                              }
                            }
                            */
                          }),
                    ),
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

  void showPopupMenu(BuildContext context, double x, double y) {
    RenderBox overlay = Overlay.of(context)?.context.findRenderObject() as RenderBox;
    RelativeRect position = RelativeRect.fromRect(Rect.fromLTRB(x, y - 100, x, y), Offset.zero & overlay.size);

    PopupMenuItem bulkImportItem = PopupMenuItem(
      value: 1,
      child: Tooltip(
        message: 'xls / xlsx',
        child: Text(Lang().bulkImport),
      ),
    );
    PopupMenuItem demoItem = const PopupMenuItem(
      value: 2,
      child: Text('Demo'),
    );
    List<PopupMenuEntry<dynamic>> itemList = [bulkImportItem, demoItem];
    /*
    showMenu(context: context, position: position, items: itemList).then((value) {
      if (value == 1) {
        Future<String?> filePath = FileHelper().checkFile(dirPath: FileHelper().appRoot().path, type: ['xls', 'xlsx']);
        filePath.then((value) {
          if (value != null) {
            teacherNotifier.importExamInfo(filePath: value);
          }
        });
      }
      if (value == 2) {
        teacherNotifier.downloadExamInfoDemo().then((value) {
          List<dynamic> data = value.data;
          List<int> dataBit = [];
          for (dynamic element in data) {
            dataBit.add(element as int);
          }
          bool result = FileHelper().writeFileB('${FileHelper().appRoot().path}/demo.${value.memo}', dataBit);
          if (result) {
            FileHelper().openDir(dirPath: FileHelper().appRoot().path, type: ['xls', 'xlsx', 'zip']);
          } else {
            Toast().show(context, message: Lang().theRequestFailed);
          }
        });
      }
    });
    */
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.name)),
      body: mainWidget(context),
      floatingActionButton: Container(
        // padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.fromLTRB(0, 0, 15, 75),
        child: GestureDetector(
          onPanDown: (DragDownDetails details) {
            _globlePositionX = details.globalPosition.dx;
            _globlePositionY = details.globalPosition.dy;
          },
          // onLongPress: () {
          //   _showPromptBox();
          // },
          child: FloatingActionButton(
            backgroundColor: Colors.green,
            child: const Icon(Icons.add_box),
            onPressed: () => showPopupMenu(context, _globlePositionX, _globlePositionY),
          ),
        ),
      ),
    );
  }
}
