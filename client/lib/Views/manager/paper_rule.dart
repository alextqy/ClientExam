// ignore_for_file: file_names

import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:client/public/lang.dart';
import 'package:client/public/tools.dart';
import 'package:client/Views/common/basic_info.dart';
import 'package:client/Views/common/toast.dart';

import 'package:client/providers/base_notifier.dart';
import 'package:client/providers/paper_rule_notifier.dart';
import 'package:client/providers/headline_notifier.dart';
import 'package:client/providers/knowledge_notifier.dart';

import 'package:client/models/paper_rule_model.dart';
import 'package:client/models/headline_model.dart';
import 'package:client/models/knowledge_model.dart';

// ignore: must_be_immutable
class PaperRules extends StatefulWidget {
  late String paperName;
  late int id;
  late int subjectID;
  PaperRules({super.key, required this.id, required this.paperName, required this.subjectID});

  @override
  State<PaperRules> createState() => PaperRulesState();
}

class PaperRulesState extends State<PaperRules> {
  bool sortAscending = false;
  int sortColumnIndex = 0;
  int showSelected = 0;
  List<bool> selected = [];

  int page = 1;
  int pageSize = perPageDropList.first;
  String searchText = '';
  int paperRuleState = 0;
  String stateMemo = stateDropList.first;
  int totalPage = 0;
  int orderBySerialNumber = 0;

  TextEditingController jumpToController = TextEditingController();

  PaperRuleNotifier paperRuleNotifier = PaperRuleNotifier();
  HeadlineNotifier headlineNotifier = HeadlineNotifier();
  KnowledgeNotifier knowledgeNotifier = KnowledgeNotifier();

  basicListener() async {
    if (paperRuleNotifier.operationStatus.value == OperationStatus.loading) {
      Toast().show(context, message: Lang().loading);
    } else if (paperRuleNotifier.operationStatus.value == OperationStatus.success) {
      fetchData();
      Toast().show(context, message: Lang().theOperationCompletes);
    } else {
      Toast().show(context, message: paperRuleNotifier.operationMemo);
    }
  }

  void fetchData() {
    paperRuleNotifier
        .paperRuleList(
      page: page,
      pageSize: pageSize,
      paperID: widget.id,
      paperRuleState: paperRuleState,
      orderBySerialNumber: orderBySerialNumber,
    )
        .then((value) {
      setState(() {
        paperRuleNotifier.paperRuleListModel = PaperRuleModel().fromJsonList(jsonEncode(value.data));
        selected = List<bool>.generate(paperRuleNotifier.paperRuleListModel.length, (int index) => false);
        totalPage = value.totalPage;
        showSelected = 0;
        sortAscending = false;
        if (totalPage == 0) {
          page = 0;
        }
      });
    });
  }

  void headlinesData() {
    headlineNotifier.headlines().then((value) {
      setState(() {
        headlineNotifier.headlineListModel = HeadlineModel().fromJsonList(jsonEncode(value.data));
      });
    });
  }

  void knowledgeData() {
    knowledgeNotifier.knowledge(subjectID: widget.subjectID).then((value) {
      setState(() {
        knowledgeNotifier.knowledgeListModel = KnowledgeModel().fromJsonList(jsonEncode(value.data));
      });
    });
  }

  @override
  void initState() {
    super.initState();
    paperRuleNotifier.addListener(basicListener);
    fetchData();
    headlinesData();
    knowledgeData();
  }

  @override
  void dispose() {
    paperRuleNotifier.dispose();
    paperRuleNotifier.removeListener(basicListener);
    super.dispose();
  }

  // 生成列表
  List<DataRow> generateList() {
    return List<DataRow>.generate(
      paperRuleNotifier.paperRuleListModel.length,
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
          DataCell(Text(overflow: TextOverflow.ellipsis, maxLines: 1, paperRuleNotifier.paperRuleListModel[index].id.toString())),
          DataCell(checkRuleType(headlineID: paperRuleNotifier.paperRuleListModel[index].headlineID, knowledgeID: paperRuleNotifier.paperRuleListModel[index].knowledgeID)),
          DataCell(
            Text(overflow: TextOverflow.ellipsis, maxLines: 1, checkQuestionType(paperRuleNotifier.paperRuleListModel[index].questionType)),
            showEditIcon: paperRuleNotifier.paperRuleListModel[index].questionType == 0 ? false : true,
            onTap: () {
              if (paperRuleNotifier.paperRuleListModel[index].questionType > 0) {
                updatePaperRuleAlertDialog(
                  id: paperRuleNotifier.paperRuleListModel[index].id,
                  questionType: paperRuleNotifier.paperRuleListModel[index].questionType,
                  questionNum: paperRuleNotifier.paperRuleListModel[index].questionNum,
                  singleScore: paperRuleNotifier.paperRuleListModel[index].singleScore,
                  serialNumber: paperRuleNotifier.paperRuleListModel[index].serialNumber,
                  setType: 1,
                );
              }
            },
          ),
          DataCell(
            Text(overflow: TextOverflow.ellipsis, maxLines: 1, paperRuleNotifier.paperRuleListModel[index].questionNum == 0 ? '' : paperRuleNotifier.paperRuleListModel[index].questionNum.toString()),
            showEditIcon: paperRuleNotifier.paperRuleListModel[index].questionNum == 0 ? false : true,
            onTap: () {
              if (paperRuleNotifier.paperRuleListModel[index].questionNum > 0) {
                updatePaperRuleAlertDialog(
                  id: paperRuleNotifier.paperRuleListModel[index].id,
                  questionType: paperRuleNotifier.paperRuleListModel[index].questionType,
                  questionNum: paperRuleNotifier.paperRuleListModel[index].questionNum,
                  singleScore: paperRuleNotifier.paperRuleListModel[index].singleScore,
                  serialNumber: paperRuleNotifier.paperRuleListModel[index].serialNumber,
                  setType: 2,
                );
              }
            },
          ),
          DataCell(
            Text(overflow: TextOverflow.ellipsis, maxLines: 1, paperRuleNotifier.paperRuleListModel[index].singleScore == 0 ? '' : paperRuleNotifier.paperRuleListModel[index].singleScore.toString()),
            showEditIcon: paperRuleNotifier.paperRuleListModel[index].singleScore == 0 ? false : true,
            // placeholder: true, // 内容浅色显示
            onTap: () {
              if (paperRuleNotifier.paperRuleListModel[index].singleScore > 0) {
                updatePaperRuleAlertDialog(
                  id: paperRuleNotifier.paperRuleListModel[index].id,
                  questionType: paperRuleNotifier.paperRuleListModel[index].questionType,
                  questionNum: paperRuleNotifier.paperRuleListModel[index].questionNum,
                  singleScore: paperRuleNotifier.paperRuleListModel[index].singleScore,
                  serialNumber: paperRuleNotifier.paperRuleListModel[index].serialNumber,
                  setType: 3,
                );
              }
            },
          ),
          DataCell(
            Text(overflow: TextOverflow.ellipsis, maxLines: 1, paperRuleNotifier.paperRuleListModel[index].serialNumber.toString()),
            showEditIcon: true,
            onTap: () {
              if (paperRuleNotifier.paperRuleListModel[index].serialNumber > 0) {
                updatePaperRuleAlertDialog(
                  id: paperRuleNotifier.paperRuleListModel[index].id,
                  questionType: paperRuleNotifier.paperRuleListModel[index].questionType,
                  questionNum: paperRuleNotifier.paperRuleListModel[index].questionNum,
                  singleScore: paperRuleNotifier.paperRuleListModel[index].singleScore,
                  serialNumber: paperRuleNotifier.paperRuleListModel[index].serialNumber,
                  setType: 4,
                );
              }
            },
          ),
          DataCell(
            CupertinoSwitch(
              value: paperRuleNotifier.paperRuleListModel[index].paperRuleState == 1 ? true : false,
              onChanged: (bool? value) {
                setState(() {
                  paperRuleNotifier.paperRuleDisabled(id: paperRuleNotifier.paperRuleListModel[index].id);
                });
              },
            ),
          ),
          DataCell(Text(overflow: TextOverflow.ellipsis, maxLines: 1, Tools().timestampToStr(paperRuleNotifier.paperRuleListModel[index].createTime))),
          DataCell(Text(overflow: TextOverflow.ellipsis, maxLines: 1, Tools().timestampToStr(paperRuleNotifier.paperRuleListModel[index].updateTime))),
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

  List<DropdownMenuItem<KnowledgeModel>> knowledgeDropdownMenuItemList() {
    List<DropdownMenuItem<KnowledgeModel>> dataDropdownMenuItemList = [];
    for (KnowledgeModel element in knowledgeNotifier.knowledgeListModel) {
      DropdownMenuItem<KnowledgeModel> data = DropdownMenuItem(
        value: element,
        child: SizedBox(
          width: 100,
          child: Text(
            element.knowledgeName,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ),
      );
      dataDropdownMenuItemList.add(data);
    }
    return dataDropdownMenuItemList;
  }

  List<DropdownMenuItem<HeadlineModel>> headlineDropdownMenuItemList() {
    List<DropdownMenuItem<HeadlineModel>> dataDropdownMenuItemList = [];
    for (HeadlineModel element in headlineNotifier.headlineListModel) {
      DropdownMenuItem<HeadlineModel> data = DropdownMenuItem(
        value: element,
        child: SizedBox(
          width: 600,
          child: Text(
            element.content,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ),
      );
      dataDropdownMenuItemList.add(data);
    }
    return dataDropdownMenuItemList;
  }

  checkRuleType({
    required int headlineID,
    required int knowledgeID,
  }) {
    late String text;
    if (headlineID > 0) {
      text = Lang().headlines;
    } else if (knowledgeID > 0) {
      text = Lang().knowledgePoints;
    } else {
      text = '';
    }
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        side: const BorderSide(width: 0.5),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 15,
          color: Colors.black,
        ),
      ),
      onPressed: () {
        if (headlineID > 0) {
          headlineNotifier.headlineInfo(id: headlineID).then((value) {
            ScrollController textController = ScrollController();
            if (value.state == true) {
              HeadlineModel headlineData = HeadlineModel.fromJson(value.data);
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
                          height: 500,
                          child: Scrollbar(
                            thumbVisibility: true,
                            radius: const Radius.circular(0),
                            thickness: 10,
                            controller: textController,
                            child: SingleChildScrollView(
                              controller: textController,
                              scrollDirection: Axis.vertical,
                              child: Text(headlineData.content),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              );
            } else {
              Toast().show(context, message: Lang().theRequestFailed);
            }
          });
        }
        if (knowledgeID > 0) {
          knowledgeNotifier.knowledgeInfo(id: knowledgeID).then((value) {
            if (value.state == true) {
              KnowledgeModel knowledgeData = KnowledgeModel.fromJson(value.data);
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
                          child: Text(knowledgeData.knowledgeName),
                        ),
                      );
                    },
                  );
                },
              );
            } else {
              Toast().show(context, message: Lang().theRequestFailed);
            }
          });
        }
      },
    );
  }

  // 修改
  void updatePaperRuleAlertDialog({
    required int id,
    required int questionType,
    required int questionNum,
    required double singleScore,
    required int serialNumber,
    required int setType,
  }) {
    TextEditingController updateQuestionNumController = TextEditingController();
    TextEditingController updateSingleScoreController = TextEditingController();
    TextEditingController updateSortController = TextEditingController();

    int updateQuestionType = questionType;
    String updateQuestionTypeMemo = checkQuestionType(questionType);
    updateQuestionNumController.text = questionNum.toString();
    updateSingleScoreController.text = singleScore.toString();
    updateSortController.text = serialNumber.toString();

    bool showQuestionType = false;
    bool showQuestionNum = false;
    bool showSingleScore = false;
    bool showSort = false;

    if (setType == 1) {
      showQuestionType = true;
    } else if (setType == 2) {
      showQuestionNum = true;
    } else if (setType == 3) {
      showSingleScore = true;
    } else if (setType == 4) {
      showSort = true;
    } else {
      showQuestionType = false;
      showQuestionNum = false;
      showSingleScore = false;
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
                  child: Row(
                    children: [
                      Visibility(
                        visible: showQuestionType,
                        child: Tooltip(
                          message: Lang().questionType,
                          child: Row(
                            children: [
                              DropdownButton<String>(
                                value: updateQuestionTypeMemo,
                                icon: const Icon(Icons.arrow_drop_down),
                                style: const TextStyle(color: Colors.black),
                                // elevation: 16,
                                underline: Container(
                                  height: 0,
                                  // color: Colors.deepPurpleAccent,
                                ),
                                onChanged: (String? value) {
                                  state(() {
                                    if (value != null && updateQuestionTypeMemo != value) {
                                      updateQuestionTypeMemo = value;
                                      if (value == Lang().multipleChoiceQuestions) {
                                        updateQuestionType = 1;
                                      } else if (value == Lang().judgmentQuestions) {
                                        updateQuestionType = 2;
                                      } else if (value == Lang().multipleSelection) {
                                        updateQuestionType = 3;
                                      } else if (value == Lang().fillInTheBlanks) {
                                        updateQuestionType = 4;
                                      } else if (value == Lang().quizQuestions) {
                                        updateQuestionType = 5;
                                      } else if (value == Lang().codeTesting) {
                                        updateQuestionType = 6;
                                      } else if (value == Lang().drag) {
                                        updateQuestionType = 7;
                                      } else if (value == Lang().connection) {
                                        updateQuestionType = 8;
                                      } else {
                                        updateQuestionType = 0;
                                      }
                                    }
                                  });
                                },
                                items: questionTypeList.map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Visibility(
                        visible: showQuestionNum,
                        child: Expanded(
                          child: TextField(
                            maxLines: 1,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(5),
                              FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                            ],
                            controller: updateQuestionNumController,
                            decoration: InputDecoration(
                              hintText: Lang().numberOfQuestions,
                              suffixIcon: IconButton(
                                iconSize: 20,
                                onPressed: () => updateQuestionNumController.clear(),
                                icon: const Icon(Icons.clear),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Visibility(
                        visible: showSingleScore,
                        child: Expanded(
                          child: TextField(
                            maxLines: 1,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(5),
                              FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
                            ],
                            controller: updateSingleScoreController,
                            decoration: InputDecoration(
                              hintText: Lang().scorePerQuestion,
                              suffixIcon: IconButton(
                                iconSize: 20,
                                onPressed: () => updateSingleScoreController.clear(),
                                icon: const Icon(Icons.clear),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Visibility(
                        visible: showSort,
                        child: Expanded(
                          child: TextField(
                            maxLines: 1,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(5),
                              FilteringTextInputFormatter.allow(RegExp(r'[1-9]')),
                            ],
                            controller: updateSortController,
                            decoration: InputDecoration(
                              hintText: Lang().sort,
                              suffixIcon: IconButton(
                                iconSize: 20,
                                onPressed: () => updateSortController.clear(),
                                icon: const Icon(Icons.clear),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
              actions: [
                TextButton(
                  onPressed: () {
                    if (updateQuestionType > 0 && int.parse(updateQuestionNumController.text) > 0 && double.parse(updateSingleScoreController.text) > 0 && int.parse(updateSortController.text) > 0) {
                      paperRuleNotifier.updatePaperRule(
                        id: id,
                        questionType: updateQuestionType,
                        questionNum: int.parse(updateQuestionNumController.text),
                        singleScore: double.parse(updateSingleScoreController.text),
                        serialNumber: int.parse(updateSortController.text),
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

  // 新建
  void addAlertDialog(BuildContext context, {required int addType}) {
    int newHeadlineID = 0;
    String newHeadlineMemo = Lang().notSelected;
    int newKnowledgeID = 0;
    String newKnowledgeMemo = Lang().notSelected;
    int newQuestionType = 0;
    String newQuestionTypeMemo = questionTypeList.first;

    int paperID = widget.id;
    int serialNumber = 1;

    TextEditingController questionNumController = TextEditingController();
    TextEditingController singleScoreController = TextEditingController();

    bool showHeadline = false;
    bool showKnowledge = false;

    double showH = 0;
    double showW = 0;

    if (addType == 1) {
      showHeadline = true;
    }
    if (addType == 2) {
      showKnowledge = true;
    }

    if (showHeadline == true) {
      showH = 50;
      showW = 700;
    }
    if (showKnowledge == true) {
      showH = 230;
      showW = 100;
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
                width: showW,
                height: showH,
                child: Column(
                  children: [
                    Visibility(
                      visible: showHeadline,
                      child: Column(
                        children: [
                          Tooltip(
                            message: Lang().headlines,
                            child: Row(
                              children: [
                                SizedBox(
                                  child: DropdownButton<HeadlineModel>(
                                    hint: SizedBox(
                                      width: 600,
                                      child: Text(
                                        newHeadlineMemo,
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
                                    onChanged: (HeadlineModel? value) {
                                      state(() {
                                        if (value!.id > 0) {
                                          newHeadlineMemo = value.content;
                                          newHeadlineID = value.id;
                                        }
                                      });
                                    },
                                    items: headlineDropdownMenuItemList(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Visibility(
                      visible: showKnowledge,
                      child: Column(
                        children: [
                          Tooltip(
                            message: Lang().questionType,
                            child: Row(
                              children: [
                                DropdownButton<String>(
                                  value: newQuestionTypeMemo,
                                  icon: const Icon(Icons.arrow_drop_down),
                                  style: const TextStyle(color: Colors.black),
                                  // elevation: 16,
                                  underline: Container(
                                    height: 0,
                                    // color: Colors.deepPurpleAccent,
                                  ),
                                  onChanged: (String? value) {
                                    state(() {
                                      if (value != null && newQuestionTypeMemo != value) {
                                        newQuestionTypeMemo = value;
                                        if (value == Lang().multipleChoiceQuestions) {
                                          newQuestionType = 1;
                                        } else if (value == Lang().judgmentQuestions) {
                                          newQuestionType = 2;
                                        } else if (value == Lang().multipleSelection) {
                                          newQuestionType = 3;
                                        } else if (value == Lang().fillInTheBlanks) {
                                          newQuestionType = 4;
                                        } else if (value == Lang().quizQuestions) {
                                          newQuestionType = 5;
                                        } else if (value == Lang().codeTesting) {
                                          newQuestionType = 6;
                                        } else if (value == Lang().drag) {
                                          newQuestionType = 7;
                                        } else if (value == Lang().connection) {
                                          newQuestionType = 8;
                                        } else {
                                          newQuestionType = 0;
                                        }
                                      }
                                    });
                                  },
                                  items: questionTypeList.map<DropdownMenuItem<String>>((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          Tooltip(
                            message: Lang().knowledgePoints,
                            child: Row(
                              children: [
                                SizedBox(
                                  child: DropdownButton<KnowledgeModel>(
                                    hint: SizedBox(
                                      width: 100,
                                      child: Text(
                                        newKnowledgeMemo,
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
                                    onChanged: (KnowledgeModel? value) {
                                      state(() {
                                        if (value!.id > 0) {
                                          newKnowledgeMemo = value.knowledgeName;
                                          newKnowledgeID = value.id;
                                        }
                                      });
                                    },
                                    items: knowledgeDropdownMenuItemList(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            child: TextField(
                              maxLines: 1,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(5),
                                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                              ],
                              controller: questionNumController,
                              decoration: InputDecoration(
                                hintText: Lang().numberOfQuestions,
                                suffixIcon: IconButton(
                                  iconSize: 20,
                                  onPressed: () => questionNumController.clear(),
                                  icon: const Icon(Icons.clear),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            child: TextField(
                              maxLines: 1,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(5),
                                FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
                              ],
                              controller: singleScoreController,
                              decoration: InputDecoration(
                                hintText: Lang().scorePerQuestion,
                                suffixIcon: IconButton(
                                  iconSize: 20,
                                  onPressed: () => singleScoreController.clear(),
                                  icon: const Icon(Icons.clear),
                                ),
                              ),
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
                    if (addType == 1 && newHeadlineID > 0 && newKnowledgeID == 0) {
                      paperRuleNotifier.newPaperRule(
                        headlineID: newHeadlineID,
                        questionType: newQuestionType,
                        knowledgeID: newKnowledgeID,
                        questionNum: int.parse(questionNumController.text.isEmpty ? '0' : questionNumController.text),
                        singleScore: double.parse(singleScoreController.text.isEmpty ? '0' : singleScoreController.text),
                        paperID: paperID,
                        serialNumber: serialNumber,
                      );
                      page = 1;
                    } else if (addType == 2 && newHeadlineID == 0 && newKnowledgeID > 0 && newQuestionType > 0 && questionNumController.text.isNotEmpty && singleScoreController.text.isNotEmpty) {
                      paperRuleNotifier.newPaperRule(
                        headlineID: newHeadlineID,
                        questionType: newQuestionType,
                        knowledgeID: newKnowledgeID,
                        questionNum: int.parse(questionNumController.text.isEmpty ? '0' : questionNumController.text),
                        singleScore: double.parse(singleScoreController.text.isEmpty ? '0' : singleScoreController.text),
                        paperID: paperID,
                        serialNumber: serialNumber,
                      );
                      page = 1;
                    } else {
                      Toast().show(context, message: Lang().parameterError);
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

  // 删除
  void deleteAction() {
    for (int i = 0; i < selected.length; i++) {
      if (selected[i]) {
        paperRuleNotifier.paperRuleDelete(id: paperRuleNotifier.paperRuleListModel[i].id);
      }
    }
    fetchData();
  }

  // 数据排序
  onSortColum(int columnIndex, bool ascending) {
    if (columnIndex == 0) {
      if (ascending) {
        paperRuleNotifier.paperRuleListModel.sort((a, b) => a.id.compareTo(b.id));
      } else {
        paperRuleNotifier.paperRuleListModel.sort((a, b) => b.id.compareTo(a.id));
      }
    }
    // 重置全选
    selected = List<bool>.generate(
      paperRuleNotifier.paperRuleListModel.length,
      (int index) {
        paperRuleNotifier.paperRuleListModel[index].selected = false;
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
                                paperRuleState = 0;
                              } else {
                                paperRuleState = Lang().normal == value ? 1 : 2;
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
                          paperRuleState = 0;
                          page = 1;
                          paperRuleState = 0;
                          orderBySerialNumber = 0;
                          fetchData();
                        });
                      },
                    ),
                    const SizedBox(width: 10),
                    Tooltip(
                      message: Lang().headlines,
                      child: IconButton(
                        icon: const Icon(Icons.title),
                        onPressed: () => addAlertDialog(context, addType: 1),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Tooltip(
                      message: Lang().questions,
                      child: IconButton(
                        icon: const Icon(Icons.question_answer_outlined),
                        onPressed: () => addAlertDialog(context, addType: 2),
                      ),
                    ),
                    const SizedBox(width: 10),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => deleteAction(),
                    ),
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
                              Lang().ruleType,
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
                              Lang().questionType,
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
                              Lang().numberOfQuestions,
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
                              Lang().scorePerQuestion,
                              style: const TextStyle(
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ),
                        ),
                        DataColumn(
                          label: SizedBox(
                            width: widgetWidth * percentage,
                            child: Row(
                              children: [
                                Text(
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  Lang().sort,
                                  style: const TextStyle(
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                                // const Expanded(child: SizedBox()),
                                const SizedBox(width: 5),
                                const Icon(Icons.sort),
                              ],
                            ),
                          ),
                          onSort: (columnIndex, ascending) {
                            setState(() {
                              if (orderBySerialNumber == 0) {
                                orderBySerialNumber = 1;
                              } else if (orderBySerialNumber == 1) {
                                orderBySerialNumber = 2;
                              } else if (orderBySerialNumber == 2) {
                                orderBySerialNumber = 1;
                              } else {
                                orderBySerialNumber = 0;
                              }
                              print(orderBySerialNumber);
                              fetchData();
                            });
                          },
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
      appBar: AppBar(
          title: Text(
        widget.paperName,
        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
      )),
      body: mainWidget(context),
    );
  }
}
