import 'dart:convert';
import 'package:http/http.dart';
import 'package:client/public/file.dart';
import 'package:client/requests/base.dart';
import 'package:client/models/base.dart';
import 'package:client/models/base_list.dart';

class ClassApi extends ResponseHelper {
  Future<BaseModel> newClass({
    String className = '',
    String description = '',
  }) async {
    Response response = await post(
      Uri.http(url, '/New/Class'),
      body: {
        'Token': FileHelper().readFile('token'),
        'ClassName': className.trim(),
        'Description': description.trim(),
      },
      headers: postHeaders,
      encoding: postEncoding,
    );
    return BaseModel.fromJson(jsonDecode(response.body));
  }

  Future<BaseModel> updateClassInfo({
    int id = 0,
    String className = '',
    String description = '',
  }) async {
    Response response = await post(
      Uri.http(url, '/Update/Class/Info'),
      body: {
        'Token': FileHelper().readFile('token'),
        'id': id.toString(),
        'ClassName': className.trim(),
        'Description': description.trim(),
      },
      headers: postHeaders,
      encoding: postEncoding,
    );
    return BaseModel.fromJson(jsonDecode(response.body));
  }

  Future<BaseListModel> classList({
    int page = 0,
    int pageSize = 10,
    String stext = '',
  }) async {
    Response response = await post(
      Uri.http(url, '/Class/List'),
      body: {
        'Token': FileHelper().readFile('token'),
        'Page': page.toString(),
        'PageSize': pageSize.toString(),
        'Stext': stext.trim(),
      },
      headers: postHeaders,
      encoding: postEncoding,
    );
    return BaseListModel.fromJson(jsonDecode(response.body));
  }

  Future<BaseModel> classInfo({
    int id = 0,
  }) async {
    Response response = await post(
      Uri.http(url, '/Class/Info'),
      body: {
        'Token': FileHelper().readFile('token'),
        'ID': id.toString(),
      },
      headers: postHeaders,
      encoding: postEncoding,
    );
    return BaseModel.fromJson(jsonDecode(response.body));
  }

  Future<BaseListModel> classes() async {
    Response response = await post(
      Uri.http(url, '/Classes'),
      body: {
        'Token': FileHelper().readFile('token'),
      },
      headers: postHeaders,
      encoding: postEncoding,
    );
    return BaseListModel.fromJson(jsonDecode(response.body));
  }
}
