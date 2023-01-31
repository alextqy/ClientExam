// ignore_for_file: file_names

import 'dart:convert';
import 'package:client/models/base.dart';

class ManagerModel extends BaseModel {
  String password = '';
  int state = 0;
  int updateTime = 0;
  String account = '';
  String name = '';
  int permission = 0;
  String token = '';
  bool selected = false;

  ManagerModel({
    int id = 0,
    int createTime = 0,
    this.password = '',
    this.state = 0,
    this.updateTime = 0,
    this.account = '',
    this.name = '',
    this.permission = 0,
    this.token = '',
  }) : super(id, createTime);

  factory ManagerModel.fromJson(Map<String, dynamic> json) {
    return ManagerModel(
      id: json['ID'],
      createTime: json['CreateTime'],
      password: json['Password'],
      state: json['State'],
      updateTime: json['UpdateTime'],
      account: json['Account'],
      name: json['Name'],
      permission: json['Permission'],
      token: json['Token'],
    );
  }

  List<ManagerModel> fromJsonList(String jsonString) {
    List<ManagerModel> dataList = (jsonDecode(jsonString) as List)
        .map((i) => ManagerModel.fromJson(i))
        .toList();
    return dataList;
  }
}
