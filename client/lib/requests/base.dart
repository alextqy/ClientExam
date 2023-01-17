import 'dart:convert';

class ResponseHelper {
  String url = '127.0.0.1:6001';
  // String token = '';
  Map<String, String> postHeaders = {
    'Accept': 'application/json',
    'Content-Type': 'application/x-www-form-urlencoded',
  };
  Encoding? postEncoding = Encoding.getByName('utf-8');
}
