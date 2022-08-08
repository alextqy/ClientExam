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

    def ExamInfoList(self, Page: int, PageSize: int, Stext: str, ExamState: int, ExamType: int, Pass: int):
        Param = {
            'Page': Page,
            'PageSize': PageSize,
            'Stext': Stext.strip(),
            'ExamState': ExamState,
            'ExamType': ExamType,
            'Pass': Pass,
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
        FileName = self.FileHelper.CheckFileName(FileEntityPath)
        FileType = self.FileHelper.CheckFileType(FileEntityPath)
        FileFullName = FileName + '.' + FileType
        if FileType == 'xls':
            ContentType = 'application/vnd.ms-excel'
        if FileType == 'xlsx':
            ContentType = 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
        FileData = {'ExcelFile': (FileFullName, open(FileEntityPath, 'rb'), ContentType)}
        Result = self.Post({}, '/Import/Exam/Info', '', '', '', FileData)
        return Result

    def DownloadExamInfoDemo(self):
        Result = self.Post({}, '/Download/Exam/Info/Demo')
        return Result