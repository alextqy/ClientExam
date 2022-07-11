# -*- coding:utf-8 -*-
from Public.BaseService import *
from Public.Common import *

_common = Common()
ConfigObj: dict = _common.ReadJsonFile(path[0] + '/config.json')


class Lang(BaseService):

    def __init__(self):
        super().__init__()
        self.Type = str.lower(ConfigObj['Lang'])

        if self.Type == 'en':
            self.ManagerLogin = 'manager login'
            self.TeacherLogin = 'teacher login'
            self.ExamineeLogin = 'Examinee login'
            self.Back = 'Back'
            self.Exam = 'Take an exam'
            self.PracticeQuestions = 'Practice questions'
            self.LoginStudentID = 'Login with your student ID number'
            self.LoginWithAdmission = 'Login with your admission ticket number'
            self.StudentIDNumber = 'Student ID number'
            self.AdmissionTicketNumber = 'Admission ticket number'
            self.Login = 'Login'
            self.Start = 'Start'
            self.ChooseExamSubjects = 'Choose exam subjects'
            self.SelectTestQuestionType = 'Select test question type'
            self.MultipleChoiceQuestions = 'Multiple choice questions'
            self.TrueOrFalse = 'True or False'
            self.MultipleChoices = 'Multiple choices'
            self.FillInTheBlank = 'Fill in the blank'
            self.QuestionsAndAnswers = 'Questions and Answers'
            self.ProgrammingQuestions = 'Programming questions'
            self.DragAndDrop = 'Drag and drop'
            self.ConnectingQuestion = 'Connecting question'

        elif self.Type == 'zh-cn':
            self.ManagerLogin = '管理员登录'
            self.TeacherLogin = '教师登录'
            self.ExamineeLogin = '考生登录'
            self.Back = '返回'
            self.Exam = '考试'
            self.PracticeQuestions = '练习题'
            self.LoginStudentID = '使用您的学生证号码登录'
            self.LoginWithAdmission = '使用您的准考证号码登录'
            self.StudentIDNumber = '学生证号码'
            self.AdmissionTicketNumber = '准考证号码'
            self.Login = '登录'
            self.Start = '开始'
            self.ChooseExamSubjects = '选择考试科目'
            self.SelectTestQuestionType = '选择试题类型'
            self.MultipleChoiceQuestions = '单项选择题'
            self.TrueOrFalse = '判断题'
            self.MultipleChoices = '多项选择题'
            self.FillInTheBlank = '填空题'
            self.QuestionsAndAnswers = '问答题'
            self.ProgrammingQuestions = '编程题'
            self.DragAndDrop = '拖拽题'
            self.ConnectingQuestion = '连线题'

        else:
            self.ManagerLogin = ''
            self.TeacherLogin = ''
            self.ExamineeLogin = ''
            self.Back = ''
            self.Exam = ''
            self.PracticeQuestions = ''
            self.LoginStudentID = ''
            self.LoginWithAdmission = ''
            self.StudentIDNumber = ''
            self.AdmissionTicketNumber = ''
            self.Login = ''
            self.Start = ''
            self.ChooseExamSubjects = ''
            self.SelectTestQuestionType = ''
            self.MultipleChoiceQuestions = ''
            self.TrueOrFalse = ''
            self.MultipleChoices = ''
            self.FillInTheBlank = ''
            self.QuestionsAndAnswers = ''
            self.ProgrammingQuestions = ''
            self.DragAndDrop = ''
            self.ConnectingQuestion = ''