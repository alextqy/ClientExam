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

  String utf8Encode(String u) {
    Utf8Decoder decoder = const Utf8Decoder();
    return decoder.convert(encodeU8L(u));
  }
}
