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
import 'package:client/providers/question_notifier.dart';
import 'package:client/providers/knowledge_notifier.dart';
import 'package:client/providers/question_solution_notifier.dart';

import 'package:client/models/question_model.dart';
import 'package:client/models/knowledge_model.dart';

import 'package:client/Views/manager/question_options.dart';

// ignore: must_be_immutable
class Question extends StatefulWidget {
  late String headline;
  Question({super.key, required this.headline});

  @override
  State<Question> createState() => QuestionState();
}

class QuestionState extends State<Question> {
  bool sortAscending = false;
  int sortColumnIndex = 0;
  int showSelected = 0;
  List<bool> selected = [];

  int page = 1;
  int pageSize = perPageDropList.first;
  String searchText = '';
  int totalPage = 0;
  int questionType = 0;
  int questionState = 0;
  int knowledgeID = 0;

  String stateMemo = stateDropList.first;
  String questionTypeMemo = questionTypeList.first;
  String knowledgeMemo = Lang().notSelected;

  TextEditingController jumpToController = TextEditingController();
  TextEditingController cupertinoSearchTextFieldController = TextEditingController();

  QuestionNotifier questionNotifier = QuestionNotifier();
  KnowledgeNotifier knowledgeNotifier = KnowledgeNotifier();
  QuestionSolutionNotifier questionSolutionNotifier = QuestionSolutionNotifier();

  basicListener() async {
    if (questionNotifier.operationStatus.value == OperationStatus.loading) {
      Toast().show(context, message: Lang().loading);
    } else if (questionNotifier.operationStatus.value == OperationStatus.success) {
      fetchData();
      Toast().show(context, message: Lang().theOperationCompletes);
    } else {
      Toast().show(context, message: questionNotifier.operationMemo);
    }
  }

  void fetchData() {
    questionNotifier
        .questionList(
      page: page,
      pageSize: pageSize,
      stext: searchText,
      questionType: questionType,
      questionState: questionState,
      knowledgeID: knowledgeID,
    )
        .then((value) {
      setState(() {
        questionNotifier.questionListModel = QuestionModel().fromJsonList(jsonEncode(value.data));
        selected = List<bool>.generate(questionNotifier.questionListModel.length, (int index) => false);
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

  void knowledgeData() {
    knowledgeNotifier.knowledge(subjectID: 0).then((value) {
      setState(() {
        knowledgeNotifier.knowledgeListModel = KnowledgeModel().fromJsonList(jsonEncode(value.data));
      });
    });
  }

  @override
  void initState() {
    super.initState();
    questionNotifier.addListener(basicListener);
    fetchData();
    knowledgeData();
  }

  @override
  void dispose() {
    questionNotifier.dispose();
    questionNotifier.removeListener(basicListener);
    super.dispose();
  }

  // 生成列表
  List<DataRow> generateList() {
    return List<DataRow>.generate(
      questionNotifier.questionListModel.length,
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
          DataCell(Text(overflow: TextOverflow.ellipsis, maxLines: 1, questionNotifier.questionListModel[index].id.toString())),
          DataCell(
            SizedBox(width: 150, child: Text(overflow: TextOverflow.ellipsis, maxLines: 1, questionNotifier.questionListModel[index].questionTitle)),
            showEditIcon: true,
            // placeholder: true, // 内容浅色显示
            onTap: () {
              infoAlertDialog(
                context,
                id: questionNotifier.questionListModel[index].id,
                questionTitle: questionNotifier.questionListModel[index].questionTitle,
                questionType: questionNotifier.questionListModel[index].questionType,
                description: questionNotifier.questionListModel[index].description,
                language: questionNotifier.questionListModel[index].language,
                languageVersion: questionNotifier.questionListModel[index].languageVersion,
                itemType: 1,
              );
            },
          ),
          DataCell(Text(overflow: TextOverflow.ellipsis, maxLines: 1, questionNotifier.questionListModel[index].questionCode)),
          DataCell(Text(overflow: TextOverflow.ellipsis, maxLines: 1, checkQuestionType(questionNotifier.questionListModel[index].questionType))),
          DataCell(
            SizedBox(width: 150, child: Text(overflow: TextOverflow.ellipsis, maxLines: 1, questionNotifier.questionListModel[index].description)),
            showEditIcon: true,
            // placeholder: true, // 内容浅色显示
            onTap: () {
              infoAlertDialog(
                context,
                id: questionNotifier.questionListModel[index].id,
                questionTitle: questionNotifier.questionListModel[index].questionTitle,
                questionType: questionNotifier.questionListModel[index].questionType,
                description: questionNotifier.questionListModel[index].description,
                language: questionNotifier.questionListModel[index].language,
                languageVersion: questionNotifier.questionListModel[index].languageVersion,
                itemType: 2,
              );
            },
          ),
          DataCell(
            Text(overflow: TextOverflow.ellipsis, maxLines: 1, questionNotifier.questionListModel[index].language),
            showEditIcon: questionNotifier.questionListModel[index].questionType == 6 ? true : false,
            // placeholder: true, // 内容浅色显示
            onTap: () {
              if (questionNotifier.questionListModel[index].questionType == 6) {
                infoAlertDialog(
                  context,
                  id: questionNotifier.questionListModel[index].id,
                  questionTitle: questionNotifier.questionListModel[index].questionTitle,
                  questionType: questionNotifier.questionListModel[index].questionType,
                  description: questionNotifier.questionListModel[index].description,
                  language: questionNotifier.questionListModel[index].language,
                  languageVersion: questionNotifier.questionListModel[index].languageVersion,
                  itemType: 3,
                );
              }
            },
          ),
          DataCell(Text(overflow: TextOverflow.ellipsis, maxLines: 1, questionNotifier.questionListModel[index].languageVersion)),
          DataCell(Text(overflow: TextOverflow.ellipsis, maxLines: 1, Tools().timestampToStr(questionNotifier.questionListModel[index].createTime))),
          DataCell(Text(overflow: TextOverflow.ellipsis, maxLines: 1, Tools().timestampToStr(questionNotifier.questionListModel[index].updateTime))),
          DataCell(
            CupertinoSwitch(
              value: questionNotifier.questionListModel[index].questionState == 1 ? true : false,
              onChanged: (bool? value) {
                setState(() {
                  questionNotifier.questionDisabled(id: questionNotifier.questionListModel[index].id);
                });
              },
            ),
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
                  onLongPress: () => viewImage(attachment: questionNotifier.questionListModel[index].attachment, big: true),
                  onPressed: () => viewImage(attachment: questionNotifier.questionListModel[index].attachment),
                ),
                const SizedBox(width: 10),
                OutlinedButton(
                  style: OutlinedButton.styleFrom(side: const BorderSide(width: 0.5)),
                  child: Tooltip(
                    padding: const EdgeInsets.all(10),
                    message: ' jpg / jpeg / png / gif \n\n Max size 64 kb',
                    child: Text(Lang().upload, style: const TextStyle(fontSize: 15, color: Colors.black)),
                  ),
                  onPressed: () {
                    setState(() {
                      FileHelper().checkFile(dirPath: './', type: ['jpg', 'jpeg', 'png', 'gif']).then((value) {
                        if (value != null) {
                          questionNotifier.questionAttachment(id: questionNotifier.questionListModel[index].id, filePath: value);
                        }
                      });
                    });
                  },
                ),
              ],
            ),
          ),
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
                          builder: (context) => QuestionOptions(
                            questionTitle: questionNotifier.questionListModel[index].questionTitle,
                            questionType: questionNotifier.questionListModel[index].questionType,
                            questionID: questionNotifier.questionListModel[index].id,
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

  // 查看图片
  void viewImage({required String attachment, bool big = false}) {
    dynamic height = 300.0;
    dynamic width = 500.0;
    if (big == true) {
      height = null;
      width = null;
    }
    setState(() {
      questionNotifier.questionViewAttachments(filePath: attachment).then((value) {
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
                        child: Image.memory(Tools().byteListToBytes(Tools().toByteList(value.data))),
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

  List<DropdownMenuItem<KnowledgeModel>> knowledgeDropdownMenuItemList() {
    List<DropdownMenuItem<KnowledgeModel>> knowledgeDataDropdownMenuItemList = [];
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
      knowledgeDataDropdownMenuItemList.add(data);
    }
    return knowledgeDataDropdownMenuItemList;
  }

  // 修改
  void infoAlertDialog(
    BuildContext context, {
    required int id,
    required String questionTitle,
    required int questionType,
    required String description,
    required String language,
    required String languageVersion,
    required int itemType, // 1 QuestionTitle 2 Description 3 Language
  }) {
    TextEditingController updateQuestionTitleController = TextEditingController();
    TextEditingController updateDescriptionController = TextEditingController();
    TextEditingController updateLanguageController = TextEditingController();
    TextEditingController updateLanguageVersionController = TextEditingController();
    updateQuestionTitleController.text = questionTitle;
    updateDescriptionController.text = description;
    updateLanguageController.text = language;
    updateLanguageVersionController.text = languageVersion;

    String updateLanguageMemo = languageList.first;
    bool showQuestionTitleItem = false;
    bool showDescriptionItem = false;
    bool showLanguageItem = false;
    bool showSpaceButton = false;
    double width = 0;
    double height = 0;

    if (itemType == 1) {
      width = 1000;
      height = 100;
      showQuestionTitleItem = true;
    }
    if (itemType == 2) {
      width = 1000;
      height = 500;
      showDescriptionItem = true;
    }
    if (itemType == 3) {
      width = 150;
      height = 150;
      showLanguageItem = true;
      updateLanguageMemo = language;
    }
    if (questionType == 4) {
      showSpaceButton = true;
    }
    if (itemType == 3 && questionType != 6) {
      Toast().show(context, message: Lang().noData);
    } else {
      showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (BuildContext context, Function state) {
              return AlertDialog(
                title: Text(Lang().title),
                content: SizedBox(
                  width: width,
                  height: height,
                  child: Column(
                    children: [
                      Visibility(
                        visible: showQuestionTitleItem,
                        child: SizedBox(
                          child: TextField(
                            maxLines: 1,
                            controller: updateQuestionTitleController,
                            decoration: InputDecoration(
                              hintText: Lang().questionTitle,
                              prefixIcon: Tooltip(
                                message: Lang().generateTheEncoding,
                                child: Visibility(
                                  visible: showSpaceButton,
                                  child: IconButton(
                                    iconSize: 20,
                                    onPressed: () {
                                      int offset = updateQuestionTitleController.selection.base.offset;
                                      String titleText = updateQuestionTitleController.text;
                                      if (offset >= 0 && titleText.isNotEmpty) {
                                        String title = Tools().stringInsertion(titleText, offset, '<->');
                                        updateQuestionTitleController.text = title;
                                      }
                                    },
                                    icon: const Icon(Icons.credit_card),
                                  ),
                                ),
                              ),
                              suffixIcon: IconButton(
                                iconSize: 20,
                                onPressed: () => updateQuestionTitleController.clear(),
                                icon: const Icon(Icons.clear),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Visibility(
                        visible: showDescriptionItem,
                        child: Expanded(
                          child: SizedBox(
                            child: TextField(
                              minLines: 30,
                              maxLines: null,
                              controller: updateDescriptionController,
                              decoration: InputDecoration(
                                hintText: Lang().description,
                                suffixIcon: IconButton(
                                  iconSize: 20,
                                  onPressed: () => updateDescriptionController.clear(),
                                  icon: const Icon(Icons.clear),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Visibility(
                        visible: showLanguageItem,
                        child: Tooltip(
                          message: Lang().language,
                          child: Row(
                            children: [
                              DropdownButton<String>(
                                value: updateLanguageMemo,
                                icon: const Icon(Icons.arrow_drop_down),
                                style: const TextStyle(color: Colors.black),
                                // elevation: 16,
                                underline: Container(
                                  height: 0,
                                  // color: Colors.deepPurpleAccent,
                                ),
                                onChanged: (String? value) {
                                  state(() {
                                    if (value != null && updateLanguageMemo != value) {
                                      updateLanguageMemo = value;
                                    }
                                  });
                                },
                                items: languageList.map<DropdownMenuItem<String>>((String value) {
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
                        visible: showLanguageItem,
                        child: SizedBox(
                          child: TextField(
                            maxLines: 1,
                            controller: updateLanguageVersionController,
                            decoration: InputDecoration(
                              hintText: Lang().languageVersion,
                              suffixIcon: IconButton(
                                iconSize: 20,
                                onPressed: () => updateLanguageVersionController.clear(),
                                icon: const Icon(Icons.clear),
                              ),
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
                      String newLanguageParam = updateLanguageMemo != Lang().notSelected ? updateLanguageMemo : '';
                      if (updateQuestionTitleController.text.isNotEmpty && updateDescriptionController.text.isNotEmpty) {
                        questionNotifier.updateQuestionInfo(
                          id: id,
                          questionTitle: updateQuestionTitleController.text,
                          questionType: questionType,
                          description: updateDescriptionController.text,
                          language: newLanguageParam,
                          languageVersion: updateLanguageVersionController.text,
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
  }

  // 新建
  void addAlertDialog(BuildContext context) {
    TextEditingController newQuestionTitleController = TextEditingController();
    TextEditingController newDescriptionController = TextEditingController();
    TextEditingController newLanguageVersionController = TextEditingController();
    String newLanguageMemo = languageList.first;
    String newQuestionTypeMemo = questionTypeList.first;
    String newKnowledgeMemo = Lang().notSelected;
    int newQuestionType = 0;
    int newKnowledgeID = 0;
    bool showLanguageItem = false;
    bool showSpaceButton = false;
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
                child: Column(
                  children: [
                    SizedBox(
                      child: TextField(
                        maxLines: 1,
                        controller: newQuestionTitleController,
                        decoration: InputDecoration(
                          hintText: Lang().questionTitle,
                          prefixIcon: Tooltip(
                            message: Lang().generateTheEncoding,
                            child: Visibility(
                              visible: showSpaceButton,
                              child: IconButton(
                                iconSize: 20,
                                onPressed: () {
                                  int offset = newQuestionTitleController.selection.base.offset;
                                  String titleText = newQuestionTitleController.text;
                                  if (offset >= 0 && titleText.isNotEmpty) {
                                    String title = Tools().stringInsertion(titleText, offset, '<->');
                                    newQuestionTitleController.text = title;
                                  }
                                },
                                icon: const Icon(Icons.credit_card),
                              ),
                            ),
                          ),
                          suffixIcon: IconButton(
                            iconSize: 20,
                            onPressed: () => newQuestionTitleController.clear(),
                            icon: const Icon(Icons.clear),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: SizedBox(
                        child: TextField(
                          minLines: 30,
                          maxLines: null,
                          controller: newDescriptionController,
                          decoration: InputDecoration(
                            hintText: Lang().description,
                            suffixIcon: IconButton(
                              iconSize: 20,
                              onPressed: () => newDescriptionController.clear(),
                              icon: const Icon(Icons.clear),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
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
                                  if (newQuestionType == 4) {
                                    showSpaceButton = true;
                                  } else {
                                    showSpaceButton = false;
                                  }
                                  if (newQuestionType == 6) {
                                    showLanguageItem = true;
                                  } else {
                                    showLanguageItem = false;
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
                          DropdownButton<KnowledgeModel>(
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
                                  page = 1;
                                  fetchData();
                                }
                              });
                            },
                            items: knowledgeDropdownMenuItemList(),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Visibility(
                      visible: showLanguageItem,
                      child: Tooltip(
                        message: Lang().language,
                        child: Row(
                          children: [
                            DropdownButton<String>(
                              value: newLanguageMemo,
                              icon: const Icon(Icons.arrow_drop_down),
                              style: const TextStyle(color: Colors.black),
                              // elevation: 16,
                              underline: Container(
                                height: 0,
                                // color: Colors.deepPurpleAccent,
                              ),
                              onChanged: (String? value) {
                                state(() {
                                  if (value != null && newLanguageMemo != value) {
                                    newLanguageMemo = value;
                                  }
                                });
                              },
                              items: languageList.map<DropdownMenuItem<String>>((String value) {
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
                      visible: showLanguageItem,
                      child: SizedBox(
                        child: TextField(
                          maxLines: 1,
                          controller: newLanguageVersionController,
                          decoration: InputDecoration(
                            hintText: Lang().languageVersion,
                            suffixIcon: IconButton(
                              iconSize: 20,
                              onPressed: () => newLanguageVersionController.clear(),
                              icon: const Icon(Icons.clear),
                            ),
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
                    String newLanguageParam = newLanguageMemo != Lang().notSelected ? newLanguageMemo : '';
                    if (newQuestionTitleController.text.isNotEmpty && newQuestionType > 0 && newKnowledgeID > 0) {
                      questionNotifier.newQuestion(
                        questionTitle: newQuestionTitleController.text,
                        questionType: newQuestionType,
                        knowledgeID: newKnowledgeID,
                        description: newDescriptionController.text,
                        language: newLanguageParam,
                        languageVersion: newLanguageVersionController.text,
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
        questionNotifier.questionListModel.sort((a, b) => a.id.compareTo(b.id));
      } else {
        questionNotifier.questionListModel.sort((a, b) => b.id.compareTo(a.id));
      }
    }
    // 重置全选
    selected = List<bool>.generate(
      questionNotifier.questionListModel.length,
      (int index) {
        questionNotifier.questionListModel[index].selected = false;
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
                      message: Lang().knowledgePoints,
                      child: SizedBox(
                        child: DropdownButton<KnowledgeModel>(
                          hint: SizedBox(
                            width: 100,
                            child: Text(
                              knowledgeMemo,
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
                            setState(() {
                              if (value!.id > 0) {
                                knowledgeMemo = value.knowledgeName;
                                knowledgeID = value.id;
                                page = 1;
                                fetchData();
                              }
                            });
                          },
                          items: knowledgeDropdownMenuItemList(),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Tooltip(
                      message: Lang().questionType,
                      child: DropdownButton<String>(
                        value: questionTypeMemo,
                        icon: const Icon(Icons.arrow_drop_down),
                        style: const TextStyle(color: Colors.black),
                        // elevation: 16,
                        underline: Container(
                          height: 0,
                          // color: Colors.deepPurpleAccent,
                        ),
                        onChanged: (String? value) {
                          setState(() {
                            if (value != null && questionTypeMemo != value) {
                              questionTypeMemo = value;
                              if (value == Lang().multipleChoiceQuestions) {
                                questionType = 1;
                              } else if (value == Lang().judgmentQuestions) {
                                questionType = 2;
                              } else if (value == Lang().multipleSelection) {
                                questionType = 3;
                              } else if (value == Lang().fillInTheBlanks) {
                                questionType = 4;
                              } else if (value == Lang().quizQuestions) {
                                questionType = 5;
                              } else if (value == Lang().codeTesting) {
                                questionType = 6;
                              } else if (value == Lang().drag) {
                                questionType = 7;
                              } else if (value == Lang().connection) {
                                questionType = 8;
                              } else {
                                questionType = 0;
                              }
                              page = 1;
                              fetchData();
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
                    ),
                    const SizedBox(width: 10),
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
                                questionState = 0;
                              } else {
                                questionState = Lang().normal == value ? 1 : 2;
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
                          questionType = 0;
                          questionState = 0;
                          knowledgeID = 0;
                          questionTypeMemo = questionTypeList.first;
                          stateMemo = stateDropList.first;
                          knowledgeMemo = Lang().notSelected;
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
                              Lang().questionTitle,
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
                              Lang().questionCode,
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
                              Lang().description,
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
                              Lang().language,
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
                              Lang().languageVersion,
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
      appBar: AppBar(title: Text(Lang().questions)),
      body: mainWidget(context),
    );
  }
}
