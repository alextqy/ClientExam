import 'dart:convert';
import 'package:crypto/crypto.dart' as crypto;

class Tools {
  // 当前时间戳
  int timestamp() {
    return DateTime.now().millisecondsSinceEpoch;
  }

  // 时间戳转时间
  String timestampToStr(int timestamp) {
    return DateTime.fromMillisecondsSinceEpoch(timestamp)
        .toLocal()
        .toString()
        .substring(0, 19);
  }

  // 时间转时间戳 1970-01-01 00:00:00.00000
  int strToTimestamp(String timeStr) {
    return DateTime.parse(timeStr).millisecondsSinceEpoch;
  }

  // md5
  String genMD5(String content) {
    var data = const Utf8Encoder().convert(content);
    var md5 = crypto.md5;
    var digest = md5.convert(data);
    return digest.toString();
  }
}
