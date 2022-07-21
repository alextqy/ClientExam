# -*- coding:utf-8 -*-
from Controller.BaseController import *


class ExamineeTokenController(BaseController):

    def __init__(self) -> None:
        super().__init__()

    def SignInStudentID(self, Account: str):
        Param = {
            'Account': Account.strip(),
        }
        Result = self.Post(Param, '/Sign/In/Student/ID')
        return Result

    def SignInAdmissionTicket(self, ExamNo: str):
        Param = {
            'ExamNo': ExamNo.strip(),
        }
        Result = self.Post(Param, '/Sign/In/Admission/Ticket')
        return Result

    def ExamScantronList(self):
        Result = self.Post({}, '/Exam/Scantron/List')
        return Result

    def ExamScantronSolutionInfo(self, ID: int):
        Param = {
            'ID': ID,
        }
        Result = self.Post(Param, '/Exam/Scantron/Solution/Info')
        return Result

    def ExamAnswer(self, ScantronID: int, ID: int, Answer: str):
        Param = {
            'ScantronID': ScantronID,
            'ID': ID,
            'Answer': Answer.strip(),
        }
        Result = self.Post(Param, '/Exam/Answer')
        return Result

    def EndTheExam(self):
        Result = self.Post({}, '/End/The/Exam')
        return Result