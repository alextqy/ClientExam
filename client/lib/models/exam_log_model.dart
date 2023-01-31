// ignore_for_file: file_names

import 'dart:convert';
import 'package:client/models/base.dart';

class ExamLogModel extends BaseModel {
  late int type;
  late String examNo;
  late String description;
  late String ip;
  late bool selected;

  ExamLogModel({
    int id = 0,
    int createTime = 0,
    this.type = 0,
    this.examNo = '',
    this.description = '',
    this.ip = '',
    this.selected = false,
  }) : super(id, createTime);

  factory ExamLogModel.fromJson(Map<String, dynamic> json) {
    return ExamLogModel(
      id: json['ID'],
      createTime: json['CreateTime'],
      type: json['Type'],
      examNo: json['ExamNo'],
      description: json['Description'],
      ip: json['IP'],
    );
  }

  List<ExamLogModel> fromJsonList(String jsonString) {
    List<ExamLogModel> dataList = (jsonDecode(jsonString) as List)
        .map((i) => ExamLogModel.fromJson(i))
        .toList();
    return dataList;
  }
}
