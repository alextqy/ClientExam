// ignore_for_file: file_names

import 'dart:convert';
import 'package:client/models/base.dart';

class PracticeSolutionModel extends BaseModel {
  late int practiceID;
  late String option;
  late String optionAttachment;
  late int correctAnswer;
  late String correctItem;
  late double scoreRatio;
  late int position;
  late int updateTime;
  late String candidateAnswer;
  late bool selected;

  PracticeSolutionModel({
    int id = 0,
    int createTime = 0,
    this.practiceID = 0,
    this.option = '',
    this.optionAttachment = '',
    this.correctAnswer = 0,
    this.correctItem = '',
    this.scoreRatio = 0,
    this.position = 0,
    this.updateTime = 0,
    this.candidateAnswer = '',
    this.selected = false,
  }) : super(id, createTime);

  factory PracticeSolutionModel.fromJson(Map<String, dynamic> json) {
    return PracticeSolutionModel(
      id: json['ID'],
      createTime: json['CreateTime'],
      practiceID: json['PracticeID'],
      option: json['Option'],
      optionAttachment: json['OptionAttachment'],
      correctAnswer: json['CorrectAnswer'],
      correctItem: json['CorrectItem'],
      scoreRatio: json['ScoreRatio'],
      position: json['Position'],
      updateTime: json['UpdateTime'],
      candidateAnswer: json['CandidateAnswer'],
    );
  }

  List<PracticeSolutionModel> fromJsonList(String jsonString) {
    List<PracticeSolutionModel> dataList = (jsonDecode(jsonString) as List).map((i) => PracticeSolutionModel.fromJson(i)).toList();
    return dataList;
  }
}
