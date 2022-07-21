# -*- coding:utf-8 -*-
from Controller.BaseController import *


class ManagerController(BaseController):

    def __init__(self) -> None:
        super().__init__()

    def ManagerSignIn(self, Account: str, Password: str):
        Param = {
            'Account': Account.strip(),
            'Password': Password.strip(),
        }
        Result = self.Post(Param, '/Manager/Sign/In')
        return Result

    def ManagerSignOut(self):
        Result = self.Post({}, '/Manager/Sign/Out')
        return Result

    def NewManager(self, Account: str, Password: str, Name: str):
        Param = {
            'Account': Account.strip(),
            'Password': Password.strip(),
            'Name': Name.strip(),
        }
        Result = self.Post(Param, '/New/Manager')
        return Result

    def ManagerDisabled(self, ID: int):
        Param = {
            'ID': ID,
        }
        Result = self.Post(Param, '/Manager/Disabled')
        return Result

    def ManagerChangePassword(self, NewPassword: str, ID: int):
        Param = {
            'NewPassword': NewPassword.strip(),
            'ID': ID,
        }
        Result = self.Post(Param, '/Manager/Change/Password')
        return Result

    def UpdateManagerInfo(self, Name: str, Permission: int, ID: int):
        Param = {
            'Name': Name.strip(),
            'Permission': Permission,
            'ID': ID,
        }
        Result = self.Post(Param, '/Update/Manager/Info')
        return Result

    def ManagerList(self, Page: int, PageSize: int, Stext: str, State: int, Permission: int):
        Param = {
            'Page': Page,
            'PageSize': PageSize,
            'Stext': Stext.strip(),
            'State': State,
            'Permission': Permission,
        }
        Result = self.Post(Param, '/Manager/List')
        return Result

    def ManagerInfo(self, ID: int):
        Param = {
            'ID': ID,
        }
        Result = self.Post(Param, '/Manager/Info')
        return Result