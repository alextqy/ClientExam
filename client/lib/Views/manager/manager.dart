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
  static int numItems = 999999;
  List<bool> selected = List<bool>.generate(numItems, (int index) => false);
  ManagerState({this.headline = ''});

  List<DataRow> dataForeach(List<ManagerModel> list) {
    return List<DataRow>.generate(
      list.length,
      (index) => DataRow(
        selected: selected[index],
        onSelectChanged: (bool? value) {
          setState(() {
            selected[index] = value!;
          });
        },
        cells: <DataCell>[
          DataCell(Text(list[index].account)),
          DataCell(Text(list[index].name)),
          DataCell(Text(Tools().timestampToStr(list[index].createTime))),
          DataCell(Text(Tools().timestampToStr(list[index].updateTime))),
        ],
      ),
    );
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
                    headingRowHeight: 50, // 顶部 Row 高度
                    dataRowHeight: 40, // Rows 中每条 Row 高度
                    // horizontalMargin: 20, // 左侧边距
                    // columnSpacing: 80, // 每一列间距
                    // dividerThickness: 1, // 分割线宽度
                    // showCheckboxColumn: true, // 是否展示左侧 checkbox，默认为 true，需要和 DataRow 的onSelectChanged 一起使用,
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
