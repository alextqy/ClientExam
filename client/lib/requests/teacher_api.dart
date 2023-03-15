// ignore_for_file: file_names

import 'dart:convert';
import 'package:http/http.dart';
import 'package:client/public/file.dart';
import 'package:client/requests/base.dart';
import 'package:client/models/data.dart';
import 'package:client/models/data_list.dart';

class TeacherApi extends ResponseHelper {
  Future<DataModel> newTeacher({
    String account = '',
    String password = '',
    String name = '',
  }) async {
    Response response = await post(
      Uri.http(url, '/New/Teacher'),
      body: {
        'Token': FileHelper().readFile('token'),
        'Account': account,
        'Password': password,
        'Name': name,
      },
      headers: postHeaders,
      encoding: postEncoding,
    );
    return DataModel.fromJson(jsonDecode(decoder.convert(response.bodyBytes)));
  }

  Future<DataModel> teacherDisabled({
    int id = 0,
  }) async {
    Response response = await post(
      Uri.http(url, '/Teacher/Disabled'),
      body: {
        'Token': FileHelper().readFile('token'),
        'ID': id.toString(),
      },
      headers: postHeaders,
      encoding: postEncoding,
    );
    return DataModel.fromJson(jsonDecode(decoder.convert(response.bodyBytes)));
  }

  Future<DataModel> updateTeacherInfo({
    String password = '',
    String name = '',
    int id = 0,
  }) async {
    Response response = await post(
      Uri.http(url, '/Update/Teacher/Info'),
      body: {
        'Token': FileHelper().readFile('token'),
        'Password': password,
        'Name': name,
        'ID': id.toString(),
      },
      headers: postHeaders,
      encoding: postEncoding,
    );
    return DataModel.fromJson(jsonDecode(decoder.convert(response.bodyBytes)));
  }

  Future<DataListModel> teacherList({
    int page = 1,
    int pageSize = 10,
    String stext = '',
    int state = 0,
  }) async {
    Response response = await post(
      Uri.http(url, '/Teacher/List'),
      body: {
        'Token': FileHelper().readFile('token'),
        'Page': page.toString(),
        'PageSize': pageSize.toString(),
        'Stext': stext,
        'State': state.toString(),
      },
      headers: postHeaders,
      encoding: postEncoding,
    );
    return DataListModel.fromJson(jsonDecode(decoder.convert(response.bodyBytes)));
  }

  Future<DataModel> teacherInfo({
    int id = 0,
  }) async {
    Response response = await post(
      Uri.http(url, '/Teacher/Info'),
      body: {
        'Token': FileHelper().readFile('token'),
        'ID': id.toString(),
      },
      headers: postHeaders,
      encoding: postEncoding,
    );
    return DataModel.fromJson(jsonDecode(decoder.convert(response.bodyBytes)));
  }

  Future<DataModel> teachers() async {
    Response response = await post(
      Uri.http(url, '/Teachers'),
      body: {
        'Token': FileHelper().readFile('token'),
      },
      headers: postHeaders,
      encoding: postEncoding,
    );
    return DataModel.fromJson(jsonDecode(decoder.convert(response.bodyBytes)));
  }

  Future<DataModel> teacherSignIn({
    String account = '',
    String password = '',
  }) async {
    Response response = await post(
      Uri.http(url, '/Teacher/Sign/In'),
      body: {
        'Account': account,
        'Password': password,
      },
      headers: postHeaders,
      encoding: postEncoding,
    );
    return DataModel.fromJson(jsonDecode(decoder.convert(response.bodyBytes)));
  }

  Future<DataModel> teacherSignOut() async {
    Response response = await post(
      Uri.http(url, '/Teacher/Sign/Out'),
      body: {
        'Token': FileHelper().readFile('token'),
      },
      headers: postHeaders,
      encoding: postEncoding,
    );
    return DataModel.fromJson(jsonDecode(decoder.convert(response.bodyBytes)));
  }

  Future<DataModel> checkTeacherInfo() async {
    Response response = await post(
      Uri.http(url, '/Check/Teacher/Info'),
      body: {
        'Token': FileHelper().readFile('token'),
      },
      headers: postHeaders,
      encoding: postEncoding,
    );
    return DataModel.fromJson(jsonDecode(decoder.convert(response.bodyBytes)));
  }

  Future<DataModel> teacherUpdate({
    String name = '',
  }) async {
    Response response = await post(
      Uri.http(url, '/Teacher/Update'),
      body: {
        'Token': FileHelper().readFile('token'),
        'Name': name,
      },
      headers: postHeaders,
      encoding: postEncoding,
    );
    return DataModel.fromJson(jsonDecode(decoder.convert(response.bodyBytes)));
  }

  Future<DataModel> teacherChangePassword({
    String newPassword = '',
  }) async {
    Response response = await post(
      Uri.http(url, '/Teacher/Change/Password'),
      body: {
        'Token': FileHelper().readFile('token'),
        'NewPassword': newPassword,
      },
      headers: postHeaders,
      encoding: postEncoding,
    );
    return DataModel.fromJson(jsonDecode(decoder.convert(response.bodyBytes)));
  }
}
