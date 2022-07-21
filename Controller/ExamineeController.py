# -*- coding:utf-8 -*-
from Controller.BaseController import *


class ExamineeController(BaseController):

    def __init__(self) -> None:
        super().__init__()

    def NewExaminee(self, ExamineeNo: str, Name: str, ClassID: int, Contact: str):
        Param = {
            'ExamineeNo': ExamineeNo.strip(),
            'Name': Name.strip(),
            'ClassID': ClassID,
            'Contact': Contact.strip(),
        }
        Result = self.Post(Param, '/New/Examinee')
        return Result

    def UpdateExaminee(self, ID: int, Name: str, Contact: str):
        Param = {
            'ID': ID,
            'Name': Name.strip(),
            'Contact': Contact.strip(),
        }
        Result = self.Post(Param, '/Update/Examinee')
        return Result

    def ExamineeList(self, Page: int, PageSize: int, Stext: str, ClassID: int):
        Param = {
            'Page': Page,
            'PageSize': PageSize,
            'Stext': Stext.strip(),
            'ClassID': ClassID,
        }
        Result = self.Post(Param, '/Examinee/List')
        return Result

    def ExamineeInfo(self, ID: int):
        Param = {
            'ID': ID,
        }
        Result = self.Post(Param, '/Examinee/Info')
        return Result