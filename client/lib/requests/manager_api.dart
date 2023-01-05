import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:client/requests/base.dart';
import 'package:client/models/base.dart';

class ManagerApi extends ResponseHelper {
  Future<BaseModel> test([
    String param1 = '123',
    String param2 = '456',
    String param3 = '789',
  ]) async {
    var data = {
      'Param1': param1,
      'Param2': param2,
      'Param3': param3,
    };
    var response = await http.get(Uri.http(url, '/Test', data));
    return BaseModel.fromJson(jsonDecode(response.body));
  }

  Future<BaseModel> managerSignIn([
    String account = '',
    String password = '',
  ]) async {
    var response = await http.post(
      Uri.http(url, '/Manager/Sign/In'),
      body: {
        'Account': account,
        'Password': password,
      },
      headers: postHeaders,
      encoding: postEncoding,
    );
    return BaseModel.fromJson(jsonDecode(response.body));
  }

  Future<BaseModel> managerSignOut([
    String token = '',
  ]) async {
    var response = await http.post(
      Uri.http(url, '/Manager/Sign/Out'),
      body: {
        'Token': token,
      },
      headers: postHeaders,
      encoding: postEncoding,
    );
    return BaseModel.fromJson(jsonDecode(response.body));
  }

  Future<BaseModel> newManager([
    String token = '',
    String account = '',
    String password = '',
    String name = '',
  ]) async {
    var response = await http.post(
      Uri.http(url, '/New/Manager'),
      body: {
        'Token': token,
        'Account': account,
        'Password': password,
        'Name': name,
      },
      headers: postHeaders,
      encoding: postEncoding,
    );
    return BaseModel.fromJson(jsonDecode(response.body));
  }

  Future<BaseModel> managerDisabled([
    String token = '',
    int id = 0,
  ]) async {
    var response = await http.post(
      Uri.http(url, '/Manager/Disabled'),
      body: {
        'Token': token,
        'ID': id.toString(),
      },
      headers: postHeaders,
      encoding: postEncoding,
    );
    return BaseModel.fromJson(jsonDecode(response.body));
  }

  Future<BaseModel> managerChangePassword([
    String token = '',
    String newPassword = '',
    int id = 0,
  ]) async {
    var response = await http.post(
      Uri.http(url, '/Manager/Change/Password'),
      body: {
        'Token': token,
        'NewPassword': newPassword,
        'ID': id.toString(),
      },
      headers: postHeaders,
      encoding: postEncoding,
    );
    return BaseModel.fromJson(jsonDecode(response.body));
  }

  Future<BaseModel> updateManagerInfo([
    String token = '',
    String name = '',
    int permission = 0,
    int id = 0,
  ]) async {
    var response = await http.post(
      Uri.http(url, '/Update/Manager/Info'),
      body: {
        'Token': token,
        'Name': name,
        'Permission': permission.toString(),
        'ID': id.toString(),
      },
      headers: postHeaders,
      encoding: postEncoding,
    );
    return BaseModel.fromJson(jsonDecode(response.body));
  }

  Future<BaseModel> managerList([
    String token = '',
    int page = 1,
    int pageSize = 10,
    String stext = '',
    bool state = false,
    int permission = 0,
  ]) async {
    var response = await http.post(
      Uri.http(url, '/Manager/List'),
      body: {
        'Token': token,
        'Page': page.toString(),
        'PageSize': pageSize.toString(),
        'Stext': stext,
        'State': state,
        'Permission': permission.toString(),
      },
      headers: postHeaders,
      encoding: postEncoding,
    );
    return BaseModel.fromJson(jsonDecode(response.body));
  }

  Future<BaseModel> managerInfo([
    String token = '',
    int id = 0,
  ]) async {
    var response = await http.post(
      Uri.http(url, '/Manager/Info'),
      body: {
        'Token': token,
        'ID': id.toString(),
      },
      headers: postHeaders,
      encoding: postEncoding,
    );
    return BaseModel.fromJson(jsonDecode(response.body));
  }
}
