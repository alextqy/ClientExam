// ignore_for_file: file_names

import 'dart:convert';
import 'package:http/http.dart';
import 'package:client/public/file.dart';
import 'package:client/requests/base.dart';
import 'package:client/models/base.dart';
import 'package:client/models/base_list.dart';

class KnowledgeApi extends ResponseHelper {
  Future<BaseModel> newKnowledge({
    String knowledgeName = '',
    int subjectID = 0,
  }) async {
    Response response = await post(
      Uri.http(url, '/New/Knowledge'),
      body: {
        'Token': FileHelper().readFile('token'),
        'KnowledgeName': knowledgeName,
        'SubjectID': subjectID.toString(),
      },
      headers: postHeaders,
      encoding: postEncoding,
    );
    return BaseModel.fromJson(jsonDecode(response.body));
  }

  Future<BaseModel> knowledgeDisabled({
    int id = 0,
  }) async {
    Response response = await post(
      Uri.http(url, '/Knowledge/Disabled'),
      body: {
        'Token': FileHelper().readFile('token'),
        'ID': id.toString(),
      },
      headers: postHeaders,
      encoding: postEncoding,
    );
    return BaseModel.fromJson(jsonDecode(response.body));
  }

  Future<BaseModel> updateKnowledgeInfo({
    int id = 0,
    String knowledgeName = '',
  }) async {
    Response response = await post(
      Uri.http(url, '/Update/Knowledge/Info'),
      body: {
        'Token': FileHelper().readFile('token'),
        'ID': id.toString(),
        'KnowledgeName': knowledgeName,
      },
      headers: postHeaders,
      encoding: postEncoding,
    );
    return BaseModel.fromJson(jsonDecode(response.body));
  }

  Future<BaseListModel> knowledgeList({
    int page = 1,
    int pageSize = 10,
    String stext = '',
    int subjectID = 0,
    int knowledgeState = 0,
  }) async {
    Response response = await post(
      Uri.http(url, '/Knowledge/List'),
      body: {
        'Token': FileHelper().readFile('token'),
        'Page': page.toString(),
        'PageSize': pageSize.toString(),
        'Stext': stext,
        'SubjectID': subjectID.toString(),
        'KnowledgeState': knowledgeState.toString(),
      },
      headers: postHeaders,
      encoding: postEncoding,
    );
    return BaseListModel.fromJson(jsonDecode(response.body));
  }

  Future<BaseModel> knowledgeInfo({
    int id = 0,
  }) async {
    Response response = await post(
      Uri.http(url, '/Knowledge/Info'),
      body: {
        'Token': FileHelper().readFile('token'),
        'ID': id.toString(),
      },
      headers: postHeaders,
      encoding: postEncoding,
    );
    return BaseModel.fromJson(jsonDecode(response.body));
  }

  Future<BaseModel> knowledge({
    int subjectID = 0,
  }) async {
    Response response = await post(
      Uri.http(url, '/Knowledge'),
      body: {
        'Token': FileHelper().readFile('token'),
        'SubjectID': subjectID.toString(),
      },
      headers: postHeaders,
      encoding: postEncoding,
    );
    return BaseModel.fromJson(jsonDecode(response.body));
  }
}
