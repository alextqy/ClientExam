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
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/x-www-form-urlencoded",
      },
      encoding: Encoding.getByName("utf-8"),
    );
    return BaseModel.fromJson(jsonDecode(response.body));
  }
}
