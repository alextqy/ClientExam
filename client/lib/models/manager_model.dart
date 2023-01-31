// ignore_for_file: file_names

import 'dart:convert';
import 'package:client/models/base.dart';

class ManagerModel extends BaseModel {
  late String password;
  late int state;
  late int updateTime;
  late String account;
  late String name;
  late int permission;
  late String token;
  late bool selected;

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
    this.selected = false,
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
