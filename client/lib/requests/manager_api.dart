import 'dart:convert';
import 'package:http/http.dart';
import 'package:client/public/file.dart';
import 'package:client/requests/base.dart';
import 'package:client/models/base.dart';
import 'package:client/models/base_list.dart';

class ManagerApi extends ResponseHelper {
  Future<BaseModel> test([
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
    return BaseModel.fromJson(jsonDecode(response.body));
  }

  Future<BaseModel> managerSignIn([
    String account = '',
    String password = '',
  ]) async {
    Response response = await post(
      Uri.http(url, '/Manager/Sign/In'),
      body: {
        'Account': account.trim(),
        'Password': password.trim(),
      },
      headers: postHeaders,
      encoding: postEncoding,
    );
    return BaseModel.fromJson(jsonDecode(response.body));
  }

  Future<BaseModel> managerSignOut() async {
    Response response = await post(
      Uri.http(url, '/Manager/Sign/Out'),
      body: {
        'Token': FileHelper().readFile('token').trim(),
      },
      headers: postHeaders,
      encoding: postEncoding,
    );
    return BaseModel.fromJson(jsonDecode(response.body));
  }

  Future<BaseModel> newManager({
    String account = '',
    String password = '',
    String name = '',
  }) async {
    Response response = await post(
      Uri.http(url, '/New/Manager'),
      body: {
        'Token': FileHelper().readFile('token'),
        'Account': account.trim(),
        'Password': password.trim(),
        'Name': name.trim(),
      },
      headers: postHeaders,
      encoding: postEncoding,
    );
    return BaseModel.fromJson(jsonDecode(response.body));
  }

  Future<BaseModel> managerDisabled({
    int id = 0,
  }) async {
    Response response = await post(
      Uri.http(url, '/Manager/Disabled'),
      body: {
        'Token': FileHelper().readFile('token').trim(),
        'ID': id.toString(),
      },
      headers: postHeaders,
      encoding: postEncoding,
    );
    return BaseModel.fromJson(jsonDecode(response.body));
  }

  Future<BaseModel> managerChangePassword({
    String newPassword = '',
    int id = 0,
  }) async {
    Response response = await post(
      Uri.http(url, '/Manager/Change/Password'),
      body: {
        'Token': FileHelper().readFile('token'),
        'NewPassword': newPassword.trim(),
        'ID': id.toString(),
      },
      headers: postHeaders,
      encoding: postEncoding,
    );
    return BaseModel.fromJson(jsonDecode(response.body));
  }

  Future<BaseModel> updateManagerInfo({
    String name = '',
    int permission = 0,
    int id = 0,
  }) async {
    Response response = await post(
      Uri.http(url, '/Update/Manager/Info'),
      body: {
        'Token': FileHelper().readFile('token').trim(),
        'Name': name.trim(),
        'Permission': permission.toString(),
        'ID': id.toString(),
      },
      headers: postHeaders,
      encoding: postEncoding,
    );
    return BaseModel.fromJson(jsonDecode(response.body));
  }

  Future<BaseListModel> managerList({
    int page = 1,
    int pageSize = 10,
    String stext = '',
    int state = 0,
    int permission = 0,
  }) async {
    Response response = await post(
      Uri.http(url, '/Manager/List'),
      body: {
        'Token': FileHelper().readFile('token').trim(),
        'Page': page.toString(),
        'PageSize': pageSize.toString(),
        'Stext': stext.trim(),
        'State': state.toString(),
        'Permission': permission.toString(),
      },
      headers: postHeaders,
      encoding: postEncoding,
    );
    return BaseListModel.fromJson(jsonDecode(response.body));
  }

  Future<BaseModel> managerInfo({
    int id = 0,
  }) async {
    Response response = await post(
      Uri.http(url, '/Manager/Info'),
      body: {
        'Token': FileHelper().readFile('token').trim(),
        'ID': id.toString(),
      },
      headers: postHeaders,
      encoding: postEncoding,
    );
    return BaseModel.fromJson(jsonDecode(response.body));
  }
}
