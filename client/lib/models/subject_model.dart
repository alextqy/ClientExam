// ignore_for_file: file_names

import 'dart:convert';
import 'package:client/models/base.dart';

class SubjectModel extends BaseModel {
  late String subjectName;
  late String subjectCode;
  late int subjectState;
  late int updateTime;
  late bool selected;

  SubjectModel({
    int id = 0,
    int createTime = 0,
    this.subjectName = '',
    this.subjectCode = '',
    this.subjectState = 0,
    this.updateTime = 0,
    this.selected = false,
  }) : super(id, createTime);

  factory SubjectModel.fromJson(Map<String, dynamic> json) {
    return SubjectModel(
      id: json['ID'],
      createTime: json['CreateTime'],
      subjectName: json['SubjectName'],
      subjectCode: json['SubjectCode'],
      subjectState: json['SubjectState'],
      updateTime: json['UpdateTime'],
    );
  }

  List<SubjectModel> fromJsonList(String jsonString) {
    List<SubjectModel> dataList = (jsonDecode(jsonString) as List).map((i) => SubjectModel.fromJson(i)).toList();
    return dataList;
  }
}
