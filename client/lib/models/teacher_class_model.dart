// ignore_for_file: file_names

import 'dart:convert';
import 'package:client/models/base.dart';

class TeacherClassModel extends BaseModel {
  late int teacherID;
  late int classID;
  late bool selected;

  TeacherClassModel({
    int id = 0,
    int createTime = 0,
    this.teacherID = 0,
    this.classID = 0,
    this.selected = false,
  }) : super(id, createTime);

  factory TeacherClassModel.fromJson(Map<String, dynamic> json) {
    return TeacherClassModel(
      id: json['ID'],
      createTime: json['CreateTime'],
      teacherID: json['TeacherID'],
      classID: json['ClassID'],
    );
  }

  List<TeacherClassModel> fromJsonList(String jsonString) {
    List<TeacherClassModel> dataList = (jsonDecode(jsonString) as List)
        .map((i) => TeacherClassModel.fromJson(i))
        .toList();
    return dataList;
  }
}
