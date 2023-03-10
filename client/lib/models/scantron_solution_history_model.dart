// ignore_for_file: file_names

import 'dart:convert';
import 'package:client/models/base.dart';

class ScantronSolutionHistoryModel extends BaseModel {
  late int scantronID;
  late String option;
  late String optionAttachment;
  late int correctAnswer;
  late String correctItem;
  late double scoreRatio;
  late int position;
  late int updateTime;
  late String candidateAnswer;
  late bool selected;

  ScantronSolutionHistoryModel({
    int id = 0,
    int createTime = 0,
    this.scantronID = 0,
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

  factory ScantronSolutionHistoryModel.fromJson(Map<String, dynamic> json) {
    return ScantronSolutionHistoryModel(
      id: json['ID'],
      createTime: json['CreateTime'],
      scantronID: json['scantronID'],
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

  List<ScantronSolutionHistoryModel> fromJsonList(String jsonString) {
    List<ScantronSolutionHistoryModel> dataList = (jsonDecode(jsonString) as List).map((i) => ScantronSolutionHistoryModel.fromJson(i)).toList();
    return dataList;
  }
}
