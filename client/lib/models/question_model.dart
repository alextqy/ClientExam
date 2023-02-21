// ignore_for_file: file_names

import 'dart:convert';
import 'package:client/models/base.dart';

class QuestionModel extends BaseModel {
  late String questionTitle;
  late String questionCode;
  late int questionType;
  late int questionState;
  late int marking;
  late int knowledgeID;
  late String description;
  late String attachment;
  late String language;
  late String languageVersion;
  late int updateTime;
  late bool selected;

  QuestionModel({
    int id = 0,
    int createTime = 0,
    this.questionTitle = '',
    this.questionCode = '',
    this.questionType = 0,
    this.questionState = 0,
    this.marking = 0,
    this.knowledgeID = 0,
    this.description = '',
    this.attachment = '',
    this.language = '',
    this.languageVersion = '',
    this.updateTime = 0,
    this.selected = false,
  }) : super(id, createTime);

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    return QuestionModel(
      id: json['ID'],
      createTime: json['CreateTime'],
      questionTitle: json['QuestionTitle'],
      questionCode: json['QuestionCode'],
      questionType: json['QuestionType'],
      questionState: json['QuestionState'],
      marking: json['Marking'],
      knowledgeID: json['KnowledgeID'],
      description: json['Description'],
      attachment: json['Attachment'],
      language: json['Language'] ?? '',
      languageVersion: json['LanguageVersion'] ?? '',
      updateTime: json['UpdateTime'],
    );
  }

  List<QuestionModel> fromJsonList(String jsonString) {
    List<QuestionModel> dataList = (jsonDecode(jsonString) as List)
        .map((i) => QuestionModel.fromJson(i))
        .toList();
    return dataList;
  }
}
