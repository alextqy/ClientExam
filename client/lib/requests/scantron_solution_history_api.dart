// ignore_for_file: file_names

import 'dart:convert';
import 'package:http/http.dart';
import 'package:client/public/file.dart';
import 'package:client/requests/base.dart';
import 'package:client/models/data.dart';
import 'package:client/models/data_list.dart';

class ScantronSolutionHistoryApi extends ResponseHelper {
  Future<DataListModel> scantronSolutionHistoryList({
    int page = 1,
    int pageSize = 10,
    int scantronID = 0,
    int position = 0,
  }) async {
    Response response = await post(
      Uri.http(url, '/Scantron/Solution/History/List'),
      body: {
        'Token': FileHelper().readFile('token'),
        'Page': page.toString(),
        'PageSize': pageSize.toString(),
        'ScantronID': scantronID.toString(),
        'Position': position.toString(),
      },
      headers: postHeaders,
      encoding: postEncoding,
    );
    return DataListModel.fromJson(
        jsonDecode(decoder.convert(response.bodyBytes)));
  }

  Future<DataModel> scantronSolutionHistoryInfo({
    int id = 0,
  }) async {
    Response response = await post(
      Uri.http(url, '/Scantron/Solution/History/Info'),
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
