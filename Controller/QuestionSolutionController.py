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
        FileType = self.FileHelper.CheckFileType(FileEntityPath)
        FileFullName = str(self.Common.TimeMS()) + '.' + FileType
        ContentType = self.Common.ContentType('.' + FileType)
        FileData = {'Attachment': (FileFullName, open(FileEntityPath, 'rb'), ContentType)}
        Result = self.Post(Param, '/Question/Solution/Attachment', '', '', '', FileData)
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

    def QuestionSolutions(self, QuestionID: int, Position: int = 0):
        Param = {
            'QuestionID': QuestionID,
            'Position': Position,
        }
        Result = self.Post(Param, '/Question/Solutions')
        return Result

    def QuestionSolutionViewAttachments(self, FilePath: str):
        Param = {
            'FilePath': FilePath,
        }
        Result = self.Post(Param, '/Question/Solution/View/Attachments')
        return Result