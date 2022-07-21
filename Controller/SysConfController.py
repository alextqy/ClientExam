# -*- coding:utf-8 -*-
from Controller.BaseController import *


class SysConfController(BaseController):

    def __init__(self) -> None:
        super().__init__()

    def ConfigInfo(self, Key: str):
        Param = {
            'Key': Key.strip(),
        }
        Result = self.Post(Param, '/Config/Info')
        return Result