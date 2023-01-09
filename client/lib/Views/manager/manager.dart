import 'dart:convert';
import 'package:client/Views/common/error_page.dart';
import 'package:client/Views/common/page_dropdown_button.dart';
import 'package:client/models/base_list.dart';
import 'package:client/models/manager_model.dart';
import 'package:client/public/lang.dart';
import 'package:client/public/tools.dart';
import 'package:client/requests/manager_api.dart';
import 'package:flutter/material.dart';
import 'package:client/Views/common/menu.dart';

var perPageDataDropdownButton = PerPageDataDropdownButton();
var stateDataDropdownButton = StateDataDropdownButton();

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

  List<ListTile> dataForeach(List<ManagerModel> list) {
    List<ListTile> dataList = [];
    for (var element in list) {
      dataList.add(
        ListTile(
          // horizontalTitleGap: 25,
          title: Text(
            element.account,
            style: const TextStyle(color: Colors.black),
          ),
          subtitle: Text(
            '${Lang().createtime} ${Tools().timestampToStr(element.createTime)}',
          ),
          trailing: IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {
              print(element.account);
            },
          ),
        ),
      );
    }
    return dataList;
    // return List<DataRow>.generate(
    //   list.length,
    //   (index) => DataRow(
    //     selected: selected[index],
    //     onSelectChanged: (bool? value) {
    //       setState(() {
    //         selected[index] = value!;
    //       });
    //     },
    //     cells: <DataCell>[
    //       DataCell(Text(list[index].account)),
    //       DataCell(Text(list[index].name)),
    //       DataCell(Text(Tools().timestampToStr(list[index].createTime))),
    //       DataCell(Text(Tools().timestampToStr(list[index].updateTime))),
    //     ],
    //   ),
    // );
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
                // child: SingleChildScrollView(
                //   scrollDirection: Axis.vertical,
                // child: SingleChildScrollView(
                //   scrollDirection: Axis.horizontal,
                child: Column(
                  children: [
                    SizedBox(
                      height: 40,
                      child: ColoredBox(
                        color: Colors.white,
                        child: Row(
                          children: [
                            const SizedBox(width: 30),
                            Tooltip(
                              message: Lang().amountOfAataPerPage,
                              child: SizedBox(
                                child: perPageDataDropdownButton,
                              ),
                            ),
                            const SizedBox(width: 30),
                            Tooltip(
                              message: Lang().status,
                              child: SizedBox(
                                child: stateDataDropdownButton,
                              ),
                            ),
                            const Expanded(child: SizedBox()),
                            IconButton(
                              icon: const Icon(Icons.refresh),
                              onPressed: () => print('refresh'),
                            ),
                            IconButton(
                              icon: const Icon(Icons.add),
                              onPressed: () => print('add'),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () => print('delete'),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListView(
                        shrinkWrap: true,
                        padding: const EdgeInsets.all(0),
                        children: dataForeach(data),
                      ),
                    ),
                  ],
                ),
                // ),
                // ),
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
