# -*- coding:utf-8 -*-
from Controller.BaseController import *


class ScantronController(BaseController):

    def __init__(self) -> None:
        super().__init__()

    def ScantronList(self, Page: int, PageSize: int, ExamID: int):
        Param = {
            'Page': Page,
            'PageSize': PageSize,
            'ExamID': ExamID,
        }
        Result = self.Post(Param, '/Scantron/List')
        return Result

    def ScantronInfo(self, ID: int):
        Param = {
            'ID': ID,
        }
        Result = self.Post(Param, '/Scantron/Info')
        return Result