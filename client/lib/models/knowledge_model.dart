// ignore_for_file: file_names

import 'dart:convert';
import 'package:client/models/base.dart';

class KnowledgeModel extends BaseModel {
  late String knowledgeName;
  late String knowledgeCode;
  late int subjectID;
  late int knowledgeState;
  late int updateTime;
  late bool selected;

  KnowledgeModel({
    int id = 0,
    int createTime = 0,
    this.knowledgeName = '',
    this.knowledgeCode = '',
    this.subjectID = 0,
    this.knowledgeState = 0,
    this.updateTime = 0,
    this.selected = false,
  }) : super(id, createTime);

  factory KnowledgeModel.fromJson(Map<String, dynamic> json) {
    return KnowledgeModel(
      id: json['ID'],
      createTime: json['CreateTime'],
      knowledgeName: json['KnowledgeName'],
      knowledgeCode: json['KnowledgeCode'],
      subjectID: json['SubjectID'],
      knowledgeState: json['KnowledgeState'],
      updateTime: json['UpdateTime'],
    );
  }

  List<KnowledgeModel> fromJsonList(String jsonString) {
    List<KnowledgeModel> dataList = (jsonDecode(jsonString) as List).map((i) => KnowledgeModel.fromJson(i)).toList();
    return dataList;
  }
}
