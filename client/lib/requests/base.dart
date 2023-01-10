import 'dart:convert';

class ResponseHelper {
  String url = '127.0.0.1:6001';
  // String token = '';
  var postHeaders = {
    'Accept': 'application/json',
    'Content-Type': 'application/x-www-form-urlencoded',
  };
  var postEncoding = Encoding.getByName('utf-8');
}
