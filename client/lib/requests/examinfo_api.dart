// ignore_for_file: file_names

import 'dart:convert';
import 'package:http/http.dart';
import 'package:client/public/file.dart';
import 'package:client/requests/base.dart';
import 'package:client/models/data.dart';
import 'package:client/models/data_list.dart';

class ExamInfoApi extends ResponseHelper {
  Future<DataModel> newExamInfo({
    String subjectName = '',
    String examNo = '',
    String examineeNo = '',
    int examType = 0,
  }) async {
    Response response = await post(
      Uri.http(url, '/New/ExamInfo'),
      body: {
        'Token': FileHelper().readFile('token'),
        'SubjectName': subjectName,
        'ExamNo': examNo,
        'ExamineeNo': examineeNo.toString(),
        'ExamType': examType.toString(),
      },
      headers: postHeaders,
      encoding: postEncoding,
    );
    return DataModel.fromJson(jsonDecode(decoder.convert(response.bodyBytes)));
  }

  Future<DataModel> examInfoDisabled({
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
    return DataModel.fromJson(jsonDecode(decoder.convert(response.bodyBytes)));
  }

  Future<DataListModel> examInfoList({
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
    return DataListModel.fromJson(
        jsonDecode(decoder.convert(response.bodyBytes)));
  }

  Future<DataModel> examInfo({
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
    return DataModel.fromJson(jsonDecode(decoder.convert(response.bodyBytes)));
  }

  Future<DataModel> generateTestPaper({
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
    return DataModel.fromJson(jsonDecode(decoder.convert(response.bodyBytes)));
  }

  Future<DataModel> resetExamQuestionData({
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
    return DataModel.fromJson(jsonDecode(decoder.convert(response.bodyBytes)));
  }

  Future<DataModel> examIntoHistory({
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
    return DataModel.fromJson(jsonDecode(decoder.convert(response.bodyBytes)));
  }

  Future<DataModel> gradeTheExam({
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
    return DataModel.fromJson(jsonDecode(decoder.convert(response.bodyBytes)));
  }

  // multipart/form-data
  Future<bool> importExamInfo({
    String filePath = '',
  }) async {
    return upload(
      url: url,
      uri: '/Import/Exam/Info',
      filePath: filePath,
      excelFile: 'ExcelFile',
    );
  }

  Future<DataModel> downloadExamInfoDemo() async {
    Response response = await post(
      Uri.http(url, '/Download/Exam/Info/Demo'),
      body: {
        'Token': FileHelper().readFile('token'),
      },
      headers: postHeaders,
      encoding: postEncoding,
    );
    return DataModel.fromJson(jsonDecode(decoder.convert(response.bodyBytes)));
  }

  Future<DataModel> examInfoSuspend({int id = 0}) async {
    Response response = await post(
      Uri.http(url, '/ExamInfo/Suspend'),
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
