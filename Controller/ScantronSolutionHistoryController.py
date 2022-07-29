# -*- coding:utf-8 -*-
from Controller.BaseController import *


class ScantronSolutionHistoryController(BaseController):

    def __init__(self) -> None:
        super().__init__()

    def ScantronSolutionHistoryList(self, Page: int, PageSize: int, ScantronID: int, Position: int):
        Param = {
            'Page': Page,
            'PageSize': PageSize,
            'ScantronID': ScantronID,
            'Position': Position,
        }
        Result = self.Post(Param, '/Scantron/Solution/History/List')
        return Result

    def ScantronSolutionHistoryInfo(self, ID: int):
        Param = {
            'ID': ID,
        }
        Result = self.Post(Param, '/Scantron/Solution/History/Info')
        return Result