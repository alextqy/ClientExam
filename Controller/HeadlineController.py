# -*- coding:utf-8 -*-
from Controller.BaseController import *


class HeadlineController(BaseController):

    def __init__(self) -> None:
        super().__init__()

    def NewHeadline(self, Content: str):
        Param = {
            'Content': Content.strip(),
        }
        Result = self.Post(Param, '/New/Headline')
        return Result

    def UpdateHeadlineInfo(self, ID: int, Content: str):
        Param = {
            'ID': ID,
            'Content': Content.strip(),
        }
        Result = self.Post(Param, '/Update/Headline/Info')
        return Result

    def HeadlineList(self, Page: int, PageSize: int, Stext: str):
        Param = {
            'Page': Page,
            'PageSize': PageSize,
            'Stext': Stext.strip(),
        }
        Result = self.Post(Param, '/Headline/List')
        return Result

    def HeadlineInfo(self, ID: int):
        Param = {
            'ID': ID,
        }
        Result = self.Post(Param, '/Headline/Info')
        return Result