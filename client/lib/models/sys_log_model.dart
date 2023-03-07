// ignore_for_file: file_names

import 'dart:convert';
import 'package:client/models/base.dart';

class SysLogModel extends BaseModel {
  late int type;
  late int managerID;
  late String description;
  late String ip;
  late bool selected;

  SysLogModel({
    int id = 0,
    int createTime = 0,
    this.type = 0,
    this.managerID = 0,
    this.description = '',
    this.ip = '',
    this.selected = false,
  }) : super(id, createTime);

  factory SysLogModel.fromJson(Map<String, dynamic> json) {
    return SysLogModel(
      id: json['ID'],
      createTime: json['CreateTime'],
      type: json['Type'],
      managerID: json['ManagerID'],
      description: json['Description'],
      ip: json['IP'],
    );
  }

  List<SysLogModel> fromJsonList(String jsonString) {
    List<SysLogModel> dataList = (jsonDecode(jsonString) as List).map((i) => SysLogModel.fromJson(i)).toList();
    return dataList;
  }
}
