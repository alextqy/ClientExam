# -*- coding:utf-8 -*-
from Controller.BaseController import *


class PaperRuleController(BaseController):

    def __init__(self) -> None:
        super().__init__()

    def NewPaperRule(self, HeadlineID: int, QuestionType: int, KnowledgeID: int, QuestionNum: int, SingleScore: int, PaperID: int):
        Param = {
            'HeadlineID': HeadlineID,
            'QuestionType': QuestionType,
            'KnowledgeID': KnowledgeID,
            'QuestionNum': QuestionNum,
            'SingleScore': SingleScore,
            'PaperID': PaperID,
        }
        Result = self.Post(Param, '/New/Paper/Rule')
        return Result

    def PaperRuleDisabled(self, ID: int):
        Param = {
            'ID': ID,
        }
        Result = self.Post(Param, '/Paper/Rule/Disabled')
        return Result

    def PaperRuleDelete(self, ID: int):
        Param = {
            'ID': ID,
        }
        Result = self.Post(Param, '/Paper/Rule/Delete')
        return Result

    def PaperRuleList(self, Page: int, PageSize: int, PaperID: int, PaperRuleState: int):
        Param = {
            'Page': Page,
            'PageSize': PageSize,
            'PaperID': PaperID,
            'PaperRuleState': PaperRuleState,
        }
        Result = self.Post(Param, '/Paper/Rule/List')
        return Result

    def PaperRuleInfo(self, ID: int):
        Param = {
            'ID': ID,
        }
        Result = self.Post(Param, '/Paper/Rule/Info')
        return Result