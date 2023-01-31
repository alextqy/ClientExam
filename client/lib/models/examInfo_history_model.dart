// ignore_for_file: file_names

import 'dart:convert';
import 'package:client/models/base.dart';

class ExamInfoHistoryModel extends BaseModel {
  late String subjectName;
  late String examNo;
  late double totalScore;
  late double passLine;
  late double actualScore;
  late int examDuration;
  late int startTime;
  late int endTime;
  late int actualDuration;
  late int pass;
  late int updateTime;
  late int examineeID;
  late int examState;
  late int examType;
  late bool selected;

  ExamInfoHistoryModel({
    int id = 0,
    int createTime = 0,
    this.subjectName = '',
    this.examNo = '',
    this.totalScore = 0,
    this.passLine = 0,
    this.actualScore = 0,
    this.examDuration = 0,
    this.startTime = 0,
    this.endTime = 0,
    this.actualDuration = 0,
    this.pass = 0,
    this.updateTime = 0,
    this.examineeID = 0,
    this.examState = 0,
    this.examType = 0,
    this.selected = false,
  }) : super(id, createTime);

  factory ExamInfoHistoryModel.fromJson(Map<String, dynamic> json) {
    return ExamInfoHistoryModel(
      id: json['ID'],
      createTime: json['CreateTime'],
      subjectName: json['SubjectName'],
      examNo: json['ExamNo'],
      totalScore: json['TotalScore'],
      passLine: json['PassLine'],
      actualScore: json['ActualScore'],
      examDuration: json['ExamDuration'],
      startTime: json['StartTime'],
      endTime: json['EndTime'],
      actualDuration: json['ActualDuration'],
      pass: json['Pass'],
      updateTime: json['UpdateTime'],
      examineeID: json['ExamineeID'],
      examState: json['ExamState'],
      examType: json['ExamType'],
    );
  }

  List<ExamInfoHistoryModel> fromJsonList(String jsonString) {
    List<ExamInfoHistoryModel> dataList = (jsonDecode(jsonString) as List)
        .map((i) => ExamInfoHistoryModel.fromJson(i))
        .toList();
    return dataList;
  }
}
