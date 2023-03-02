// ignore_for_file: file_names

import 'dart:convert';
import 'package:http/http.dart';
import 'package:client/public/file.dart';
import 'package:client/requests/base.dart';
import 'package:client/models/data.dart';
import 'package:client/models/data_list.dart';

class QuestionSolutionApi extends ResponseHelper {
  Future<DataModel> newQuestionSolution({
    int questionID = 0,
    String option = '',
    int correctAnswer = 0,
    String correctItem = '',
    double scoreRatio = 0,
    int position = 0,
  }) async {
    Response response = await post(
      Uri.http(url, '/New/Question/Solution'),
      body: {
        'Token': FileHelper().readFile('token'),
        'QuestionID': questionID.toString(),
        'Option': option,
        'CorrectAnswer': correctAnswer.toString(),
        'CorrectItem': correctItem,
        'ScoreRatio': scoreRatio.toString(),
        'Position': position.toString(),
      },
      headers: postHeaders,
      encoding: postEncoding,
    );
    return DataModel.fromJson(jsonDecode(decoder.convert(response.bodyBytes)));
  }

  // multipart/form-data
  Future<DataModel> questionSolutionAttachment({
    int id = 0,
    String filePath = '',
    String contentType = '',
  }) async {
    return upload(
      id: id,
      url: url,
      uri: '/Question/Solution/Attachment',
      filePath: filePath,
      attachment: 'Attachment',
      contentType: contentType,
    );
  }

  Future<DataModel> questionSolutionDelete({
    int id = 0,
  }) async {
    Response response = await post(
      Uri.http(url, '/Question/Solution/Delete'),
      body: {
        'Token': FileHelper().readFile('token'),
        'ID': id.toString(),
      },
      headers: postHeaders,
      encoding: postEncoding,
    );
    return DataModel.fromJson(jsonDecode(decoder.convert(response.bodyBytes)));
  }

  Future<DataListModel> questionSolutionList({
    int page = 1,
    int pageSize = 10,
    int questionID = 0,
  }) async {
    Response response = await post(
      Uri.http(url, '/Question/Solution/List'),
      body: {
        'Token': FileHelper().readFile('token'),
        'Page': page.toString(),
        'PageSize': pageSize.toString(),
        'QuestionID': questionID.toString(),
      },
      headers: postHeaders,
      encoding: postEncoding,
    );
    return DataListModel.fromJson(
        jsonDecode(decoder.convert(response.bodyBytes)));
  }

  Future<DataModel> questionSolutions({
    int questionID = 0,
    int position = 0,
  }) async {
    Response response = await post(
      Uri.http(url, '/Question/Solutions'),
      body: {
        'Token': FileHelper().readFile('token'),
        'QuestionID': questionID.toString(),
        'Position': position.toString(),
      },
      headers: postHeaders,
      encoding: postEncoding,
    );
    return DataModel.fromJson(jsonDecode(decoder.convert(response.bodyBytes)));
  }

  Future<DataModel> questionSolutionViewAttachments({
    String filePath = '',
  }) async {
    Response response = await post(
      Uri.http(url, '/Question/Solution/View/Attachments'),
      body: {
        'Token': FileHelper().readFile('token'),
        'FilePath': filePath,
      },
      headers: postHeaders,
      encoding: postEncoding,
    );
    return DataModel.fromJson(jsonDecode(decoder.convert(response.bodyBytes)));
  }

  Future<DataModel> setScoreRatio({
    int id = 0,
    double scoreRatio = 0,
  }) async {
    Response response = await post(
      Uri.http(url, '/Set/Score/Ratio'),
      body: {
        'Token': FileHelper().readFile('token'),
        'ID': id.toString(),
        'ScoreRatio': scoreRatio.toString(),
      },
      headers: postHeaders,
      encoding: postEncoding,
    );
    return DataModel.fromJson(jsonDecode(decoder.convert(response.bodyBytes)));
  }
}
