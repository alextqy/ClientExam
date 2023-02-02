// ignore_for_file: file_names

import 'dart:convert';
import 'package:http/http.dart';
import 'package:client/public/file.dart';

class ResponseHelper {
  Utf8Decoder decoder = const Utf8Decoder();
  String url = '127.0.0.1:6001';
  // String token = '';
  // header('sAccess-Control-Allow-Origin:*');
  // header('Access-Control-Allow-Methods:POST');
  // header('Access-Control-Allow-Headers:x-requested-with, content-type');
  // header('Content-type:text/json');
  Map<String, String> postHeaders = {
    'Accept': 'application/json',
    'Content-Type': 'application/x-www-form-urlencoded',
    'Access-Control-Allow-Origin': '*',
    'Access-Control-Allow-Headers': 'x-requested-with, content-type',
  };
  Encoding? postEncoding = Encoding.getByName('utf-8');

  Future<bool> upload({
    required String url,
    required String uri,
    required String filePath,
    String filename = '',
    int id = 0,
    String excelFile = '',
    String attachment = '',
  }) async {
    String fromPathField = '';
    if (excelFile.trim().isNotEmpty) {
      fromPathField = excelFile.trim();
    } else {
      fromPathField = attachment.trim();
    }
    MultipartRequest request = MultipartRequest('post', Uri.parse(url + uri));
    request.fields['Token'] = FileHelper().readFile('token');
    MultipartFile multipartFile = await MultipartFile.fromPath(
      fromPathField,
      filePath,
      filename: filename,
    );
    request.files.add(multipartFile);
    StreamedResponse response = await request.send();
    // return response;
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
