// ignore_for_file: file_names

import 'dart:convert';
import 'package:http/http.dart';
import 'package:client/public/file.dart';
import 'package:client/requests/base.dart';
import 'package:client/models/data.dart';
import 'package:client/models/data_list.dart';

class ExamineeApi extends ResponseHelper {
  Future<DataModel> newExaminee({
    String examineeNo = '',
    String name = '',
    int classID = 0,
    String contact = '',
  }) async {
    Response response = await post(
      Uri.http(url, '/New/Examinee'),
      body: {
        'Token': FileHelper().readFile('token'),
        'ExamineeNo': examineeNo,
        'Name': name,
        'ClassID': classID.toString(),
        'Contact': contact,
      },
      headers: postHeaders,
      encoding: postEncoding,
    );
    return DataModel.fromJson(jsonDecode(response.body));
  }

  Future<DataModel> updateExaminee({
    int id = 0,
    String name = '',
    String contact = '',
  }) async {
    Response response = await post(
      Uri.http(url, '/Update/Examinee'),
      body: {
        'Token': FileHelper().readFile('token'),
        'ID': id.toString(),
        'Name': name,
        'Contact': contact,
      },
      headers: postHeaders,
      encoding: postEncoding,
    );
    return DataModel.fromJson(jsonDecode(response.body));
  }

  Future<DataListModel> examineeList({
    int page = 1,
    int pageSize = 10,
    String stext = '',
    int classID = 0,
  }) async {
    Response response = await post(
      Uri.http(url, '/Examinee/List'),
      body: {
        'Token': FileHelper().readFile('token'),
        'Page': page.toString(),
        'PageSize': pageSize.toString(),
        'Stext': stext,
        'ClassID': classID.toString(),
      },
      headers: postHeaders,
      encoding: postEncoding,
    );
    return DataListModel.fromJson(jsonDecode(response.body));
  }

  Future<DataModel> examineeInfo({
    int id = 0,
  }) async {
    Response response = await post(
      Uri.http(url, '/Examinee/Info'),
      body: {
        'Token': FileHelper().readFile('token'),
        'ID': id.toString(),
      },
      headers: postHeaders,
      encoding: postEncoding,
    );
    return DataModel.fromJson(jsonDecode(response.body));
  }

  Future<DataModel> examinees() async {
    Response response = await post(
      Uri.http(url, '/Examinees'),
      body: {
        'Token': FileHelper().readFile('token'),
      },
      headers: postHeaders,
      encoding: postEncoding,
    );
    return DataModel.fromJson(jsonDecode(response.body));
  }
}
