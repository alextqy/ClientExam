// ignore_for_file: file_names

import 'dart:convert';
import 'package:http/http.dart';
import 'package:client/public/file.dart';
import 'package:client/requests/base.dart';
import 'package:client/models/data.dart';
import 'package:client/models/data_list.dart';

class ManagerApi extends ResponseHelper {
  Future<DataModel> test([
    String param1 = '123',
    String param2 = '456',
    String param3 = '789',
  ]) async {
    Map<String, String> data = {
      'Param1': param1,
      'Param2': param2,
      'Param3': param3,
    };
    Response response = await get(Uri.http(url, '/Test', data));
    return DataModel.fromJson(jsonDecode(decoder.convert(response.bodyBytes)));
  }

  Future<DataModel> managerSignIn([
    String account = '',
    String password = '',
  ]) async {
    Response response = await post(
      Uri.http(url, '/Manager/Sign/In'),
      body: {
        'Account': account,
        'Password': password,
      },
      headers: postHeaders,
      encoding: postEncoding,
    );
    return DataModel.fromJson(jsonDecode(decoder.convert(response.bodyBytes)));
  }

  Future<DataModel> managerSignOut() async {
    Response response = await post(
      Uri.http(url, '/Manager/Sign/Out'),
      body: {
        'Token': FileHelper().readFile('token'),
      },
      headers: postHeaders,
      encoding: postEncoding,
    );
    return DataModel.fromJson(jsonDecode(decoder.convert(response.bodyBytes)));
  }

  Future<DataModel> newManager({
    String account = '',
    String password = '',
    String name = '',
  }) async {
    Response response = await post(
      Uri.http(url, '/New/Manager'),
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

  Future<DataModel> managerDisabled({
    int id = 0,
  }) async {
    Response response = await post(
      Uri.http(url, '/Manager/Disabled'),
      body: {
        'Token': FileHelper().readFile('token'),
        'ID': id.toString(),
      },
      headers: postHeaders,
      encoding: postEncoding,
    );
    return DataModel.fromJson(jsonDecode(decoder.convert(response.bodyBytes)));
  }

  Future<DataModel> managerChangePassword({
    String newPassword = '',
    int id = 0,
  }) async {
    Response response = await post(
      Uri.http(url, '/Manager/Change/Password'),
      body: {
        'Token': FileHelper().readFile('token'),
        'NewPassword': newPassword,
        'ID': id.toString(),
      },
      headers: postHeaders,
      encoding: postEncoding,
    );
    return DataModel.fromJson(jsonDecode(decoder.convert(response.bodyBytes)));
  }

  Future<DataModel> updateManagerInfo({
    String name = '',
    int permission = 0,
    int id = 0,
  }) async {
    Response response = await post(
      Uri.http(url, '/Update/Manager/Info'),
      body: {
        'Token': FileHelper().readFile('token'),
        'Name': name,
        'Permission': permission.toString(),
        'ID': id.toString(),
      },
      headers: postHeaders,
      encoding: postEncoding,
    );
    return DataModel.fromJson(jsonDecode(decoder.convert(response.bodyBytes)));
  }

  Future<DataListModel> managerList({
    int page = 1,
    int pageSize = 10,
    String stext = '',
    int state = 0,
    int permission = 0,
  }) async {
    Response response = await post(
      Uri.http(url, '/Manager/List'),
      body: {
        'Token': FileHelper().readFile('token'),
        'Page': page.toString(),
        'PageSize': pageSize.toString(),
        'Stext': stext,
        'State': state.toString(),
        'Permission': permission.toString(),
      },
      headers: postHeaders,
      encoding: postEncoding,
    );
    return DataListModel.fromJson(jsonDecode(response.body));
  }

  Future<DataModel> managerInfo({
    int id = 0,
  }) async {
    Response response = await post(
      Uri.http(url, '/Manager/Info'),
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
