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