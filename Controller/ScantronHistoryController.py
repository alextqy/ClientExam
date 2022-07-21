# -*- coding:utf-8 -*-
from Controller.BaseController import *


class ScantronHistoryController(BaseController):

    def __init__(self) -> None:
        super().__init__()

    def ScantronHistoryList(self, Page: int, PageSize: int, ExamID: int):
        Param = {
            'Page': Page,
            'PageSize': PageSize,
            'ExamID': ExamID,
        }
        Result = self.Post(Param, '/Scantron/History/List')
        return Result

    def ScantronHistoryInfo(self, ID: int):
        Param = {
            'ID': ID,
        }
        Result = self.Post(Param, '/Scantron/History/Info')
        return Result