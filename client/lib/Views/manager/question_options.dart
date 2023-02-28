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
import 'package:client/providers/question_solution_notifier.dart';

import 'package:client/models/question_solution_model.dart';

// ignore: must_be_immutable
class QuestionOptions extends StatefulWidget {
  late int questionType;
  late int questionID;
  QuestionOptions(
      {super.key, required this.questionType, required this.questionID});

  @override
  State<QuestionOptions> createState() => QuestionOptionsState();
}

class QuestionOptionsState extends State<QuestionOptions> {
  bool sortAscending = false;
  int sortColumnIndex = 0;
  int showSelected = 0;
  List<bool> selected = [];
  int position = 0;

  QuestionSolutionNotifier questionSolutionNotifier =
      QuestionSolutionNotifier();

  basicListener() async {
    if (questionSolutionNotifier.operationStatus.value ==
        OperationStatus.loading) {
      Toast().show(context, message: Lang().loading);
    } else if (questionSolutionNotifier.operationStatus.value ==
        OperationStatus.success) {
      fetchData();
      Toast().show(context, message: Lang().theOperationCompletes);
    } else {
      Toast().show(context, message: questionSolutionNotifier.operationMemo);
    }
  }

  void fetchData() {
    questionSolutionNotifier
        .questionSolutions(
      questionID: widget.questionID,
      position: position,
    )
        .then((value) {
      setState(() {
        questionSolutionNotifier.questionSolutionListModel =
            QuestionSolutionModel().fromJsonList(jsonEncode(value.data));
        selected = List<bool>.generate(
            questionSolutionNotifier.questionSolutionListModel.length,
            (int index) => false);
        showSelected = 0;
        sortAscending = false;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    questionSolutionNotifier.addListener(basicListener);
    fetchData();
  }

  @override
  void dispose() {
    questionSolutionNotifier.dispose();
    questionSolutionNotifier.removeListener(basicListener);
    super.dispose();
  }

  // 生成列表
  List<DataRow> generateList() {
    return List<DataRow>.generate(
      questionSolutionNotifier.questionSolutionListModel.length,
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
                questionSolutionNotifier.questionSolutionListModel[index].id
                    .toString()),
          ),
          DataCell(
            SizedBox(
              width: 150,
              child: Text(
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  questionSolutionNotifier
                      .questionSolutionListModel[index].option),
            ),
          ),
          DataCell(
            Text(
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                checkCorrectAnswer(questionSolutionNotifier
                    .questionSolutionListModel[index].correctAnswer)),
          ),
          DataCell(
            Text(
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                questionSolutionNotifier
                    .questionSolutionListModel[index].correctItem
                    .toString()),
          ),
          DataCell(
            Text(
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                questionSolutionNotifier
                    .questionSolutionListModel[index].scoreRatio
                    .toString()),
          ),
          DataCell(
            Text(
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                questionSolutionNotifier
                    .questionSolutionListModel[index].position
                    .toString()),
          ),
          DataCell(
            Text(
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                Tools().timestampToStr(questionSolutionNotifier
                    .questionSolutionListModel[index].createTime)),
          ),
          DataCell(
            Text(
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                Tools().timestampToStr(questionSolutionNotifier
                    .questionSolutionListModel[index].updateTime)),
          ),
          DataCell(
            Row(
              children: [
                Text(
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    questionSolutionNotifier
                        .questionSolutionListModel[index].optionAttachment),
                /*
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(width: 0.5),
                  ),
                  child: Text(
                    Lang().view,
                    style: const TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                    ),
                  ),
                  onLongPress: () => viewImage(
                      attachment: questionSolutionNotifier
                          .questionSolutionListModel[index].attachment,
                      big: true),
                  onPressed: () => viewImage(
                      attachment: questionSolutionNotifier
                          .questionSolutionListModel[index].attachment),
                ),
                */
                const SizedBox(width: 10),
                /*
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(width: 0.5),
                  ),
                  child: Tooltip(
                    padding: const EdgeInsets.all(10),
                    message: ' jpg / jpeg / png / gif \n\n Max size 256 kb',
                    child: Text(
                      Lang().upload,
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      FileHelper().checkFile(
                          dirPath: './',
                          type: ['jpg', 'jpeg', 'png', 'gif']).then((value) {
                        if (value != null) {
                          questionSolutionNotifier.questionAttachment(
                              id: questionSolutionNotifier
                                  .questionSolutionListModel[index].id,
                              filePath: value);
                        }
                      });
                    });
                  },
                ),
                */
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

  String checkCorrectAnswer(int correctAnswer) {
    if (correctAnswer == 2) {
      return Lang().right;
    } else {
      return Lang().wrong;
    }
  }

  onSortColum(int columnIndex, bool ascending) {
    if (columnIndex == 0) {
      if (ascending) {
        questionSolutionNotifier.questionSolutionListModel
            .sort((a, b) => a.id.compareTo(b.id));
      } else {
        questionSolutionNotifier.questionSolutionListModel
            .sort((a, b) => b.id.compareTo(a.id));
      }
    }
    // 重置全选
    selected = List<bool>.generate(
      questionSolutionNotifier.questionSolutionListModel.length,
      (int index) {
        questionSolutionNotifier.questionSolutionListModel[index].selected =
            false;
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
                    const SizedBox(width: 10),
                    IconButton(
                      icon: const Icon(Icons.refresh),
                      onPressed: () {
                        setState(() {
                          position = 0;
                          fetchData();
                        });
                      },
                    ),
                    const SizedBox(width: 10),
                    IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () {
                        print('fuck');
                      },
                      // onPressed: () => addAlertDialog(context),
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
                              Lang().questionOptions,
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
                              Lang().correctAnswer,
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
                              Lang().correctItem,
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
                              Lang().scoreRatio,
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
                              Lang().position,
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
                              Lang().attachmentFile,
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
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(Lang().questionOptions)),
      body: mainWidget(context),
    );
  }
}
