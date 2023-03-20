// ignore_for_file: file_names

import 'dart:convert';
import 'package:http/http.dart';
import 'package:client/public/file.dart';
import 'package:client/requests/base.dart';
import 'package:client/models/data.dart';
import 'package:client/models/data_list.dart';

class TeacherApi extends ResponseHelper {
  Future<DataModel> newTeacher({
    String account = '',
    String password = '',
    String name = '',
  }) async {
    Response response = await post(
      Uri.http(url, '/New/Teacher'),
      body: {
        'Token': FileHelper().readFile('token'),
        'Account': account,
        'Password': password,
        'Name': name,
      },
      headers: postHeaders,
      encoding: postEncoding,
    );
    return DataModel.fromJson(jsonDecode(decoder.convert(response.bodyBytes)));
  }

  Future<DataModel> teacherDisabled({
    int id = 0,
  }) async {
    Response response = await post(
      Uri.http(url, '/Teacher/Disabled'),
      body: {
        'Token': FileHelper().readFile('token'),
        'ID': id.toString(),
      },
      headers: postHeaders,
      encoding: postEncoding,
    );
    return DataModel.fromJson(jsonDecode(decoder.convert(response.bodyBytes)));
  }

  Future<DataModel> updateTeacherInfo({
    String password = '',
    String name = '',
    int id = 0,
  }) async {
    Response response = await post(
      Uri.http(url, '/Update/Teacher/Info'),
      body: {
        'Token': FileHelper().readFile('token'),
        'Password': password,
        'Name': name,
        'ID': id.toString(),
      },
      headers: postHeaders,
      encoding: postEncoding,
    );
    return DataModel.fromJson(jsonDecode(decoder.convert(response.bodyBytes)));
  }

  Future<DataListModel> teacherList({
    int page = 1,
    int pageSize = 10,
    String stext = '',
    int state = 0,
  }) async {
    Response response = await post(
      Uri.http(url, '/Teacher/List'),
      body: {
        'Token': FileHelper().readFile('token'),
        'Page': page.toString(),
        'PageSize': pageSize.toString(),
        'Stext': stext,
        'State': state.toString(),
      },
      headers: postHeaders,
      encoding: postEncoding,
    );
    return DataListModel.fromJson(jsonDecode(decoder.convert(response.bodyBytes)));
  }

  Future<DataModel> teacherInfo({
    int id = 0,
  }) async {
    Response response = await post(
      Uri.http(url, '/Teacher/Info'),
      body: {
        'Token': FileHelper().readFile('token'),
        'ID': id.toString(),
      },
      headers: postHeaders,
      encoding: postEncoding,
    );
    return DataModel.fromJson(jsonDecode(decoder.convert(response.bodyBytes)));
  }

  Future<DataModel> teachers() async {
    Response response = await post(
      Uri.http(url, '/Teachers'),
      body: {
        'Token': FileHelper().readFile('token'),
      },
      headers: postHeaders,
      encoding: postEncoding,
    );
    return DataModel.fromJson(jsonDecode(decoder.convert(response.bodyBytes)));
  }

// ========================================================================= teacher side =========================================================================

  Future<DataModel> teacherSignIn({
    String account = '',
    String password = '',
  }) async {
    Response response = await post(
      Uri.http(url, '/Teacher/Sign/In'),
      body: {
        'Account': account,
        'Password': password,
      },
      headers: postHeaders,
      encoding: postEncoding,
    );
    return DataModel.fromJson(jsonDecode(decoder.convert(response.bodyBytes)));
  }

  Future<DataModel> teacherSignOut() async {
    Response response = await post(
      Uri.http(url, '/Teacher/Sign/Out'),
      body: {
        'Token': FileHelper().readFile('token'),
      },
      headers: postHeaders,
      encoding: postEncoding,
    );
    return DataModel.fromJson(jsonDecode(decoder.convert(response.bodyBytes)));
  }

  Future<DataModel> checkTeacherInfo() async {
    Response response = await post(
      Uri.http(url, '/Check/Teacher/Info'),
      body: {
        'Token': FileHelper().readFile('token'),
      },
      headers: postHeaders,
      encoding: postEncoding,
    );
    return DataModel.fromJson(jsonDecode(decoder.convert(response.bodyBytes)));
  }

  Future<DataModel> teacherUpdate({
    String name = '',
  }) async {
    Response response = await post(
      Uri.http(url, '/Teacher/Update'),
      body: {
        'Token': FileHelper().readFile('token'),
        'Name': name,
      },
      headers: postHeaders,
      encoding: postEncoding,
    );
    return DataModel.fromJson(jsonDecode(decoder.convert(response.bodyBytes)));
  }

  Future<DataModel> teacherChangePassword({
    String newPassword = '',
  }) async {
    Response response = await post(
      Uri.http(url, '/Teacher/Change/Password'),
      body: {
        'Token': FileHelper().readFile('token'),
        'NewPassword': newPassword,
      },
      headers: postHeaders,
      encoding: postEncoding,
    );
    return DataModel.fromJson(jsonDecode(decoder.convert(response.bodyBytes)));
  }

  Future<DataModel> theTeacherClass() async {
    Response response = await post(
      Uri.http(url, '/The/Teacher/Class'),
      body: {
        'Token': FileHelper().readFile('token'),
      },
      headers: postHeaders,
      encoding: postEncoding,
    );
    return DataModel.fromJson(jsonDecode(decoder.convert(response.bodyBytes)));
  }

  Future<DataListModel> teacherExamineeList({
    int page = 1,
    int pageSize = 10,
    String stext = '',
    int classID = 0,
  }) async {
    Response response = await post(
      Uri.http(url, '/Teacher/Examinee/List'),
      body: {
        'Token': FileHelper().readFile('token'),
        'Page': page.toString(),
        'PageSize': pageSize.toString(),
        'Stext': stext,
        'ClassID': classID.toString(),
      },
      headers: postHeaders,
      encoding: postEncoding,
    );
    return DataListModel.fromJson(jsonDecode(decoder.convert(response.bodyBytes)));
  }

  Future<DataModel> teacherNewExaminee({
    String examineeNo = '',
    String name = '',
    int classID = 0,
    String contact = '',
  }) async {
    Response response = await post(
      Uri.http(url, '/Teacher/New/Examinee'),
      body: {
        'Token': FileHelper().readFile('token'),
        'ExamineeNo': examineeNo,
        'Name': name,
        'ClassID': classID.toString(),
        'Contact': contact,
      },
      headers: postHeaders,
      encoding: postEncoding,
    );
    return DataModel.fromJson(jsonDecode(decoder.convert(response.bodyBytes)));
  }

  Future<DataModel> teacherUpdateExaminee({
    int id = 0,
    String name = '',
    String contact = '',
    int classID = 0,
  }) async {
    Response response = await post(
      Uri.http(url, '/Teacher/Update/Examinee'),
      body: {
        'Token': FileHelper().readFile('token'),
        'ID': id.toString(),
        'Name': name,
        'Contact': contact,
        'ClassID': classID.toString(),
      },
      headers: postHeaders,
      encoding: postEncoding,
    );
    return DataModel.fromJson(jsonDecode(decoder.convert(response.bodyBytes)));
  }

  Future<DataListModel> teacherExamInfoList({
    int type = 0,
    int page = 1,
    int pageSize = 10,
    String stext = '',
    int examState = 0,
    int examType = 0,
    int pass = 0,
    int startState = 0,
    int suspendedState = 0,
    int examineeID = 0,
  }) async {
    Response response = await post(
      Uri.http(url, '/Teacher/ExamInfo/List'),
      body: {
        'Token': FileHelper().readFile('token'),
        'Type': type.toString(),
        'Page': page.toString(),
        'PageSize': pageSize.toString(),
        'Stext': stext,
        'ExamState': examState.toString(),
        'ExamType': examType.toString(),
        'Pass': pass.toString(),
        'StartState': startState.toString(),
        'SuspendedState': suspendedState.toString(),
        'ExamineeID': examineeID.toString(),
      },
      headers: postHeaders,
      encoding: postEncoding,
    );
    return DataListModel.fromJson(jsonDecode(decoder.convert(response.bodyBytes)));
  }

  Future<DataListModel> teacherScantronList({
    int type = 0,
    int page = 1,
    int pageSize = 10,
    int examID = 0,
  }) async {
    Response response = await post(
      Uri.http(url, '/Teacher/Scantron/List'),
      body: {
        'Token': FileHelper().readFile('token'),
        'Type': type.toString(),
        'Page': page.toString(),
        'PageSize': pageSize.toString(),
        'ExamID': examID.toString(),
      },
      headers: postHeaders,
      encoding: postEncoding,
    );
    return DataListModel.fromJson(jsonDecode(decoder.convert(response.bodyBytes)));
  }

  Future<DataModel> teacherScantronViewAttachments({
    String filePath = '',
  }) async {
    Response response = await post(
      Uri.http(url, '/Teacher/Scantron/View/Attachments'),
      body: {
        'Token': FileHelper().readFile('token'),
        'FilePath': filePath,
      },
      headers: postHeaders,
      encoding: postEncoding,
    );
    return DataModel.fromJson(jsonDecode(decoder.convert(response.bodyBytes)));
  }

  Future<DataListModel> teacherScantronSolutionList({
    int type = 0,
    int page = 1,
    int pageSize = 10,
    int scantronID = 0,
    int position = 0,
  }) async {
    Response response = await post(
      Uri.http(url, '/Teacher/Scantron/Solution/List'),
      body: {
        'Token': FileHelper().readFile('token'),
        'Type': type.toString(),
        'Page': page.toString(),
        'PageSize': pageSize.toString(),
        'ScantronID': scantronID.toString(),
        'Position': position.toString(),
      },
      headers: postHeaders,
      encoding: postEncoding,
    );
    return DataListModel.fromJson(jsonDecode(decoder.convert(response.bodyBytes)));
  }

  Future<DataModel> teacherScantronSolutionViewAttachments({
    String optionAttachment = '',
  }) async {
    Response response = await post(
      Uri.http(url, '/Teacher/Scantron/Solution/View/Attachments'),
      body: {
        'Token': FileHelper().readFile('token'),
        'OptionAttachment': optionAttachment,
      },
      headers: postHeaders,
      encoding: postEncoding,
    );
    return DataModel.fromJson(jsonDecode(decoder.convert(response.bodyBytes)));
  }

  Future<DataModel> teacherSubjects() async {
    Response response = await post(
      Uri.http(url, '/Teacher/Subjects'),
      body: {
        'Token': FileHelper().readFile('token'),
      },
      headers: postHeaders,
      encoding: postEncoding,
    );
    return DataModel.fromJson(jsonDecode(decoder.convert(response.bodyBytes)));
  }

  Future<DataModel> teacherNewExamInfo({
    String subjectName = '',
    String examNo = '',
    String examineeNo = '',
    int examType = 0,
  }) async {
    Response response = await post(
      Uri.http(url, '/Teacher/New/ExamInfo'),
      body: {
        'Token': FileHelper().readFile('token'),
        'SubjectName': subjectName,
        'ExamNo': examNo,
        'ExamineeNo': examineeNo.toString(),
        'ExamType': examType.toString(),
      },
      headers: postHeaders,
      encoding: postEncoding,
    );
    return DataModel.fromJson(jsonDecode(decoder.convert(response.bodyBytes)));
  }
}
