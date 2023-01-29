// ignore_for_file: file_names

import 'dart:convert';
import 'package:http/http.dart';
import 'package:client/public/file.dart';
import 'package:client/requests/base.dart';
import 'package:client/models/base.dart';
import 'package:client/models/base_list.dart';

class ScantronHistoryApi extends ResponseHelper {
  Future<BaseListModel> scantronHistoryList({
    int page = 1,
    int pageSize = 10,
    int examID = 0,
  }) async {
    Response response = await post(
      Uri.http(url, '/Scantron/History/List'),
      body: {
        'Token': FileHelper().readFile('token'),
        'Page': page.toString(),
        'PageSize': pageSize.toString(),
        'ExamID': examID.toString(),
      },
      headers: postHeaders,
      encoding: postEncoding,
    );
    return BaseListModel.fromJson(jsonDecode(response.body));
  }

  Future<BaseModel> scantronHistoryInfo({
    int id = 0,
  }) async {
    Response response = await post(
      Uri.http(url, '/Scantron/History/Info'),
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
