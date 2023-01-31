// ignore_for_file: file_names

import 'dart:convert';
import 'package:client/models/base.dart';

class PracticeModel extends BaseModel {
  late String questionTitle;
  late String questionCode;
  late int questionType;
  late int marking;
  late int knowledgeID;
  late String description;
  late String attachment;
  late int updateTime;
  late double score;
  late int examineeID;
  late String headlineContent;
  late int examineeTokenID;
  late bool selected;

  PracticeModel({
    int id = 0,
    int createTime = 0,
    this.questionTitle = '',
    this.questionCode = '',
    this.questionType = 0,
    this.marking = 0,
    this.knowledgeID = 0,
    this.description = '',
    this.attachment = '',
    this.updateTime = 0,
    this.score = 0,
    this.examineeID = 0,
    this.headlineContent = '',
    this.examineeTokenID = 0,
    this.selected = false,
  }) : super(id, createTime);

  factory PracticeModel.fromJson(Map<String, dynamic> json) {
    return PracticeModel(
      id: json['ID'],
      createTime: json['CreateTime'],
      questionTitle: json['QuestionTitle'],
      questionCode: json['QuestionCode'],
      questionType: json['QuestionType'],
      marking: json['Marking'],
      knowledgeID: json['KnowledgeID'],
      description: json['Description'],
      attachment: json['Attachment'],
      updateTime: json['UpdateTime'],
      score: json['Score'],
      examineeID: json['ExamineeID'],
      headlineContent: json['HeadlineContent'],
      examineeTokenID: json['ExamineeTokenID'],
    );
  }

  List<PracticeModel> fromJsonList(String jsonString) {
    List<PracticeModel> dataList = (jsonDecode(jsonString) as List)
        .map((i) => PracticeModel.fromJson(i))
        .toList();
    return dataList;
  }
}
