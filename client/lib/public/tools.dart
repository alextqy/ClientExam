import 'dart:convert';
import 'dart:typed_data';
import 'package:crypto/crypto.dart' as crypto;

class Tools {
  // 当前时间戳
  int timestamp() {
    return DateTime.now().millisecondsSinceEpoch;
  }

  // 时间戳转时间
  String timestampToStr(int timestamp) {
    if (timestamp == 0) return '';
    if (timestamp.toString().length == 10) {
      timestamp *= 1000;
    }
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
    Uint8List data = const Utf8Encoder().convert(content);
    crypto.Hash md5 = crypto.md5;
    crypto.Digest digest = md5.convert(data);
    return digest.toString();
  }

  // string -> bytes
  Uint8List encodeU8L(String s) {
    List<int> encodedString = utf8.encode(s);
    int encodedLength = encodedString.length;
    ByteData data = ByteData(encodedLength + 4);
    data.setUint32(0, encodedLength, Endian.big);
    Uint8List bytes = data.buffer.asUint8List();
    bytes.setRange(4, encodedLength + 4, encodedString);
    return bytes;
  }

  // bytes -> string
  String decodeU8L(Uint8List s) {
    return utf8.decode(s);
  }

  String utf8Encode(String s) {
    Utf8Decoder decoder = const Utf8Decoder();
    return decoder.convert(encodeU8L(s));
  }

  String base64En(String s) {
    return base64Encode(utf8.encode(s));
  }

  String base64De(String s) {
    return String.fromCharCodes(base64Decode(s));
  }

  // 字符串转二进制数组
  List<int> toByteList(List<dynamic> data) {
    List<int> dataBit = [];
    for (dynamic element in data) {
      dataBit.add(element as int);
    }
    return dataBit;
  }

  // 二进制数组转二进制
  Uint8List byteListToBytes(List<int> data) {
    return Uint8List.fromList(data);
  }

  // 字符串指定位置插入指定符号
  String stringInsertion(String str, int offs, String ins) {
    String start = str.substring(0, offs);
    start += ins;
    String end = str.substring(offs, str.length);
    return start + end;
  }
}
