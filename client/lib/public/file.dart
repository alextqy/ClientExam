import 'dart:io';
import 'package:file_selector/file_selector.dart';
import 'package:mime/mime.dart';

// ignore_for_file: unnecessary_this
class FileHelper {
  final String tokenFileName = 'token';

  // 文件写入
  bool writeFile(String fileName, String content) {
    File file = File(fileName);
    try {
      file.writeAsStringSync(content);
    } catch (e) {
      return false;
    }
    return true;
  }

  bool writeFileB(String fileName, List<int> content) {
    File file = File(fileName);
    try {
      file.writeAsBytes(content);
    } catch (e) {
      return false;
    }
    return true;
  }

  // 文件读取
  String readFile(String filePath) {
    File file = File(filePath);
    try {
      String content = file.readAsStringSync();
      return content;
    } catch (e) {
      return '';
    }
  }

  // 文件删除
  bool delFile(String filePath) {
    File file = File(filePath);
    try {
      file.deleteSync();
    } catch (e) {
      return false;
    }
    return true;
  }

  // 文件重命名
  bool renameFile(String filePath, String newName) {
    File file = File(filePath);
    try {
      file.renameSync(newName);
    } catch (e) {
      return false;
    }
    return true;
  }

  // 文件复制
  bool copyFile(String filePath, String newName) {
    File file = File(filePath);
    try {
      file.copySync(newName);
    } catch (e) {
      return false;
    }
    return true;
  }

  // 文件是否存在
  bool fileExists(String filePath) {
    File file = File(filePath);
    return file.existsSync();
  }

  // 文件大小
  int size(String filePath) {
    File file = File(filePath);
    return file.lengthSync();
  }

  // 文件类型
  String? type(String filePath) {
    return lookupMimeType(filePath);
  }

  // 文件夹创建
  bool createDir(String dirPath) {
    Directory dir = Directory(dirPath);
    try {
      dir.createSync(recursive: true);
    } catch (e) {
      return false;
    }
    return true;
  }

  // 文件夹删除
  bool delDir(String dirPath) {
    Directory dir = Directory(dirPath);
    try {
      dir.deleteSync(recursive: true);
    } catch (e) {
      return false;
    }
    return true;
  }

  // 文件夹是否存在
  bool dirExists(String dirPath) {
    Directory dir = Directory(dirPath);
    return dir.existsSync();
  }

  // 是否是文件夹
  bool isDir(String path) {
    return FileSystemEntity.isDirectorySync(path);
  }

  // 获取文件列表
  List<FileSystemEntity> listDir(String dirPath) {
    Directory dir = Directory(dirPath);
    return dir.listSync();
  }

  // 打开文件夹
  void openDir({
    required String dirPath,
    required List<String> type,
    String fileName = '*',
  }) async {
    XTypeGroup xType = XTypeGroup(label: fileName, extensions: type);
    await openFile(
      acceptedTypeGroups: [xType],
      initialDirectory: dirPath,
      confirmButtonText: '',
    );
  }

  // 选择文件
  Future<String?> checkFile({
    required String dirPath,
    required List<String> type,
    String fileName = '*',
  }) async {
    XTypeGroup xType = XTypeGroup(label: fileName, extensions: type);
    XFile? tempPath = await openFile(
      acceptedTypeGroups: [xType],
      initialDirectory: dirPath,
      confirmButtonText: '',
    );
    return tempPath?.path;
  }
}