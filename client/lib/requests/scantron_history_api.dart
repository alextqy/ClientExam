// ignore_for_file: file_names

import 'dart:convert';
import 'package:http/http.dart';
import 'package:client/public/file.dart';
import 'package:client/requests/base.dart';
import 'package:client/models/data.dart';
import 'package:client/models/data_list.dart';

class ScantronHistoryApi extends ResponseHelper {
  Future<DataListModel> scantronHistoryList({
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
    return DataListModel.fromJson(jsonDecode(response.body));
  }

  Future<DataModel> scantronHistoryInfo({
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
    return DataModel.fromJson(jsonDecode(response.body));
  }
}
