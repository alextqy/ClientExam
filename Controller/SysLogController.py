# -*- coding:utf-8 -*-
from Controller.BaseController import *


class SysLogController(BaseController):

    def __init__(self) -> None:
        super().__init__()

    def SysLogList(self, Page: int, PageSize: int, Stext: str, Type: int, ManagerID: int):
        Param = {
            'Page': Page,
            'PageSize': PageSize,
            'Stext': Stext.strip(),
            'Type': Type,
            'ManagerID': ManagerID,
        }
        Result = self.Post(Param, '/Sys/Log/List')
        return Result

    def SysLogInfo(self, ID: int):
        Param = {
            'ID': ID,
        }
        Result = self.Post(Param, '/Sys/Log/Info')
        return Result