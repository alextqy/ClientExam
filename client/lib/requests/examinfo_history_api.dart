// ignore_for_file: file_names

import 'dart:convert';
import 'package:http/http.dart';
import 'package:client/public/file.dart';
import 'package:client/requests/base.dart';
import 'package:client/models/data.dart';
import 'package:client/models/data_list.dart';

class ExamInfoHistoryApi extends ResponseHelper {
  Future<DataListModel> examInfoHistoryList({
    int page = 1,
    int pageSize = 10,
    String stext = '',
    int examState = 0,
    int examType = 0,
    int pass = 0,
  }) async {
    Response response = await post(
      Uri.http(url, '/ExamInfo/History/List'),
      body: {
        'Token': FileHelper().readFile('token'),
        'Page': page.toString(),
        'PageSize': pageSize.toString(),
        'Stext': stext,
        'ExamState': examState.toString(),
        'ExamType': examType.toString(),
        'Pass': pass.toString(),
      },
      headers: postHeaders,
      encoding: postEncoding,
    );
    return DataListModel.fromJson(jsonDecode(decoder.convert(response.bodyBytes)));
  }

  Future<DataModel> examInfoHistory({
    int id = 0,
  }) async {
    Response response = await post(
      Uri.http(url, '/ExamInfo/History'),
      body: {
        'Token': FileHelper().readFile('token'),
        'ID': id.toString(),
      },
      headers: postHeaders,
      encoding: postEncoding,
    );
    return DataModel.fromJson(jsonDecode(decoder.convert(response.bodyBytes)));
  }
}
