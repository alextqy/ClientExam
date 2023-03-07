// ignore_for_file: file_names

import 'dart:convert';
import 'package:client/models/base.dart';

class HeadlineModel extends BaseModel {
  late String content;
  late String contentCode;
  late int updateTime;
  late bool selected;

  HeadlineModel({
    int id = 0,
    int createTime = 0,
    this.content = '',
    this.contentCode = '',
    this.updateTime = 0,
    this.selected = false,
  }) : super(id, createTime);

  factory HeadlineModel.fromJson(Map<String, dynamic> json) {
    return HeadlineModel(
      id: json['ID'],
      createTime: json['CreateTime'],
      content: json['Content'],
      contentCode: json['ContentCode'],
      updateTime: json['UpdateTime'],
    );
  }

  List<HeadlineModel> fromJsonList(String jsonString) {
    List<HeadlineModel> dataList = (jsonDecode(jsonString) as List).map((i) => HeadlineModel.fromJson(i)).toList();
    return dataList;
  }
}
