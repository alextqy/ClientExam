// ignore_for_file: file_names

import 'dart:convert';
import 'package:client/models/base.dart';

class ExamineeTokenModel extends BaseModel {
  late String token;
  late int examID;

  ExamineeTokenModel({
    int id = 0,
    int createTime = 0,
    String token = '',
    String examID = '',
  }) : super(id, createTime);

  factory ExamineeTokenModel.fromJson(Map<String, dynamic> json) {
    return ExamineeTokenModel(
      id: json['ID'],
      createTime: json['CreateTime'],
      token: json['Token'],
      examID: json['ExamID'],
    );
  }

  List<ExamineeTokenModel> fromJsonList(String jsonString) {
    List<ExamineeTokenModel> dataList = (jsonDecode(jsonString) as List)
        .map((i) => ExamineeTokenModel.fromJson(i))
        .toList();
    return dataList;
  }
}
