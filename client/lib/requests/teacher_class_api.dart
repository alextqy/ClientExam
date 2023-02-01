// ignore_for_file: file_names

import 'dart:convert';
import 'package:http/http.dart';
import 'package:client/public/file.dart';
import 'package:client/requests/base.dart';
import 'package:client/models/data.dart';
import 'package:client/models/data_list.dart';

class TeacherClassApi extends ResponseHelper {
  Future<DataModel> newTeacherClass({
    int teacherID = 0,
    int classID = 0,
  }) async {
    Response response = await post(
      Uri.http(url, '/New/Teacher/Class'),
      body: {
        'Token': FileHelper().readFile('token'),
        'TeacherID': teacherID.toString(),
        'ClassID': classID.toString(),
      },
      headers: postHeaders,
      encoding: postEncoding,
    );
    return DataModel.fromJson(jsonDecode(response.body));
  }

  Future<DataModel> deleteTeacherClass({
    int id = 0,
  }) async {
    Response response = await post(
      Uri.http(url, '/Delete/Teacher/Class'),
      body: {
        'Token': FileHelper().readFile('token'),
        'ID': id.toString(),
      },
      headers: postHeaders,
      encoding: postEncoding,
    );
    return DataModel.fromJson(jsonDecode(response.body));
  }

  Future<DataListModel> teacherClassList({
    int page = 1,
    int pageSize = 10,
    int teacherID = 0,
    int classID = 0,
  }) async {
    Response response = await post(
      Uri.http(url, '/Teacher/Class/List'),
      body: {
        'Token': FileHelper().readFile('token'),
        'Page': page.toString(),
        'PageSize': pageSize.toString(),
        'TeacherID': teacherID.toString(),
        'ClassID': classID.toString(),
      },
      headers: postHeaders,
      encoding: postEncoding,
    );
    return DataListModel.fromJson(jsonDecode(response.body));
  }

  Future<DataModel> teachers({
    int classID = 0,
  }) async {
    Response response = await post(
      Uri.http(url, '/Teachers'),
      body: {
        'Token': FileHelper().readFile('token'),
        'ClassID': classID.toString(),
      },
      headers: postHeaders,
      encoding: postEncoding,
    );
    return DataModel.fromJson(jsonDecode(response.body));
  }
}
