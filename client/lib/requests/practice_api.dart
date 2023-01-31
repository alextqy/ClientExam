// ignore_for_file: file_names

import 'dart:convert';
import 'package:http/http.dart';
import 'package:client/public/file.dart';
import 'package:client/requests/base.dart';
import 'package:client/models/data.dart';

class PracticeApi extends ResponseHelper {
  Future<DataModel> signInPractice({
    String examineeNo = '',
  }) async {
    Response response = await post(
      Uri.http(url, '/Sign/In/Practice'),
      body: {
        'ExamineeNo': examineeNo,
      },
      headers: postHeaders,
      encoding: postEncoding,
    );
    return DataModel.fromJson(jsonDecode(response.body));
  }

  Future<DataModel> newPractice({
    int questionType = 0,
  }) async {
    Response response = await post(
      Uri.http(url, '/New/Practice'),
      body: {
        'Token': FileHelper().readFile('token'),
        'QuestionType': questionType.toString(),
      },
      headers: postHeaders,
      encoding: postEncoding,
    );
    return DataModel.fromJson(jsonDecode(response.body));
  }

  Future<DataModel> practiceInfo({
    int id = 0,
  }) async {
    Response response = await post(
      Uri.http(url, '/Practice/Info'),
      body: {
        'Token': FileHelper().readFile('token'),
        'ID': id.toString(),
      },
      headers: postHeaders,
      encoding: postEncoding,
    );
    return DataModel.fromJson(jsonDecode(response.body));
  }

  Future<DataModel> practiceAnswer({
    int practiceID = 0,
    int id = 0,
    String answer = '',
  }) async {
    Response response = await post(
      Uri.http(url, '/Practice/Answer'),
      body: {
        'Token': FileHelper().readFile('token'),
        'PracticeID': practiceID.toString(),
        'ID': id.toString(),
        'Answer': answer,
      },
      headers: postHeaders,
      encoding: postEncoding,
    );
    return DataModel.fromJson(jsonDecode(response.body));
  }

  Future<DataModel> gradeThePractice({
    int id = 0,
  }) async {
    Response response = await post(
      Uri.http(url, '/Grade/The/Practice'),
      body: {
        'Token': FileHelper().readFile('token'),
        'ID': id.toString(),
      },
      headers: postHeaders,
      encoding: postEncoding,
    );
    return DataModel.fromJson(jsonDecode(response.body));
  }

  Future<DataModel> practiceDelete({
    int id = 0,
  }) async {
    Response response = await post(
      Uri.http(url, '/Practice/Delete'),
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
