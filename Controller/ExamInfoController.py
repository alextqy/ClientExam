# -*- coding:utf-8 -*-
from Controller.BaseController import *


class ExamInfoController(BaseController):

    def __init__(self) -> None:
        super().__init__()

    def NewExamInfo(self, SubjectName: str, ExamNo: str, ExamineeID: int, ExamType: int):
        Param = {
            'SubjectName': SubjectName.strip(),
            'ExamNo': ExamNo.strip(),
            'ExamineeID': ExamineeID,
            'ExamType': ExamType,
        }
        Result = self.Post(Param, '/New/ExamInfo')
        return Result

    def ExamInfoDisabled(self, ID: int):
        Param = {
            'ID': ID,
        }
        Result = self.Post(Param, '/ExamInfo/Disabled')
        return Result

    def ExamInfoList(self, Page: int, PageSize: int, Stext: str, ExamState: int, ExamType: int):
        Param = {
            'Page': Page,
            'PageSize': PageSize,
            'Stext': Stext.strip(),
            'ExamState': ExamState,
            'ExamType': ExamType,
        }
        Result = self.Post(Param, '/ExamInfo/List')
        return Result

    def ExamInfo(self, ID: int):
        Param = {
            'ID': ID,
        }
        Result = self.Post(Param, '/ExamInfo')
        return Result

    def GenerateTestPaper(self, ID: int):
        Param = {
            'ID': ID,
        }
        Result = self.Post(Param, '/Generate/Test/Paper')
        return Result

    def ResetExamQuestionData(self, ID: int):
        Param = {
            'ID': ID,
        }
        Result = self.Post(Param, '/Reset/Exam/Question/Data')
        return Result

    def ExamIntoHistory(self, ID: int):
        Param = {
            'ID': ID,
        }
        Result = self.Post(Param, '/Exam/Into/History')
        return Result

    def GradeTheExam(self, ID):
        Param = {
            'ID': ID,
        }
        Result = self.Post(Param, '/Grade/The/Exam')
        return Result

    def ImportExamInfo(self, FileEntityPath: str):
        FileEntityByte = {"ExcelFile": open(FileEntityPath.strip(), "rb").read()}
        Result = self.Post({}, "/Import/Exam/Info", "", "", "", FileEntityByte)
        return Result