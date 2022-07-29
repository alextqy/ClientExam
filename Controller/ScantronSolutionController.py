# -*- coding:utf-8 -*-
from Controller.BaseController import *


class ScantronSolutionController(BaseController):

    def __init__(self) -> None:
        super().__init__()

    def ScantronSolutionList(self, Page: int, PageSize: int, ScantronID: int, Position: int):
        Param = {
            'Page': Page,
            'PageSize': PageSize,
            'ScantronID': ScantronID,
            'Position': Position,
        }
        Result = self.Post(Param, '/Scantron/Solution/List')
        return Result

    def ScantronSolutionInfo(self, ID: int):
        Param = {
            'ID': ID,
        }
        Result = self.Post(Param, '/Scantron/Solution/Info')
        return Result