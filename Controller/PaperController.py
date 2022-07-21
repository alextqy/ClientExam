# -*- coding:utf-8 -*-
from Controller.BaseController import *


class PaperController(BaseController):

    def __init__(self) -> None:
        super().__init__()

    def NewPaper(self, PaperName: str, SubjectID: int, TotalScore: float, PassLine: float, ExamDuration: int):
        Param = {
            'PaperName': PaperName.strip(),
            'SubjectID': SubjectID,
            'TotalScore': TotalScore,
            'PassLine': PassLine,
            'ExamDuration': ExamDuration,
        }
        Result = self.Post(Param, '/New/Paper')
        return Result

    def PaperDisabled(self, ID: int):
        Param = {
            'ID': ID,
        }
        Result = self.Post(Param, '/Paper/Disabled')
        return Result

    def UpdatePaperInfo(self, ID: int, PaperName: str, TotalScore: float, PassLine: float, ExamDuration: int):
        Param = {
            'ID': ID,
            'PaperName': PaperName.strip(),
            'TotalScore': TotalScore,
            'PassLine': PassLine,
            'ExamDuration': ExamDuration,
        }
        Result = self.Post(Param, '/Update/Paper/Info')
        return Result

    def PaperList(self, Page: int, PageSize: int, Stext: str, SubjectID: int, PaperState: int):
        Param = {
            'Page': Page,
            'PageSize': PageSize,
            'Stext': Stext.strip(),
            'SubjectID': SubjectID,
            'PaperState': PaperState,
        }
        Result = self.Post(Param, '/Paper/List')
        return Result

    def PaperInfo(self, ID: int):
        Param = {
            'ID': ID,
        }
        Result = self.Post(Param, '/Paper/Info')
        return Result