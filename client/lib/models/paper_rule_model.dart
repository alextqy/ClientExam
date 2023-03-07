// ignore_for_file: file_names

import 'dart:convert';
import 'package:client/models/base.dart';

class PaperRuleModel extends BaseModel {
  late int headlineID;
  late int knowledgeID;
  late int questionType;
  late int questionNum;
  late double singleScore;
  late int paperID;
  late int paperRuleState;
  late int serialNumber;
  late int updateTime;
  late bool selected;

  PaperRuleModel({
    int id = 0,
    int createTime = 0,
    this.headlineID = 0,
    this.knowledgeID = 0,
    this.questionType = 0,
    this.questionNum = 0,
    this.singleScore = 0,
    this.paperID = 0,
    this.paperRuleState = 0,
    this.serialNumber = 0,
    this.updateTime = 0,
    this.selected = false,
  }) : super(id, createTime);

  factory PaperRuleModel.fromJson(Map<String, dynamic> json) {
    return PaperRuleModel(
      id: json['ID'],
      createTime: json['CreateTime'],
      headlineID: json['HeadlineID'],
      knowledgeID: json['KnowledgeID'],
      questionType: json['QuestionType'],
      questionNum: json['QuestionNum'],
      singleScore: json['SingleScore'],
      paperID: json['PaperID'],
      paperRuleState: json['PaperRuleState'],
      serialNumber: json['SerialNumber'],
      updateTime: json['UpdateTime'],
    );
  }

  List<PaperRuleModel> fromJsonList(String jsonString) {
    List<PaperRuleModel> dataList = (jsonDecode(jsonString) as List).map((i) => PaperRuleModel.fromJson(i)).toList();
    return dataList;
  }
}
