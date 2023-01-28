// ignore_for_file: file_names

import 'dart:convert';

class ResponseHelper {
  String url = '127.0.0.1:6001';
  // String token = '';
  // header("Access-Control-Allow-Origin:*");
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
}
