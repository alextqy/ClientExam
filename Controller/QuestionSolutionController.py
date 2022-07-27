# -*- coding:utf-8 -*-
from Controller.BaseController import *


class QuestionSolutionController(BaseController):

    def __init__(self) -> None:
        super().__init__()

    def NewQuestionSolution(self, QuestionID: int, Option: str, CorrectAnswer: int, CorrectItem: str, ScoreRatio: float, Position: int):
        Param = {
            'QuestionID': QuestionID,
            'Option': Option.strip(),
            'CorrectAnswer': CorrectAnswer,
            'CorrectItem': CorrectItem.strip(),
            'ScoreRatio': ScoreRatio,
            'Position': Position,
        }
        Result = self.Post(Param, '/New/Question/Solution')
        return Result

    def QuestionSolutionAttachment(self, ID: int, FileEntityPath: str):
        Param = {
            'ID': ID,
        }
        FileEntityByte = {'Attachment': open(FileEntityPath.strip(), 'rb').read()}
        Result = self.Post(Param, '/Question/Solution/Attachment', '', '', '', FileEntityByte)
        return Result

    def QuestionSolutionDelete(self, ID: int):
        Param = {
            'ID': ID,
        }
        Result = self.Post(Param, '/Question/Solution/Delete')
        return Result

    def QuestionSolutionList(self, Page: int, PageSize: int, QuestionID: int):
        Param = {
            'Page': Page,
            'PageSize': PageSize,
            'QuestionID': QuestionID,
        }
        Result = self.Post(Param, '/Question/Solution/List')
        return Result