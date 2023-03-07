// ignore_for_file: file_names

import 'dart:convert';
import 'package:client/models/base.dart';

class ScantronHistoryModel extends BaseModel {
  late String questionTitle;
  late String questionCode;
  late int questionType;
  late int marking;
  late int knowledgeID;
  late String description;
  late String attachment;
  late int updateTime;
  late double score;
  late int examID;
  late String headlineContent;
  late bool selected;

  ScantronHistoryModel({
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
    this.examID = 0,
    this.headlineContent = '',
    this.selected = false,
  }) : super(id, createTime);

  factory ScantronHistoryModel.fromJson(Map<String, dynamic> json) {
    return ScantronHistoryModel(
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
      examID: json['ExamID'],
      headlineContent: json['HeadlineContent'],
    );
  }

  List<ScantronHistoryModel> fromJsonList(String jsonString) {
    List<ScantronHistoryModel> dataList = (jsonDecode(jsonString) as List).map((i) => ScantronHistoryModel.fromJson(i)).toList();
    return dataList;
  }
}
