// ignore_for_file: file_names

import 'dart:convert';
import 'package:http/http.dart';
import 'package:client/public/file.dart';
import 'package:client/requests/base.dart';
import 'package:client/models/base.dart';
import 'package:client/models/base_list.dart';

class ExamInfoApi extends ResponseHelper {
  Future<BaseModel> newExamInfo({
    String subjectName = '',
    String examNo = '',
    int examineeID = 0,
    int examType = 0,
  }) async {
    Response response = await post(
      Uri.http(url, '/New/ExamInfo'),
      body: {
        'Token': FileHelper().readFile('token'),
        'SubjectName': subjectName,
        'ExamNo': examNo,
        'ExamineeID': examineeID.toString(),
        'ExamType': examType.toString(),
      },
      headers: postHeaders,
      encoding: postEncoding,
    );
    return BaseModel.fromJson(jsonDecode(response.body));
  }

  Future<BaseModel> examInfoDisabled({
    int id = 0,
  }) async {
    Response response = await post(
      Uri.http(url, '/ExamInfo/Disabled'),
      body: {
        'Token': FileHelper().readFile('token'),
        'ID': id.toString(),
      },
      headers: postHeaders,
      encoding: postEncoding,
    );
    return BaseModel.fromJson(jsonDecode(response.body));
  }

  Future<BaseListModel> examInfoList({
    int page = 1,
    int pageSize = 10,
    String stext = '',
    int examState = 0,
    int examType = 0,
    int pass = 0,
    int startState = 0,
    int suspendedState = 0,
  }) async {
    Response response = await post(
      Uri.http(url, '/ExamInfo/List'),
      body: {
        'Token': FileHelper().readFile('token'),
        'Page': page.toString(),
        'PageSize': pageSize.toString(),
        'Stext': stext,
        'ExamState': examState.toString(),
        'ExamType': examType.toString(),
        'Pass': pass.toString(),
        'StartState': startState.toString(),
        'SuspendedState': suspendedState.toString(),
      },
      headers: postHeaders,
      encoding: postEncoding,
    );
    return BaseListModel.fromJson(jsonDecode(response.body));
  }

  Future<BaseModel> examInfo({
    int id = 0,
  }) async {
    Response response = await post(
      Uri.http(url, '/ExamInfo'),
      body: {
        'Token': FileHelper().readFile('token'),
        'ID': id.toString(),
      },
      headers: postHeaders,
      encoding: postEncoding,
    );
    return BaseModel.fromJson(jsonDecode(response.body));
  }

  Future<BaseModel> generateTestPaper({
    int id = 0,
  }) async {
    Response response = await post(
      Uri.http(url, '/Generate/Test/Paper'),
      body: {
        'Token': FileHelper().readFile('token'),
        'ID': id.toString(),
      },
      headers: postHeaders,
      encoding: postEncoding,
    );
    return BaseModel.fromJson(jsonDecode(response.body));
  }

  Future<BaseModel> resetExamQuestionData({
    int id = 0,
  }) async {
    Response response = await post(
      Uri.http(url, '/Reset/Exam/Question/Data'),
      body: {
        'Token': FileHelper().readFile('token'),
        'ID': id.toString(),
      },
      headers: postHeaders,
      encoding: postEncoding,
    );
    return BaseModel.fromJson(jsonDecode(response.body));
  }

  Future<BaseModel> examIntoHistory({
    int id = 0,
  }) async {
    Response response = await post(
      Uri.http(url, '/Exam/Into/History'),
      body: {
        'Token': FileHelper().readFile('token'),
        'ID': id.toString(),
      },
      headers: postHeaders,
      encoding: postEncoding,
    );
    return BaseModel.fromJson(jsonDecode(response.body));
  }

  Future<BaseModel> gradeTheExam({
    int id = 0,
  }) async {
    Response response = await post(
      Uri.http(url, '/Grade/The/Exam'),
      body: {
        'Token': FileHelper().readFile('token'),
        'ID': id.toString(),
      },
      headers: postHeaders,
      encoding: postEncoding,
    );
    return BaseModel.fromJson(jsonDecode(response.body));
  }

  Future<BaseModel> importExamInfo({
    String excelFile = '',
  }) async {
    Response response = await post(
      Uri.http(url, '/Import/Exam/Info'),
      body: {
        'Token': FileHelper().readFile('token'),
        'ExcelFile': excelFile,
      },
      headers: postHeaders,
      encoding: postEncoding,
    );
    return BaseModel.fromJson(jsonDecode(response.body));
  }

  Future<BaseModel> downloadExamInfoDemo() async {
    Response response = await post(
      Uri.http(url, '/Download/Exam/Info/Demo'),
      body: {
        'Token': FileHelper().readFile('token'),
      },
      headers: postHeaders,
      encoding: postEncoding,
    );
    return BaseModel.fromJson(jsonDecode(response.body));
  }
}
