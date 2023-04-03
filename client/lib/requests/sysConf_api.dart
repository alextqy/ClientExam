// ignore_for_file: file_names

import 'dart:convert';
import 'package:http/http.dart';
import 'package:client/public/file.dart';
import 'package:client/requests/base.dart';
import 'package:client/models/data.dart';
import 'package:client/public/tools.dart';

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

  Future<DataModel> imageList() async {
    Response response = await post(
      Uri.http(url, '/Image/List'),
      body: {},
      headers: postHeaders,
      encoding: postEncoding,
    );
    return DataModel.fromJson(jsonDecode(decoder.convert(response.bodyBytes)));
  }

  Future<DataModel> imageRemove({
    required String imageID,
  }) async {
    Response response = await post(
      Uri.http(url, '/Image/Remove'),
      body: {
        'ImageID': imageID,
      },
      headers: postHeaders,
      encoding: postEncoding,
    );
    return DataModel.fromJson(jsonDecode(decoder.convert(response.bodyBytes)));
  }

  Future<DataModel> buildEnvironment({required String language, required String version}) async {
    Response response = await post(
      Uri.http(url, '/Build/Environment'),
      body: {
        'Language': language,
        'Version': version,
      },
      headers: postHeaders,
      encoding: postEncoding,
    );
    return DataModel.fromJson(jsonDecode(decoder.convert(response.bodyBytes)));
  }

  Future<DataModel> codeExecTest({
    required String language,
    required String version,
    required String codeStr,
  }) async {
    Response response = await post(
      Uri.http(url, '/Code/Exec/Test'),
      body: {
        'Key': 'TXNGG3KidItKrCGf5wXT53eZTYCOynOAIjbKJPdy',
        'Language': language,
        'Version': version,
        'CodeStr': codeStr,
        'RandomStr': Tools().timestamp().toString(),
      },
      headers: postHeaders,
      encoding: postEncoding,
    );
    return DataModel.fromJson(jsonDecode(decoder.convert(response.bodyBytes)));
  }
}
