# -*- coding:utf-8 -*-
from Controller.BaseController import *


class TeacherController(BaseController):

    def __init__(self) -> None:
        super().__init__()

    def NewTeacher(self, Account: str, Password: str, Name: str):
        Param = {
            'Account': Account.strip(),
            'Password': Password.strip(),
            'Name': Name.strip(),
        }
        Result = self.Post(Param, '/New/Teacher')
        return Result

    def TeacherDisabled(self, ID: int):
        Param = {
            'ID': ID,
        }
        Result = self.Post(Param, '/Teacher/Disabled')
        return Result

    def UpdateTeacherInfo(self, Password: str, Name: str, ID: int):
        Param = {
            'Password': Password.strip(),
            'Name': Name.strip(),
            'ID': ID,
        }
        Result = self.Post(Param, '/Update/Teacher/Info')
        return Result

    def TeacherList(self, Page: int, PageSize: int, Stext: str, State: int):
        Param = {
            'Page': Page,
            'PageSize': PageSize,
            'Stext': Stext.strip(),
            'State': State,
        }
        Result = self.Post(Param, '/Teacher/List')
        return Result

    def TeacherInfo(self, ID: int):
        Param = {
            'ID': ID,
        }
        Result = self.Post(Param, '/Teacher/Info')
        return Result

    def TeacherSignIn(self, Account: str, Password: str):
        Param = {
            'Account': Account.strip(),
            'Password': Password.strip(),
        }
        Result = self.Post(Param, '/Teacher/Sign/In')
        return Result

    def TeacherSignOut(self):
        Result = self.Post({}, '/Teacher/Sign/Out')
        return Result

    def TeacherChangePassword(self, NewPassword: str):
        Param = {
            'NewPassword': NewPassword.strip(),
        }
        Result = self.Post(Param, '/Teacher/Change/Password')
        return Result