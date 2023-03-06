// ignore_for_file: file_names

import 'dart:convert';
import 'package:client/models/base.dart';

class PaperModel extends BaseModel {
  late String paperName;
  late String paperCode;
  late int subjectID;
  late String subjectName;
  late double totalScore;
  late double passLine;
  late int examDuration;
  late int paperState;
  late int updateTime;
  late bool selected;

  PaperModel({
    int id = 0,
    int createTime = 0,
    this.paperName = '',
    this.paperCode = '',
    this.subjectID = 0,
    this.subjectName = '',
    this.totalScore = 0,
    this.passLine = 0,
    this.examDuration = 0,
    this.paperState = 0,
    this.updateTime = 0,
    this.selected = false,
  }) : super(id, createTime);

  factory PaperModel.fromJson(Map<String, dynamic> json) {
    return PaperModel(
      id: json['ID'],
      createTime: json['CreateTime'],
      paperName: json['PaperName'],
      paperCode: json['PaperCode'],
      subjectID: json['SubjectID'],
      subjectName: json['SubjectName'],
      totalScore: json['TotalScore'],
      passLine: json['PassLine'],
      examDuration: json['ExamDuration'],
      paperState: json['PaperState'],
      updateTime: json['UpdateTime'],
    );
  }

  List<PaperModel> fromJsonList(String jsonString) {
    List<PaperModel> dataList = (jsonDecode(jsonString) as List)
        .map((i) => PaperModel.fromJson(i))
        .toList();
    return dataList;
  }
}
