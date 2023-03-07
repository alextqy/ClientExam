// ignore_for_file: file_names

import 'dart:convert';
import 'package:http/http.dart';
import 'package:client/public/file.dart';
import 'package:client/requests/base.dart';
import 'package:client/models/data.dart';
import 'package:client/models/data_list.dart';

class PaperRuleApi extends ResponseHelper {
  Future<DataModel> newPaperRule({
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
    return DataModel.fromJson(jsonDecode(decoder.convert(response.bodyBytes)));
  }

  Future<DataModel> paperRuleDisabled({
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
    return DataModel.fromJson(jsonDecode(decoder.convert(response.bodyBytes)));
  }

  Future<DataModel> paperRuleDelete({
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
    return DataModel.fromJson(jsonDecode(decoder.convert(response.bodyBytes)));
  }

  Future<DataListModel> paperRuleList({
    int page = 1,
    int pageSize = 10,
    int paperID = 0,
    int paperRuleState = 0,
  }) async {
    Response response = await post(
      Uri.http(url, '/Paper/Rule/List'),
      body: {
        'Token': FileHelper().readFile('token'),
        'Page': page.toString(),
        'PageSize': pageSize.toString(),
        'PaperID': paperID.toString(),
        'PaperRuleState': paperRuleState.toString(),
      },
      headers: postHeaders,
      encoding: postEncoding,
    );
    return DataListModel.fromJson(
        jsonDecode(decoder.convert(response.bodyBytes)));
  }

  Future<DataModel> paperRules({
    int paperID = 0,
  }) async {
    Response response = await post(
      Uri.http(url, '/Paper/Rules'),
      body: {
        'Token': FileHelper().readFile('token'),
        'PaperID': paperID.toString(),
      },
      headers: postHeaders,
      encoding: postEncoding,
    );
    return DataModel.fromJson(jsonDecode(decoder.convert(response.bodyBytes)));
  }

  Future<DataModel> updatePaperRule({
    int id = 0,
    int questionType = 0,
    int questionNum = 0,
    double singleScore = 0,
    int serialNumber = 0,
  }) async {
    Response response = await post(
      Uri.http(url, '/Update/Paper/Rule'),
      body: {
        'Token': FileHelper().readFile('token'),
        'ID': id.toString(),
        'QuestionType': questionType.toString(),
        'QuestionNum': questionNum.toString(),
        'SingleScore': singleScore.toString(),
        'SerialNumber': serialNumber.toString(),
      },
      headers: postHeaders,
      encoding: postEncoding,
    );
    return DataModel.fromJson(jsonDecode(decoder.convert(response.bodyBytes)));
  }
}
