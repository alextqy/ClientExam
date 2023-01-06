class BaseListModel {
  bool state = false;
  String memo = '';
  int code = 0;
  int page = 0;
  int pageSize = 0;
  int totalPage = 1;
  dynamic data;

  BaseListModel({
    required this.state,
    required this.memo,
    required this.code,
    required this.page,
    required this.pageSize,
    required this.totalPage,
    required this.data,
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
