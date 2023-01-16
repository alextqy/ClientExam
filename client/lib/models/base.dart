class BaseModel {
  bool state = false;
  String memo = '';
  int code = 0;
  dynamic data;

  BaseModel({
    this.state = false,
    this.memo = '',
    this.code = 0,
    this.data,
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
