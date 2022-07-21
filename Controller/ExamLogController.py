# -*- coding:utf-8 -*-
from Controller.BaseController import *


class ExamLogController(BaseController):

    def __init__(self) -> None:
        super().__init__()

    def ExamLogList(self, Page: int, PageSize: int, Stext: str, Type: int):
        Param = {
            'Page': Page,
            'PageSize': PageSize,
            'Stext': Stext.strip(),
            'Type': Type,
        }
        Result = self.Post(Param, '/Exam/Log/List')
        return Result

    def ExamLogInfo(self):
        Result = self.Post({}, '/Exam/Log/Info')
        return Result