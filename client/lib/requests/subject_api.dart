// ignore_for_file: file_names

import 'dart:convert';
import 'package:http/http.dart';
import 'package:client/public/file.dart';
import 'package:client/requests/base.dart';
import 'package:client/models/data.dart';
import 'package:client/models/data_list.dart';

class SubjectApi extends ResponseHelper {
  Future<DataModel> newSubject({
    String subjectName = '',
  }) async {
    Response response = await post(
      Uri.http(url, '/New/Subject'),
      body: {
        'Token': FileHelper().readFile('token'),
        'SubjectName': subjectName,
      },
      headers: postHeaders,
      encoding: postEncoding,
    );
    return DataModel.fromJson(jsonDecode(decoder.convert(response.bodyBytes)));
  }

  Future<DataModel> subjectDisabled({
    int id = 0,
  }) async {
    Response response = await post(
      Uri.http(url, '/Subject/Disabled'),
      body: {
        'Token': FileHelper().readFile('token'),
        'ID': id.toString(),
      },
      headers: postHeaders,
      encoding: postEncoding,
    );
    return DataModel.fromJson(jsonDecode(decoder.convert(response.bodyBytes)));
  }

  Future<DataModel> updateSubjectInfo({
    int id = 0,
    String subjectName = '',
  }) async {
    Response response = await post(
      Uri.http(url, '/Update/Subject/Info'),
      body: {
        'Token': FileHelper().readFile('token'),
        'ID': id.toString(),
        'SubjectName': subjectName,
      },
      headers: postHeaders,
      encoding: postEncoding,
    );
    return DataModel.fromJson(jsonDecode(decoder.convert(response.bodyBytes)));
  }

  Future<DataListModel> subjectList({
    int page = 1,
    int pageSize = 10,
    String stext = '',
    int subjectState = 0,
  }) async {
    Response response = await post(
      Uri.http(url, '/Subject/List'),
      body: {
        'Token': FileHelper().readFile('token'),
        'Page': page.toString(),
        'PageSize': pageSize.toString(),
        'Stext': stext,
        'SubjectState': subjectState.toString(),
      },
      headers: postHeaders,
      encoding: postEncoding,
    );
    return DataListModel.fromJson(
        jsonDecode(decoder.convert(response.bodyBytes)));
  }

  Future<DataModel> subjectInfo({
    int id = 0,
  }) async {
    Response response = await post(
      Uri.http(url, '/Subject/Info'),
      body: {
        'Token': FileHelper().readFile('token'),
        'ID': id.toString(),
      },
      headers: postHeaders,
      encoding: postEncoding,
    );
    return DataModel.fromJson(jsonDecode(decoder.convert(response.bodyBytes)));
  }

  Future<DataModel> subjects() async {
    Response response = await post(
      Uri.http(url, '/Subjects'),
      body: {
        'Token': FileHelper().readFile('token'),
      },
      headers: postHeaders,
      encoding: postEncoding,
    );
    return DataModel.fromJson(jsonDecode(decoder.convert(response.bodyBytes)));
  }
}
