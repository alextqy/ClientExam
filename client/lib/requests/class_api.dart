// ignore_for_file: file_names

import 'dart:convert';
import 'package:http/http.dart';
import 'package:client/public/file.dart';
import 'package:client/requests/base.dart';
import 'package:client/models/data.dart';
import 'package:client/models/data_list.dart';

class ClassApi extends ResponseHelper {
  Future<DataModel> newClass({
    String className = '',
    String description = '',
  }) async {
    Response response = await post(
      Uri.http(url, '/New/Class'),
      body: {
        'Token': FileHelper().readFile('token'),
        'ClassName': className,
        'Description': description,
      },
      headers: postHeaders,
      encoding: postEncoding,
    );
    return DataModel.fromJson(jsonDecode(decoder.convert(response.bodyBytes)));
  }

  Future<DataModel> updateClassInfo({
    int id = 0,
    String className = '',
    String description = '',
  }) async {
    Response response = await post(
      Uri.http(url, '/Update/Class/Info'),
      body: {
        'Token': FileHelper().readFile('token'),
        'ID': id.toString(),
        'ClassName': className,
        'Description': description,
      },
      headers: postHeaders,
      encoding: postEncoding,
    );
    return DataModel.fromJson(jsonDecode(decoder.convert(response.bodyBytes)));
  }

  Future<DataListModel> classList({
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
        'Stext': stext,
      },
      headers: postHeaders,
      encoding: postEncoding,
    );
    return DataListModel.fromJson(jsonDecode(decoder.convert(response.bodyBytes)));
  }

  Future<DataModel> classInfo({
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
    return DataModel.fromJson(jsonDecode(decoder.convert(response.bodyBytes)));
  }

  Future<DataModel> classes() async {
    Response response = await post(
      Uri.http(url, '/Classes'),
      body: {
        'Token': FileHelper().readFile('token'),
      },
      headers: postHeaders,
      encoding: postEncoding,
    );
    return DataModel.fromJson(jsonDecode(decoder.convert(response.bodyBytes)));
  }
}
