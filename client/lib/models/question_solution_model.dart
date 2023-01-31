// ignore_for_file: file_names

import 'dart:convert';
import 'package:client/models/base.dart';

class QuestionSolutionModel extends BaseModel {
  late int questionID;
  late String option;
  late String optionAttachment;
  late int correctAnswer;
  late String correctItem;
  late double scoreRatio;
  late int position;
  late int updateTime;
  late bool selected;

  QuestionSolutionModel({
    int id = 0,
    int createTime = 0,
    this.questionID = 0,
    this.option = '',
    this.optionAttachment = '',
    this.correctAnswer = 0,
    this.correctItem = '',
    this.scoreRatio = 0,
    this.position = 0,
    this.updateTime = 0,
    this.selected = false,
  }) : super(id, createTime);

  factory QuestionSolutionModel.fromJson(Map<String, dynamic> json) {
    return QuestionSolutionModel(
      id: json['ID'],
      createTime: json['CreateTime'],
      questionID: json['QuestionID'],
      option: json['Option'],
      optionAttachment: json['OptionAttachment'],
      correctAnswer: json['CorrectAnswer'],
      correctItem: json['CorrectItem'],
      scoreRatio: json['ScoreRatio'],
      position: json['Position'],
      updateTime: json['UpdateTime'],
    );
  }

  List<QuestionSolutionModel> fromJsonList(String jsonString) {
    List<QuestionSolutionModel> dataList = (jsonDecode(jsonString) as List)
        .map((i) => QuestionSolutionModel.fromJson(i))
        .toList();
    return dataList;
  }
}
