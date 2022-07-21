# -*- coding:utf-8 -*-
from Controller.BaseController import *


class SubjectController(BaseController):

    def __init__(self) -> None:
        super().__init__()

    def NewSubject(self, SubjectName: str):
        Param = {
            'SubjectName': SubjectName.strip(),
        }
        Result = self.Post(Param, '/New/Subject')
        return Result

    def SubjectDisabled(self, ID: int):
        Param = {
            'ID': ID,
        }
        Result = self.Post(Param, '/Subject/Disabled')
        return Result

    def UpdateSubjectInfo(self, ID: int, SubjectName: str):
        Param = {
            'ID': ID,
            'SubjectName': SubjectName.strip(),
        }
        Result = self.Post(Param, '/Update/Subject/Info')
        return Result

    def SubjectList(self, Page: int, PageSize: int, Stext: str, SubjectState: int):
        Param = {
            'Page': Page,
            'PageSize': PageSize,
            'Stext': Stext.strip(),
            'SubjectState': SubjectState,
        }
        Result = self.Post(Param, '/Subject/List')
        return Result

    def SubjectInfo(self, ID: int):
        Param = {
            'ID': ID,
        }
        Result = self.Post(Param, '/Subject/Info')
        return Result