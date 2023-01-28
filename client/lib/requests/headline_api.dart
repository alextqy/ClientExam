// ignore_for_file: file_names

import 'dart:convert';
import 'package:http/http.dart';
import 'package:client/public/file.dart';
import 'package:client/requests/base.dart';
import 'package:client/models/base.dart';
import 'package:client/models/base_list.dart';

class HeadlineApi extends ResponseHelper {
  Future<BaseModel> newHeadline({
    String content = '',
  }) async {
    Response response = await post(
      Uri.http(url, '/New/Headline'),
      body: {
        'Token': FileHelper().readFile('token'),
        'Content': content.trim(),
      },
      headers: postHeaders,
      encoding: postEncoding,
    );
    return BaseModel.fromJson(jsonDecode(response.body));
  }

  Future<BaseModel> updateHeadlineInfo({
    int id = 0,
    String content = '',
  }) async {
    Response response = await post(
      Uri.http(url, '/Update/Headline/Info'),
      body: {
        'Token': FileHelper().readFile('token'),
        'ID': id.toString(),
        'Content': content.trim(),
      },
      headers: postHeaders,
      encoding: postEncoding,
    );
    return BaseModel.fromJson(jsonDecode(response.body));
  }

  Future<BaseListModel> headlineList({
    int page = 1,
    int pageSize = 10,
    String stext = '',
  }) async {
    Response response = await post(
      Uri.http(url, '/Headline/List'),
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

  Future<BaseModel> headlineInfo({
    int id = 0,
  }) async {
    Response response = await post(
      Uri.http(url, '/Headline/Info'),
      body: {
        'Token': FileHelper().readFile('token'),
        'ID': id.toString(),
      },
      headers: postHeaders,
      encoding: postEncoding,
    );
    return BaseModel.fromJson(jsonDecode(response.body));
  }

  Future<BaseModel> headlines() async {
    Response response = await post(
      Uri.http(url, '/Headlines'),
      body: {
        'Token': FileHelper().readFile('token'),
      },
      headers: postHeaders,
      encoding: postEncoding,
    );
    return BaseModel.fromJson(jsonDecode(response.body));
  }
}
