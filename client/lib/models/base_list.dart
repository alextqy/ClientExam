class BaseListModel {
  bool state = false;
  String memo = '';
  int code = 0;
  int page = 0;
  int pageSize = 0;
  int totalPage = 1;
  dynamic data;

  BaseListModel({
    this.state = false,
    this.memo = '',
    this.code = 0,
    this.page = 0,
    this.pageSize = 0,
    this.totalPage = 1,
    this.data = 0,
  });

  factory BaseListModel.fromJson(Map<String, dynamic> json) {
    return BaseListModel(
      state: json['State'],
      memo: json['Memo'],
      code: json['Code'],
      page: json['Page'],
      pageSize: json['PageSize'],
      totalPage: json['TotalPage'],
      data: json['Data'],
    );
  }
}
