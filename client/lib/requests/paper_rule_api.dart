// ignore_for_file: file_names

import 'dart:convert';
import 'package:http/http.dart';
import 'package:client/public/file.dart';
import 'package:client/requests/base.dart';
import 'package:client/models/base.dart';
import 'package:client/models/base_list.dart';

class PaperRuleApi extends ResponseHelper {
  Future<BaseModel> newPaperRule({
    int headlineID = 0,
    int questionType = 0,
    int knowledgeID = 0,
    int questionNum = 0,
    double singleScore = 0,
    int paperID = 0,
    int serialNumber = 0,
  }) async {
    Response response = await post(
      Uri.http(url, '/New/Paper/Rule'),
      body: {
        'Token': FileHelper().readFile('token'),
        'headlineID': headlineID.toString(),
        'QuestionType': questionType.toString(),
        'KnowledgeID': knowledgeID.toString(),
        'QuestionNum': questionNum.toString(),
        'SingleScore': singleScore.toString(),
        'PaperID': paperID.toString(),
        'SerialNumber': serialNumber.toString(),
      },
      headers: postHeaders,
      encoding: postEncoding,
    );
    return BaseModel.fromJson(jsonDecode(response.body));
  }

  Future<BaseModel> paperRuleDisabled({
    int id = 0,
  }) async {
    Response response = await post(
      Uri.http(url, '/Paper/Rule/Disabled'),
      body: {
        'Token': FileHelper().readFile('token'),
        'ID': id.toString(),
      },
      headers: postHeaders,
      encoding: postEncoding,
    );
    return BaseModel.fromJson(jsonDecode(response.body));
  }

  Future<BaseModel> paperRuleDelete({
    int id = 0,
  }) async {
    Response response = await post(
      Uri.http(url, '/Paper/Rule/Delete'),
      body: {
        'Token': FileHelper().readFile('token'),
        'ID': id.toString(),
      },
      headers: postHeaders,
      encoding: postEncoding,
    );
    return BaseModel.fromJson(jsonDecode(response.body));
  }

  Future<BaseListModel> paperRuleList({
    int page = 1,
    int pageSize = 10,
    int paperID = 0,
    int paperRuleState = 0,
  }) async {
    Response response = await post(
      Uri.http(url, '/Paper/Rule/List'),
      body: {
        'Token': FileHelper().readFile('token').trim(),
        'Page': page.toString(),
        'PageSize': pageSize.toString(),
        'PaperID': paperID.toString(),
        'PaperRuleState': paperRuleState.toString(),
      },
      headers: postHeaders,
      encoding: postEncoding,
    );
    return BaseListModel.fromJson(jsonDecode(response.body));
  }
}
