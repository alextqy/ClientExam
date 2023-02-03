// ignore_for_file: file_names

import 'dart:convert';
import 'package:http/http.dart';
import 'package:client/public/file.dart';
import 'package:client/requests/base.dart';
import 'package:client/models/data.dart';

class SysConfApi extends ResponseHelper {
  Future<DataModel> configInfo({
    String key = '',
  }) async {
    Response response = await post(
      Uri.http(url, '/Config/Info'),
      body: {
        'Token': FileHelper().readFile('token'),
        'Key': key,
      },
      headers: postHeaders,
      encoding: postEncoding,
    );
    return DataModel.fromJson(jsonDecode(decoder.convert(response.bodyBytes)));
  }
}