// ignore_for_file: file_names

import 'dart:convert';
import 'package:client/models/base.dart';

class ClassModel extends BaseModel {
  late String className;
  late String classCode;
  late String description;
  late bool selected;

  ClassModel({
    int id = 0,
    int createTime = 0,
    this.className = '',
    this.classCode = '',
    this.description = '',
    this.selected = false,
  }) : super(id, createTime);

  factory ClassModel.fromJson(Map<String, dynamic> json) {
    return ClassModel(
      id: json['ID'],
      createTime: json['CreateTime'],
      className: json['ClassName'],
      classCode: json['ClassCode'],
      description: json['Description'],
    );
  }

  List<ClassModel> fromJsonList(String jsonString) {
    List<ClassModel> dataList = (jsonDecode(jsonString) as List).map((i) => ClassModel.fromJson(i)).toList();
    return dataList;
  }
}
