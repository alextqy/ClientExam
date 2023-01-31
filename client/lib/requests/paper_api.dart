// ignore_for_file: file_names

import 'dart:convert';
import 'package:http/http.dart';
import 'package:client/public/file.dart';
import 'package:client/requests/base.dart';
import 'package:client/models/data.dart';
import 'package:client/models/data_list.dart';

class PaperApi extends ResponseHelper {
  Future<DataModel> newPaper({
    String paperName = '',
    int subjectID = 0,
    int totalScore = 0,
    int passLine = 0,
    int examDuration = 0,
  }) async {
    Response response = await post(
      Uri.http(url, '/New/Paper'),
      body: {
        'Token': FileHelper().readFile('token'),
        'PaperName': paperName,
        'SubjectID': subjectID.toString(),
        'TotalScore': totalScore.toString(),
        'PassLine': passLine.toString(),
        'ExamDuration': examDuration.toString(),
      },
      headers: postHeaders,
      encoding: postEncoding,
    );
    return DataModel.fromJson(jsonDecode(response.body));
  }

  Future<DataModel> paperDisabled({
    int id = 0,
  }) async {
    Response response = await post(
      Uri.http(url, '/Paper/Disabled'),
      body: {
        'Token': FileHelper().readFile('token'),
        'ID': id.toString(),
      },
      headers: postHeaders,
      encoding: postEncoding,
    );
    return DataModel.fromJson(jsonDecode(response.body));
  }

  Future<DataModel> updatePaperInfo({
    int id = 0,
    String paperName = '',
    int totalScore = 0,
    int passLine = 0,
    int examDuration = 0,
  }) async {
    Response response = await post(
      Uri.http(url, '/Update/Paper/Info'),
      body: {
        'Token': FileHelper().readFile('token'),
        'ID': id.toString(),
        'PaperName': paperName,
        'TotalScore': totalScore.toString(),
        'PassLine': passLine.toString(),
        'ExamDuration': examDuration.toString(),
      },
      headers: postHeaders,
      encoding: postEncoding,
    );
    return DataModel.fromJson(jsonDecode(response.body));
  }

  Future<DataListModel> paperList({
    int page = 1,
    int pageSize = 10,
    String stext = '',
    int subjectID = 0,
    int paperState = 0,
  }) async {
    Response response = await post(
      Uri.http(url, '/Paper/List'),
      body: {
        'Token': FileHelper().readFile('token'),
        'Page': page.toString(),
        'PageSize': pageSize.toString(),
        'Stext': stext,
        'SubjectID': subjectID.toString(),
        'PaperState': paperState.toString(),
      },
      headers: postHeaders,
      encoding: postEncoding,
    );
    return DataListModel.fromJson(jsonDecode(response.body));
  }

  Future<DataModel> paperInfo({
    int id = 0,
  }) async {
    Response response = await post(
      Uri.http(url, '/Paper/Info'),
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
