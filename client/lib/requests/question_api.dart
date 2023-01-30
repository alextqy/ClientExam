// ignore_for_file: file_names

import 'dart:convert';
import 'package:http/http.dart';
import 'package:client/public/file.dart';
import 'package:client/requests/base.dart';
import 'package:client/models/base.dart';
import 'package:client/models/base_list.dart';

class QuestionApi extends ResponseHelper {
  Future<BaseModel> newQuestion({
    String questionTitle = '',
    int questionType = 0,
    int knowledgeID = 0,
    String description = '',
    String language = '',
    String languageVersion = '',
  }) async {
    Response response = await post(
      Uri.http(url, '/New/Question'),
      body: {
        'Token': FileHelper().readFile('token'),
        'QuestionTitle': questionTitle,
        'QuestionType': questionType.toString(),
        'KnowledgeID': knowledgeID.toString(),
        'Description': description,
        'Language': language,
        'LanguageVersion': languageVersion,
      },
      headers: postHeaders,
      encoding: postEncoding,
    );
    return BaseModel.fromJson(jsonDecode(response.body));
  }

  // multipart/form-data
  Future<bool> questionAttachment({
    int id = 0,
    String filePath = '',
  }) async {
    return upload(
      url: url,
      uri: '/Question/Attachment',
      filePath: filePath,
      attachment: 'Attachment',
    );
  }

  Future<BaseModel> questionViewAttachments({
    String filePath = '',
  }) async {
    Response response = await post(
      Uri.http(url, '/Question/View/Attachments'),
      body: {
        'Token': FileHelper().readFile('token'),
        'FilePath': filePath,
      },
      headers: postHeaders,
      encoding: postEncoding,
    );
    return BaseModel.fromJson(jsonDecode(response.body));
  }

  Future<BaseModel> questionDisabled({
    int id = 0,
  }) async {
    Response response = await post(
      Uri.http(url, '/Question/Disabled'),
      body: {
        'Token': FileHelper().readFile('token'),
        'ID': id.toString(),
      },
      headers: postHeaders,
      encoding: postEncoding,
    );
    return BaseModel.fromJson(jsonDecode(response.body));
  }

  Future<BaseModel> updateQuestionInfo({
    int id = 0,
    String questionTitle = '',
    int questionType = 0,
    String description = '',
    String language = '',
    String languageVersion = '',
  }) async {
    Response response = await post(
      Uri.http(url, '/Update/Question/Info'),
      body: {
        'Token': FileHelper().readFile('token'),
        'ID': id.toString(),
        'QuestionTitle': questionTitle,
        'QuestionType': questionType.toString(),
        'Description': description,
        'Language': language,
        'LanguageVersion': languageVersion,
      },
      headers: postHeaders,
      encoding: postEncoding,
    );
    return BaseModel.fromJson(jsonDecode(response.body));
  }

  Future<BaseListModel> questionList({
    int page = 1,
    int pageSize = 10,
    String stext = '',
    int questionType = 0,
    int questionState = 0,
    int knowledgeID = 0,
  }) async {
    Response response = await post(
      Uri.http(url, '/Question/List'),
      body: {
        'Token': FileHelper().readFile('token'),
        'Page': page.toString(),
        'PageSize': pageSize.toString(),
        'Stext': stext,
        'QuestionType': questionType.toString(),
        'QuestionState': questionState.toString(),
        'knowledgeID': knowledgeID.toString(),
      },
      headers: postHeaders,
      encoding: postEncoding,
    );
    return BaseListModel.fromJson(jsonDecode(response.body));
  }

  Future<BaseModel> questionInfo({
    int id = 0,
  }) async {
    Response response = await post(
      Uri.http(url, '/Question/Info'),
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
