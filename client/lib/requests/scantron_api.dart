// ignore_for_file: file_names

import 'dart:convert';
import 'package:http/http.dart';
import 'package:client/public/file.dart';
import 'package:client/requests/base.dart';
import 'package:client/models/data.dart';
import 'package:client/models/data_list.dart';

class ScantronApi extends ResponseHelper {
  Future<DataListModel> scantronList({
    int page = 1,
    int pageSize = 10,
    int examID = 0,
  }) async {
    Response response = await post(
      Uri.http(url, '/Scantron/List'),
      body: {
        'Token': FileHelper().readFile('token'),
        'Page': page.toString(),
        'PageSize': pageSize.toString(),
        'ExamID': examID.toString(),
      },
      headers: postHeaders,
      encoding: postEncoding,
    );
    return DataListModel.fromJson(jsonDecode(decoder.convert(response.bodyBytes)));
  }

  Future<DataModel> scantronInfo({
    int id = 0,
  }) async {
    Response response = await post(
      Uri.http(url, '/Scantron/Info'),
      body: {
        'Token': FileHelper().readFile('token'),
        'ID': id.toString(),
      },
      headers: postHeaders,
      encoding: postEncoding,
    );
    return DataModel.fromJson(jsonDecode(decoder.convert(response.bodyBytes)));
  }

  Future<DataModel> scantronViewAttachments({
    String filePath = '',
  }) async {
    Response response = await post(
      Uri.http(url, '/Scantron/View/Attachments'),
      body: {
        'Token': FileHelper().readFile('token'),
        'FilePath': filePath,
      },
      headers: postHeaders,
      encoding: postEncoding,
    );
    return DataModel.fromJson(jsonDecode(decoder.convert(response.bodyBytes)));
  }
}
