// ignore_for_file: file_names

import 'dart:convert';
import 'package:http/http.dart';
import 'package:client/public/file.dart';
import 'package:client/requests/base.dart';
import 'package:client/models/base.dart';
import 'package:client/models/base_list.dart';

class ExamineeTokenApi extends ResponseHelper {
  Future<BaseModel> signInStudentID({
    String account = '',
  }) async {
    Response response = await post(
      Uri.http(url, '/Sign/In/Student/ID'),
      body: {
        'Account': account,
      },
      headers: postHeaders,
      encoding: postEncoding,
    );
    return BaseModel.fromJson(jsonDecode(response.body));
  }

  Future<BaseModel> signInAdmissionTicket({
    String examNo = '',
  }) async {
    Response response = await post(
      Uri.http(url, '/Sign/In/Admission/Ticket'),
      body: {
        'ExamNo': examNo,
      },
      headers: postHeaders,
      encoding: postEncoding,
    );
    return BaseModel.fromJson(jsonDecode(response.body));
  }

  Future<BaseListModel> examScantronList() async {
    Response response = await post(
      Uri.http(url, '/Exam/Scantron/List'),
      body: {
        'Token': FileHelper().readFile('token'),
      },
      headers: postHeaders,
      encoding: postEncoding,
    );
    return BaseListModel.fromJson(jsonDecode(response.body));
  }

  Future<BaseModel> examScantronSolutionInfo({
    int id = 0,
  }) async {
    Response response = await post(
      Uri.http(url, '/Exam/Scantron/Solution/Info'),
      body: {
        'Token': FileHelper().readFile('token'),
        'ID': id.toString(),
      },
      headers: postHeaders,
      encoding: postEncoding,
    );
    return BaseModel.fromJson(jsonDecode(response.body));
  }

  Future<BaseModel> examAnswer({
    int scantronID = 0,
    int id = 0,
    String answer = '',
  }) async {
    Response response = await post(
      Uri.http(url, '/Exam/Answer'),
      body: {
        'Token': FileHelper().readFile('token'),
        'ScantronID': scantronID.toString(),
        'ID': id.toString(),
        'Answer': answer,
      },
      headers: postHeaders,
      encoding: postEncoding,
    );
    return BaseModel.fromJson(jsonDecode(response.body));
  }

  Future<BaseModel> endTheExam() async {
    Response response = await post(
      Uri.http(url, '/End/The/Exam'),
      body: {
        'Token': FileHelper().readFile('token'),
      },
      headers: postHeaders,
      encoding: postEncoding,
    );
    return BaseModel.fromJson(jsonDecode(response.body));
  }
}
