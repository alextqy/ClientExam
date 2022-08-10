# -*- coding:utf-8 -*-
from Controller.BaseController import *


class ExamInfoHistoryController(BaseController):

    def __init__(self) -> None:
        super().__init__()

    def ExamInfoHistoryList(self, Page: int, PageSize: int, Stext: str, ExamState: int, ExamType: int, Pass: int):
        Param = {
            'Page': Page,
            'PageSize': PageSize,
            'Stext': Stext.strip(),
            'ExamState': ExamState,
            'ExamType': ExamType,
            'Pass': Pass,
        }
        Result = self.Post(Param, '/ExamInfo/History/List')
        return Result

    def ExamInfoHistory(self, ID: int):
        Param = {
            'ID': ID,
        }
        Result = self.Post(Param, '/ExamInfo/History')
        return Result
