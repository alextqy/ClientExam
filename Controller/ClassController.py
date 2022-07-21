# -*- coding:utf-8 -*-
from Controller.BaseController import *


class ClassController(BaseController):

    def __init__(self) -> None:
        super().__init__()

    def NewClass(self, ClassName: str, Description: str):
        Param = {
            'ClassName': ClassName.strip(),
            'Description': Description.strip(),
        }
        Result = self.Post(Param, '/New/Class')
        return Result

    def UpdateClassInfo(self, ID: int, ClassName: str, Description: str):
        Param = {
            'ID': ID,
            'ClassName': ClassName.strip(),
            'Description': Description.strip(),
        }
        Result = self.Post(Param, '/Update/Class/Info')
        return Result

    def ClassList(self, Page: int, PageSize: int, Stext: str):
        Param = {
            'Page': Page,
            'PageSize': PageSize,
            'Stext': Stext.strip(),
        }
        Result = self.Post(Param, '/Class/List')
        return Result

    def ClassInfo(self, ID: int):
        Param = {
            'ID': ID,
        }
        Result = self.Post(Param, '/Class/Info')
        return Result