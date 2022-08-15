# -*- coding:utf-8 -*-
from Controller.BaseController import *


class QuestionController(BaseController):

    def __init__(self) -> None:
        super().__init__()

    def NewQuestion(self, QuestionTitle: str, QuestionType: int, KnowledgeID: int, Description: str, Language: str, LanguageVersion: str):
        Param = {
            'QuestionTitle': QuestionTitle.strip(),
            'QuestionType': QuestionType,
            'KnowledgeID': KnowledgeID,
            'Description': Description.strip(),
            'Language': Language.strip(),
            'LanguageVersion': LanguageVersion.strip(),
        }
        Result = self.Post(Param, '/New/Question')
        return Result

    def QuestionAttachment(self, ID: int, FileEntityPath: str):
        Param = {
            'ID': ID,
        }
        FileType = self.FileHelper.CheckFileType(FileEntityPath)
        FileFullName = str(self.Common.TimeMS()) + '.' + FileType
        ContentType = self.Common.ContentType('.' + FileType)
        FileData = {'Attachment': (FileFullName, open(FileEntityPath, 'rb'), ContentType)}
        Result = self.Post(Param, '/Question/Attachment', '', '', '', FileData)
        return Result

    def QuestionDisabled(self, ID: int):
        Param = {
            'ID': ID,
        }
        Result = self.Post(Param, '/Question/Disabled')
        return Result

    def UpdateQuestionInfo(self, ID: int, QuestionTitle: str, QuestionType: int, Description: str, Language: str, LanguageVersion: str):
        Param = {
            'ID': ID,
            'QuestionTitle': QuestionTitle.strip(),
            'QuestionType': QuestionType,
            'Description': Description.strip(),
            'Language': Language.strip(),
            'LanguageVersion': LanguageVersion.strip(),
        }
        Result = self.Post(Param, '/Update/Question/Info')
        return Result

    def QuestionList(self, Page: int, PageSize: int, Stext: str, QuestionType: int, QuestionState: int, KnowledgeID: int):
        Param = {
            'Page': Page,
            'PageSize': PageSize,
            'Stext': Stext.strip(),
            'QuestionType': QuestionType,
            'QuestionState': QuestionState,
            'KnowledgeID': KnowledgeID,
        }
        Result = self.Post(Param, '/Question/List')
        return Result

    def QuestionInfo(self, ID: int):
        Param = {
            'ID': ID,
        }
        Result = self.Post(Param, '/Question/Info')
        return Result