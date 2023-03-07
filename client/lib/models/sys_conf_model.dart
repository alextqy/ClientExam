// ignore_for_file: file_names

import 'dart:convert';
import 'package:client/models/base.dart';

class SysConfModel extends BaseModel {
  late int type;
  late String key;
  late String value;
  late String description;
  late bool selected;

  SysConfModel({
    int id = 0,
    int createTime = 0,
    this.type = 0,
    this.key = '',
    this.value = '',
    this.description = '',
    this.selected = false,
  }) : super(id, createTime);

  factory SysConfModel.fromJson(Map<String, dynamic> json) {
    return SysConfModel(
      id: json['ID'],
      createTime: json['CreateTime'],
      type: json['Type'],
      key: json['Key'],
      value: json['Value'],
      description: json['Description'],
    );
  }

  List<SysConfModel> fromJsonList(String jsonString) {
    List<SysConfModel> dataList = (jsonDecode(jsonString) as List).map((i) => SysConfModel.fromJson(i)).toList();
    return dataList;
  }
}
