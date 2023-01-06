class BaseModel {
  bool state = false;
  String memo = '';
  int code = 0;
  dynamic data;

  BaseModel({
    required this.state,
    required this.memo,
    required this.code,
    required this.data,
  });

  factory BaseModel.fromJson(Map<String, dynamic> json) {
    return BaseModel(
      state: json['State'],
      memo: json['Memo'],
      code: json['Code'],
      data: json['Data'],
    );
  }
}
