# -*- coding:utf-8 -*-
from Controller.BaseController import *


class PracticeController(BaseController):

    def __init__(self) -> None:
        super().__init__()

    def SignInPractice(self, ExamineeNo: str):
        Param = {
            'ExamineeNo': ExamineeNo.strip(),
        }
        Result = self.Post(Param, '/Sign/In/Practice')
        return Result

    def NewPractice(self, QuestionType: int):
        Param = {
            'QuestionType': QuestionType,
        }
        Result = self.Post(Param, '/New/Practice')
        return Result

    def PracticeInfo(self, ID: int):
        Param = {
            'ID': ID,
        }
        Result = self.Post(Param, '/Practice/Info')
        return Result

    def PracticeAnswer(self, PracticeID: int, ID: int, Answer: str):
        Param = {
            'PracticeID': PracticeID,
            'ID': ID,
            'Answer': Answer.strip(),
        }
        Result = self.Post(Param, '/Practice/Answer')
        return Result

    def GradeThePractice(self, ID: int):
        Param = {
            'ID': ID,
        }
        Result = self.Post(Param, '/Grade/The/Practice')
        return Result

    def PracticeDelete(self, ID: int):
        Param = {
            'ID': ID,
        }
        Result = self.Post(Param, '/Practice/Delete')
        return Result