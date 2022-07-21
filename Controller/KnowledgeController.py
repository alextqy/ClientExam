# -*- coding:utf-8 -*-
from Controller.BaseController import *


class KnowledgeController(BaseController):

    def __init__(self) -> None:
        super().__init__()

    def NewKnowledge(self, KnowledgeName: str, SubjectID: int):
        Param = {
            'KnowledgeName': KnowledgeName.strip(),
            'SubjectID': SubjectID,
        }
        Result = self.Post(Param, '/New/Knowledge')
        return Result

    def KnowledgeDisabled(self, ID: int):
        Param = {
            'ID': ID,
        }
        Result = self.Post(Param, '/Knowledge/Disabled')
        return Result

    def UpdateKnowledgeInfo(self, ID: int, KnowledgeName: str):
        Param = {
            'ID': ID,
            'KnowledgeName': KnowledgeName.strip(),
        }
        Result = self.Post(Param, '/Update/Knowledge/Info')
        return Result

    def KnowledgeList(self, Page: int, PageSize: int, Stext: str, SubjectID: int, KnowledgeState: int):
        Param = {
            'Page': Page,
            'PageSize': PageSize,
            'Stext': Stext.strip(),
            'SubjectID': SubjectID,
            'KnowledgeState': KnowledgeState,
        }
        Result = self.Post(Param, '/Knowledge/List')
        return Result

    def KnowledgeInfo(self, ID: int):
        Param = {
            'ID': ID,
        }
        Result = self.Post(Param, '/Knowledge/Info')
        return Result