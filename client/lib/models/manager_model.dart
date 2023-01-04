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

  ManagerModel({
    required this.createTime,
    required this.password,
    required this.state,
    required this.updateTime,
    required this.account,
    required this.name,
    required this.id,
    required this.permission,
    required this.token,
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
}
