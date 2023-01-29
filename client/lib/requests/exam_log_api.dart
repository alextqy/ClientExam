// ignore_for_file: file_names

import 'dart:convert';
import 'package:http/http.dart';
import 'package:client/public/file.dart';
import 'package:client/requests/base.dart';
import 'package:client/models/base.dart';
import 'package:client/models/base_list.dart';

class ExamLogApi extends ResponseHelper {
  Future<BaseListModel> examLogList({
    int page = 1,
    int pageSize = 10,
    String stext = '',
    int type = 0,
  }) async {
    Response response = await post(
      Uri.http(url, '/Exam/Log/List'),
      body: {
        'Token': FileHelper().readFile('token'),
        'Page': page.toString(),
        'PageSize': pageSize.toString(),
        'Stext': stext,
        'Type': type.toString(),
      },
      headers: postHeaders,
      encoding: postEncoding,
    );
    return BaseListModel.fromJson(jsonDecode(response.body));
  }

  Future<BaseModel> examLogInfo({
    int id = 0,
  }) async {
    Response response = await post(
      Uri.http(url, '/Exam/Log/Info'),
      body: {
        'Token': FileHelper().readFile('token'),
        'ID': id.toString(),
      },
      headers: postHeaders,
      encoding: postEncoding,
    );
    return BaseModel.fromJson(jsonDecode(response.body));
  }
}
