// ignore_for_file: file_names

import 'dart:convert';
// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:client/public/lang.dart';
import 'package:client/public/tools.dart';
import 'package:client/Views/common/basic_info.dart';
import 'package:client/Views/common/toast.dart';
// import 'package:client/Views/common/menu.dart';

import 'package:client/providers/base_notifier.dart';
import 'package:client/providers/teacher_notifier.dart';

import 'package:client/models/scantron_model.dart';

import 'package:client/Views/teacher/answer_card_options.dart';

// ignore: must_be_immutable
class AnswerCards extends StatefulWidget {
  late String examNo;
  late int examID;
  AnswerCards({super.key, required this.examNo, required this.examID});

  @override
  State<AnswerCards> createState() => AnswerCardsState();
}

class AnswerCardsState extends State<AnswerCards> {
  bool sortAscending = false;
  int sortColumnIndex = 0;
  int showSelected = 0;
  List<bool> selected = [];

  int page = 1;
  int pageSize = perPageDropList.first;
  int totalPage = 0;

  TextEditingController jumpToController = TextEditingController();

  TeacherNotifier teacherNotifier = TeacherNotifier();

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
        .teacherScantronList(
      type: 1,
      page: page,
      pageSize: pageSize,
      examID: widget.examID,
    )
        .then((value) {
      setState(() {
        teacherNotifier.scantronListModel = ScantronModel().fromJsonList(jsonEncode(value.data));
        selected = List<bool>.generate(teacherNotifier.scantronListModel.length, (int index) => false);
        totalPage = value.totalPage;
        showSelected = 0;
        sortAscending = false;
        if (totalPage == 0) {
          page = 0;
        }
      });
    });
  }

  @override
  void initState() {
    super.initState();
    teacherNotifier.addListener(basicListener);
    fetchData();
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
      teacherNotifier.scantronListModel.length,
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
          DataCell(Text(overflow: TextOverflow.ellipsis, maxLines: 1, teacherNotifier.scantronListModel[index].id.toString())),
          DataCell(
            SizedBox(
              width: 200,
              child: Text(
                overflow: TextOverflow.ellipsis,
                maxLines: null,
                teacherNotifier.scantronListModel[index].headlineContent == 'none' ? '' : teacherNotifier.scantronListModel[index].headlineContent,
              ),
            ),
          ),
          DataCell(
            SizedBox(
              width: 200,
              child: Text(overflow: TextOverflow.ellipsis, maxLines: null, teacherNotifier.scantronListModel[index].questionTitle == 'none' ? '' : teacherNotifier.scantronListModel[index].questionTitle),
            ),
          ),
          DataCell(Text(overflow: TextOverflow.ellipsis, maxLines: null, teacherNotifier.scantronListModel[index].questionCode == 'none' ? '' : teacherNotifier.scantronListModel[index].questionCode)),
          DataCell(Text(overflow: TextOverflow.ellipsis, maxLines: null, checkQuestionType(teacherNotifier.scantronListModel[index].questionType))),
          DataCell(
            SizedBox(
              width: 200,
              child: Text(overflow: TextOverflow.ellipsis, maxLines: null, teacherNotifier.scantronListModel[index].description == 'none' ? '' : teacherNotifier.scantronListModel[index].description),
            ),
          ),
          DataCell(
            SizedBox(
              width: 200,
              child: teacherNotifier.scantronListModel[index].questionType == 0
                  ? const SizedBox()
                  : Row(
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
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onLongPress: () => viewImage(attachment: teacherNotifier.scantronListModel[index].attachment, big: true),
                          onPressed: () => viewImage(attachment: teacherNotifier.scantronListModel[index].attachment),
                        ),
                      ],
                    ),
            ),
          ),
          DataCell(Text(overflow: TextOverflow.ellipsis, maxLines: 1, Tools().timestampToStr(teacherNotifier.scantronListModel[index].createTime))),
          DataCell(Text(overflow: TextOverflow.ellipsis, maxLines: 1, Tools().timestampToStr(teacherNotifier.scantronListModel[index].updateTime))),
          DataCell(teacherNotifier.scantronListModel[index].questionType == 0 ? const SizedBox() : Text(overflow: TextOverflow.ellipsis, maxLines: null, teacherNotifier.scantronListModel[index].score.toString())),
          DataCell(checkRightOrWrong(teacherNotifier.scantronListModel[index])),
          DataCell(
            Row(
              children: [
                const SizedBox(width: 25),
                teacherNotifier.scantronListModel[index].questionType > 0
                    ? IconButton(
                        icon: const Icon(Icons.list),
                        onPressed: () {
                          setState(() {
                            Navigator.of(context)
                                .push(
                              MaterialPageRoute(
                                builder: (context) => AnswerCardOptions(
                                  questionType: teacherNotifier.scantronListModel[index].questionType,
                                  questionTitle: teacherNotifier.scantronListModel[index].questionTitle,
                                  scantronID: teacherNotifier.scantronListModel[index].id,
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
                      )
                    : const SizedBox(),
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

  Widget checkRightOrWrong(ScantronModel data) {
    if (data.right == 2 && data.questionType > 0) {
      return Text(Lang().right);
    } else if (data.right == 1 && data.questionType > 0) {
      return Text(Lang().wrong);
    } else if (data.questionType > 0) {
      return Text(Lang().not);
    } else {
      return const Text('');
    }
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
      teacherNotifier.teacherScantronViewAttachments(filePath: attachment).then((value) {
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

  // 数据排序
  onSortColum(int columnIndex, bool ascending) {
    if (columnIndex == 0) {
      if (ascending) {
        teacherNotifier.scantronListModel.sort((a, b) => a.id.compareTo(b.id));
      } else {
        teacherNotifier.scantronListModel.sort((a, b) => b.id.compareTo(a.id));
      }
    }
    // 重置全选
    selected = List<bool>.generate(
      teacherNotifier.scantronListModel.length,
      (int index) {
        teacherNotifier.scantronListModel[index].selected = false;
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
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Expanded(child: SizedBox()),
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
                          page = 1;
                          fetchData();
                        });
                      },
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
                              Lang().headlines,
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
                              Lang().questionTitle,
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
                              Lang().questionCode,
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
                              Lang().questionType,
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
                              Lang().description,
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
                              Lang().attachmentFile,
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
                              Lang().updateTime,
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
                              Lang().scorePerQuestion,
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
                              Lang().right,
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
                              Lang().questionOptions,
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
      appBar: AppBar(title: Text(widget.examNo)),
      body: mainWidget(context),
    );
  }
}
