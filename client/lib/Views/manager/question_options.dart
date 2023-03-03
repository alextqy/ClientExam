// ignore_for_file: file_names

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:client/public/lang.dart';
import 'package:client/public/tools.dart';
import 'package:client/public/file.dart';
import 'package:client/Views/common/basic_info.dart';
import 'package:client/Views/common/toast.dart';

import 'package:client/providers/base_notifier.dart';
import 'package:client/providers/question_solution_notifier.dart';

import 'package:client/models/question_solution_model.dart';

// ignore: must_be_immutable
class QuestionOptions extends StatefulWidget {
  late String questionTitle;
  late int questionType;
  late int questionID;
  QuestionOptions(
      {super.key,
      required this.questionTitle,
      required this.questionType,
      required this.questionID});

  @override
  State<QuestionOptions> createState() => QuestionOptionsState();
}

class QuestionOptionsState extends State<QuestionOptions> {
  bool sortAscending = false;
  int sortColumnIndex = 0;
  int showSelected = 0;
  List<bool> selected = [];
  int position = 0;
  bool fillInTheBlanksAndQuizQuestionsEdit = false;

  bool showOption = false;
  bool showCorrectItem = false;
  bool showCorrectAnswer = false;
  bool showScoreRatio = false;
  bool showPosition = false;

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
    if (widget.questionType == 4 || widget.questionType == 5) {
      fillInTheBlanksAndQuizQuestionsEdit = true;
    }

    if (widget.questionType < 4) {
      showOption = true;
      showCorrectAnswer = true;
    } else if (widget.questionType == 4 || widget.questionType == 5) {
      showCorrectItem = true;
      showScoreRatio = true;
    } else if (widget.questionType == 6) {
      showCorrectItem = true;
    } else if (widget.questionType == 7 || widget.questionType == 8) {
      showOption = true;
      showPosition = true;
      showCorrectItem = true;
    } else {
      showOption = false;
      showCorrectItem = false;
      showCorrectAnswer = false;
      showScoreRatio = false;
      showPosition = false;
    }
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
                  .toString(),
            ),
          ),
          DataCell(
            Visibility(
              visible: showOption,
              child: SizedBox(
                width: 150,
                child: Text(
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  questionSolutionNotifier
                      .questionSolutionListModel[index].option,
                ),
              ),
            ),
          ),
          DataCell(
            Visibility(
              visible: showCorrectAnswer,
              child: Text(
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                checkCorrectAnswer(
                  questionSolutionNotifier
                      .questionSolutionListModel[index].correctAnswer,
                ),
              ),
            ),
          ),
          DataCell(
            Visibility(
              visible: showCorrectItem,
              child: Tooltip(
                message: questionSolutionNotifier
                    .questionSolutionListModel[index].correctItem,
                child: SizedBox(
                  width: 200,
                  child: Text(
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    questionSolutionNotifier
                        .questionSolutionListModel[index].correctItem,
                  ),
                ),
              ),
            ),
          ),
          DataCell(
            Visibility(
              visible: showScoreRatio,
              child: Text(
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                questionSolutionNotifier
                    .questionSolutionListModel[index].scoreRatio
                    .toString(),
              ),
            ),
            showEditIcon: fillInTheBlanksAndQuizQuestionsEdit,
            onTap: () {
              if (showScoreRatio == true) {
                setScoreRatioAlertDialog(
                  context,
                  id: questionSolutionNotifier
                      .questionSolutionListModel[index].id,
                  scoreRatio: questionSolutionNotifier
                      .questionSolutionListModel[index].scoreRatio
                      .toString(),
                );
              }
            },
          ),
          DataCell(
            Visibility(
              visible: showPosition,
              child: Text(
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                checkPosition(questionSolutionNotifier
                    .questionSolutionListModel[index].position),
              ),
            ),
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
                          .questionSolutionListModel[index].optionAttachment,
                      big: true),
                  onPressed: () => viewImage(
                      attachment: questionSolutionNotifier
                          .questionSolutionListModel[index].optionAttachment),
                ),
                const SizedBox(width: 10),
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(width: 0.5),
                  ),
                  child: Tooltip(
                    padding: const EdgeInsets.all(10),
                    message: ' jpg / jpeg / png / gif \n\n Max size 128 kb',
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
                          questionSolutionNotifier.questionSolutionAttachment(
                              id: questionSolutionNotifier
                                  .questionSolutionListModel[index].id,
                              filePath: value);
                        }
                      });
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

  // 查看图片
  void viewImage({required String attachment, bool big = false}) {
    dynamic height = 300.0;
    dynamic width = 500.0;
    if (big == true) {
      height = null;
      width = null;
    }
    setState(() {
      questionSolutionNotifier
          .questionSolutionViewAttachments(filePath: attachment)
          .then((value) {
        if (value.data != null) {
          showDialog(
            context: context,
            barrierDismissible: true,
            builder: (BuildContext context) {
              return StatefulBuilder(
                builder: (BuildContext context, Function state) {
                  return AlertDialog(
                    title: Text(value.memo),
                    content: SizedBox(
                      height: height,
                      width: width,
                      child: Container(
                        margin: const EdgeInsets.all(0),
                        padding: const EdgeInsets.all(0),
                        child: Image.memory(Tools()
                            .byteListToBytes(Tools().toByteList(value.data))),
                      ),
                    ),
                  );
                },
              );
            },
          );
        } else {
          Toast().show(context, message: Lang().noData);
        }
      });
    });
  }

  String checkPosition(int position) {
    if (position == 2) {
      return Lang().rightSide;
    } else {
      return Lang().leftSide;
    }
  }

  // 修改得分比例
  void setScoreRatioAlertDialog(
    BuildContext context, {
    required int id,
    required String scoreRatio,
  }) {
    TextEditingController updateScoreRatioController = TextEditingController();
    updateScoreRatioController.text = scoreRatio;
    if (widget.questionType == 4 || widget.questionType == 5) {
      showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (BuildContext context, Function state) {
              return AlertDialog(
                title: Text(Lang().title),
                content: SizedBox(
                  width: 500,
                  height: 200,
                  child: TextField(
                    maxLines: 1,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(4),
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
                    ],
                    controller: updateScoreRatioController,
                    decoration: InputDecoration(
                      hintText: Lang().name,
                      suffixIcon: IconButton(
                        iconSize: 20,
                        onPressed: () => updateScoreRatioController.clear(),
                        icon: const Icon(Icons.clear),
                      ),
                    ),
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      if (id > 0 &&
                          updateScoreRatioController.text.isNotEmpty) {
                        questionSolutionNotifier.setScoreRatio(
                          id: id,
                          scoreRatio:
                              double.parse(updateScoreRatioController.text),
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
  }

  String checkCorrectAnswer(int correctAnswer) {
    if (correctAnswer == 2) {
      return Lang().right;
    } else {
      return Lang().wrong;
    }
  }

  // 新建
  void addAlertDialog(BuildContext context) {
    double height = 0;

    TextEditingController optionController = TextEditingController();
    TextEditingController correctItemController = TextEditingController();
    int correctAnswer = 0;
    TextEditingController scoreRatioController = TextEditingController();
    scoreRatioController.text = '0';
    int position = 0;

    bool showOption = false;
    bool showCorrectItem = false;
    bool showCorrectAnswer = false;
    bool showScoreRatio = false;
    bool showPosition = false;
    bool showCorrectAnswerTip = false;

    String correctAnswerMemo = correctAnswerList.first;
    String positionMemo = positionList.first;

    if (widget.questionType < 4) {
      showOption = true;
      showCorrectAnswer = true;
      height = 150;
    } else if (widget.questionType == 4 || widget.questionType == 5) {
      showCorrectItem = true;
      showScoreRatio = true;
      height = 150;
    } else if (widget.questionType == 6) {
      showCorrectItem = true;
      height = 100;
    } else if (widget.questionType == 7 || widget.questionType == 8) {
      showOption = true;
      showPosition = true;
      showCorrectItem = true;
      showCorrectAnswerTip = true;
      height = 250;
    } else {
      showOption = false;
      showCorrectItem = false;
      showCorrectAnswer = false;
      showScoreRatio = false;
      showPosition = false;
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
                width: 1000,
                height: height,
                child: Column(
                  children: [
                    Visibility(
                      visible: showOption,
                      child: SizedBox(
                        child: TextField(
                          maxLines: 1,
                          controller: optionController,
                          decoration: InputDecoration(
                            hintText: Lang().optionDescription,
                            suffixIcon: IconButton(
                              iconSize: 20,
                              onPressed: () => optionController.clear(),
                              icon: const Icon(Icons.clear),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Visibility(
                      visible: showCorrectItem,
                      child: SizedBox(
                        child: TextField(
                          maxLines: 1,
                          controller: correctItemController,
                          decoration: InputDecoration(
                            hintText: Lang().correctItem,
                            suffixIcon: IconButton(
                              iconSize: 20,
                              onPressed: () => correctItemController.clear(),
                              icon: const Icon(Icons.clear),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: showCorrectAnswerTip,
                      child: Row(
                        children: [
                          Text(
                            Lang().theCorrectAnswerIsTheOptionOnTheLeft,
                            style: const TextStyle(
                              color: Colors.redAccent,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Visibility(
                          visible: showCorrectAnswer,
                          child: SizedBox(
                            child: Tooltip(
                              message: Lang().correctAnswer,
                              child: DropdownButton<String>(
                                value: correctAnswerMemo,
                                icon: const Icon(Icons.arrow_drop_down),
                                style: const TextStyle(color: Colors.black),
                                // elevation: 16,
                                underline: Container(
                                  height: 0,
                                  // color: Colors.deepPurpleAccent,
                                ),
                                onChanged: (String? value) {
                                  state(() {
                                    if (value != null &&
                                        correctAnswerMemo != value) {
                                      correctAnswerMemo = value;
                                      if (value == Lang().no) {
                                        correctAnswer = 1;
                                        correctAnswerMemo = Lang().no;
                                      } else if (value == Lang().yes) {
                                        correctAnswer = 2;
                                        correctAnswerMemo = Lang().yes;
                                      } else {
                                        correctAnswer = 0;
                                        correctAnswerMemo =
                                            correctAnswerList.first;
                                      }
                                    }
                                  });
                                },
                                items: correctAnswerList
                                    .map<DropdownMenuItem<String>>(
                                        (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Visibility(
                      visible: showScoreRatio,
                      child: Tooltip(
                        message: Lang().scoreRatio,
                        child: SizedBox(
                          child: TextField(
                            maxLines: 1,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(4),
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'[0-9.]')),
                            ],
                            controller: scoreRatioController,
                            decoration: InputDecoration(
                              hintText: Lang().scoreRatio,
                              suffixIcon: IconButton(
                                iconSize: 20,
                                onPressed: () => scoreRatioController.clear(),
                                icon: const Icon(Icons.clear),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Visibility(
                          visible: showPosition,
                          child: SizedBox(
                            child: Tooltip(
                              message: Lang().position,
                              child: DropdownButton<String>(
                                value: positionMemo,
                                icon: const Icon(Icons.arrow_drop_down),
                                style: const TextStyle(color: Colors.black),
                                // elevation: 16,
                                underline: Container(
                                  height: 0,
                                  // color: Colors.deepPurpleAccent,
                                ),
                                onChanged: (String? value) {
                                  state(() {
                                    if (value != null &&
                                        positionMemo != value) {
                                      positionMemo = value;
                                      if (value == Lang().leftSide) {
                                        position = 1;
                                        positionMemo = Lang().leftSide;
                                        showCorrectItem = false;
                                        correctItemController.text = '';
                                      } else if (value == Lang().rightSide) {
                                        position = 2;
                                        positionMemo = Lang().rightSide;
                                        showCorrectItem = true;
                                      } else {
                                        position = 0;
                                        positionMemo = correctAnswerList.first;
                                        showCorrectItem = true;
                                        correctItemController.text = '';
                                      }
                                    }
                                  });
                                },
                                items: positionList
                                    .map<DropdownMenuItem<String>>(
                                        (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    questionSolutionNotifier.newQuestionSolution(
                      questionID: widget.questionID,
                      option: optionController.text,
                      correctAnswer: correctAnswer,
                      correctItem: correctItemController.text,
                      scoreRatio: double.parse(scoreRatioController.text),
                      position: position,
                    );
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

  // 删除
  void deleteAlertDialog() {
    for (int i = 0; i < selected.length; i++) {
      if (selected[i]) {
        questionSolutionNotifier.questionSolutionDelete(
            id: questionSolutionNotifier.questionSolutionListModel[i].id);
      }
    }
    fetchData();
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
            /// title
            SizedBox(
              child: Tooltip(
                message: widget.questionTitle,
                child: Container(
                  padding: const EdgeInsets.all(20),
                  child: Text(
                    widget.questionTitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ),

            Container(
              height: 2,
              decoration: const BoxDecoration(color: Colors.black38),
            ),

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
                        addAlertDialog(context);
                      },
                      // onPressed: () => addAlertDialog(context),
                    ),
                    const SizedBox(width: 10),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => deleteAlertDialog(),
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
