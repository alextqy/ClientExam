// ignore_for_file: file_names

import 'dart:convert';
import 'package:client/models/base.dart';

class TeacherModel extends BaseModel {
  late String account;
  late String password;
  late String name;
  late int state;
  late int updateTime;
  late String token;
  late bool selected;

  TeacherModel({
    int id = 0,
    int createTime = 0,
    this.account = '',
    this.password = '',
    this.name = '',
    this.state = 0,
    this.updateTime = 0,
    this.token = '',
    this.selected = false,
  }) : super(id, createTime);

  factory TeacherModel.fromJson(Map<String, dynamic> json) {
    return TeacherModel(
      id: json['ID'],
      createTime: json['CreateTime'],
      account: json['Account'],
      password: json['Password'],
      name: json['Name'],
      state: json['State'],
      updateTime: json['UpdateTime'],
      token: json['Token'],
    );
  }

  List<TeacherModel> fromJsonList(String jsonString) {
    List<TeacherModel> dataList = (jsonDecode(jsonString) as List)
        .map((i) => TeacherModel.fromJson(i))
        .toList();
    return dataList;
  }
}
