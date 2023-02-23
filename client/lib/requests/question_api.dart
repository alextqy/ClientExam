// ignore_for_file: file_names

import 'dart:convert';
import 'package:http/http.dart';
import 'package:client/public/file.dart';
import 'package:client/requests/base.dart';
import 'package:client/models/data.dart';
import 'package:client/models/data_list.dart';

class QuestionApi extends ResponseHelper {
  Future<DataModel> newQuestion({
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
    return DataModel.fromJson(jsonDecode(decoder.convert(response.bodyBytes)));
  }

  // multipart/form-data
  Future<DataModel> questionAttachment({
    int id = 0,
    String filePath = '',
    String contentType = '',
  }) async {
    return upload(
      id: id,
      url: url,
      uri: '/Question/Attachment',
      filePath: filePath,
      attachment: 'Attachment',
      contentType: contentType,
    );
  }

  Future<DataModel> questionViewAttachments({
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
    return DataModel.fromJson(jsonDecode(decoder.convert(response.bodyBytes)));
  }

  Future<DataModel> questionDisabled({
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
    return DataModel.fromJson(jsonDecode(decoder.convert(response.bodyBytes)));
  }

  Future<DataModel> updateQuestionInfo({
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
    return DataModel.fromJson(jsonDecode(decoder.convert(response.bodyBytes)));
  }

  Future<DataListModel> questionList({
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
        'KnowledgeID': knowledgeID.toString(),
      },
      headers: postHeaders,
      encoding: postEncoding,
    );
    return DataListModel.fromJson(
        jsonDecode(decoder.convert(response.bodyBytes)));
  }

  Future<DataModel> questionInfo({
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
    return DataModel.fromJson(jsonDecode(decoder.convert(response.bodyBytes)));
  }
}
