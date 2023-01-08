import 'dart:convert';
import 'package:client/Views/common/error_page.dart';
import 'package:client/models/base_list.dart';
import 'package:client/models/manager_model.dart';
import 'package:client/public/lang.dart';
import 'package:client/public/tools.dart';
import 'package:client/requests/manager_api.dart';
import 'package:flutter/material.dart';
import 'package:client/Views/common/menu.dart';

// ignore: must_be_immutable
class Manager extends StatefulWidget {
  late String headline;
  Manager({super.key, required this.headline});

  @override
  // ignore: no_logic_in_create_state
  State<Manager> createState() => ManagerState(headline: headline);
}

class ManagerState extends State<Manager> {
  late String headline;
  ManagerState({this.headline = ''});

  // TableCell itemWidget(String content) {
  //   return TableCell(
  //     child: Center(
  //       child: Padding(
  //         padding: const EdgeInsets.all(10),
  //         child: SizedBox(
  //           child: Text(content),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  // List<TableRow> dataForeach(List<ManagerModel> list) {
  //   List<TableRow> listWidget = [];
  //   listWidget.add(
  //     TableRow(
  //       decoration: const BoxDecoration(
  //         color: Colors.white,
  //       ),
  //       children: [
  //         Center(
  //           child: Text(Lang().account),
  //         ),
  //         Center(
  //           child: Text(Lang().name),
  //         ),
  //         Center(
  //           child: Text(Lang().createtime),
  //         ),
  //         Center(
  //           child: Text(Lang().updateTime),
  //         ),
  //       ],
  //     ),
  //   );
  //   for (var element in list) {
  //     listWidget.add(
  //       TableRow(
  //         children: [
  //           itemWidget(element.account),
  //           itemWidget(element.name),
  //           itemWidget(Tools().timestampToStr(element.createTime)),
  //           itemWidget(Tools().timestampToStr(element.updateTime)),
  //         ],
  //       ),
  //     );
  //   }
  //   return listWidget;
  // }

  List<DataRow> dataForeach(List<ManagerModel> list) {
    return List<DataRow>.generate(
      list.length,
      (index) => DataRow(
        cells: <DataCell>[
          DataCell(Text(list[index].account)),
          DataCell(Text(list[index].name)),
          DataCell(Text(Tools().timestampToStr(list[index].createTime))),
          DataCell(Text(Tools().timestampToStr(list[index].updateTime))),
        ],
      ),
    );
    // List<DataRow> listWidget = [];
    // for (var element in list) {
    //   listWidget.add(
    //     DataRow(
    //       cells: <DataCell>[
    //         DataCell(Text(element.account)),
    //         DataCell(Text(element.name)),
    //         DataCell(Text(Tools().timestampToStr(element.createTime))),
    //         DataCell(Text(Tools().timestampToStr(element.updateTime))),
    //       ],
    //     ),
    //   );
    // }
    // return listWidget;
  }

  mainWidget(BuildContext context, {dynamic data}) {
    data as List<ManagerModel>;

    return Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.all(0),
        margin: const EdgeInsets.all(0),
        color: Colors.grey,
        child: Container(
          margin: const EdgeInsets.all(10),
          color: Colors.white54,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(0),
              child: SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: DataTable(
                    border: TableBorder.all(color: Colors.white, width: 1),
                    // columnWidths: const {
                    //   0: FixedColumnWidth(300.0),
                    //   1: FixedColumnWidth(300.0),
                    //   2: FixedColumnWidth(300.0),
                    // },
                    // textBaseline: TextBaseline.alphabetic,
                    // defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    // defaultColumnWidth: const IntrinsicColumnWidth(),
                    // children: dataForeach(data),
                    columns: <DataColumn>[
                      DataColumn(
                        label: Expanded(
                          child: Text(
                            Lang().account,
                            style: const TextStyle(fontStyle: FontStyle.italic),
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Expanded(
                          child: Text(
                            Lang().name,
                            style: const TextStyle(fontStyle: FontStyle.italic),
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Expanded(
                          child: Text(
                            Lang().createtime,
                            style: const TextStyle(fontStyle: FontStyle.italic),
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Expanded(
                          child: Text(
                            Lang().updateTime,
                            style: const TextStyle(fontStyle: FontStyle.italic),
                          ),
                        ),
                      ),
                    ],
                    rows: dataForeach(data),
                  ),
                ),
              ),
            ),
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    var result = ManagerApi().managerList();

    return Scaffold(
      appBar: AppBar(title: Text(Lang().managers)),
      body: FutureBuilder(
        future: result,
        builder: (context, snapshot) {
          Widget widget;
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              widget = errorPage();
            } else {
              BaseListModel basicData = snapshot.data as BaseListModel;
              var managerList = managerFromJsonList(jsonEncode(basicData.data));
              widget = mainWidget(context, data: managerList);
            }
          } else {
            widget = const Padding(
              padding: EdgeInsets.all(20),
              child: CircularProgressIndicator(),
            );
          }
          return Center(child: widget);
        },
      ),
      drawer: Menu().drawer(context, headline: headline),
    );
  }
}
