# -*- coding:utf-8 -*-
from Controller.BaseController import *


class TeacherClassController(BaseController):

    def __init__(self) -> None:
        super().__init__()

    def NewTeacherClass(self, TeacherID: int, ClassID: int):
        Param = {
            'TeacherID': TeacherID,
            'ClassID': ClassID,
        }
        Result = self.Post(Param, '/New/Teacher/Class')
        return Result

    def DeleteTeacherClass(self, ID: int):
        Param = {
            'ID': ID,
        }
        Result = self.Post(Param, '/Delete/Teacher/Class')
        return Result

    def TeacherClassList(self, Page: int, PageSize: int, TeacherID: int, ClassID: int):
        Param = {
            'Page': Page,
            'PageSize': PageSize,
            'TeacherID': TeacherID,
            'ClassID': ClassID,
        }
        Result = self.Post(Param, '/Teacher/Class/List')
        return Result