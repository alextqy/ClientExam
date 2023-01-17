import 'dart:convert';

class ManagerModel {
  int createTime = 0;
  String password = '';
  int state = 0;
  int updateTime = 0;
  String account = '';
  String name = '';
  int id = 0;
  int permission = 0;
  String token = '';
  bool selected = false;

  ManagerModel({
    this.createTime = 0,
    this.password = '',
    this.state = 0,
    this.updateTime = 0,
    this.account = '',
    this.name = '',
    this.id = 0,
    this.permission = 0,
    this.token = '',
  });

  factory ManagerModel.fromJson(Map<String, dynamic> json) {
    return ManagerModel(
      createTime: json['CreateTime'],
      password: json['Password'],
      state: json['State'],
      updateTime: json['UpdateTime'],
      account: json['Account'],
      name: json['Name'],
      id: json['ID'],
      permission: json['Permission'],
      token: json['Token'],
    );
  }

  List<ManagerModel> fromJsonList(String jsonString) {
    List<ManagerModel> managerList = (jsonDecode(jsonString) as List)
        .map((i) => ManagerModel.fromJson(i))
        .toList();
    return managerList;
  }
}
