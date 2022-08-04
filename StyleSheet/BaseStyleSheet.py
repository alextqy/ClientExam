# -*- coding:utf-8 -*-
from Public.Cache import *
from Public.Common import *
from Public.FileHelper import *
from Public.Lang import *
from Public.UDPTool import *


class BaseStyleSheet():

    def __init__(self):
        super().__init__()

        self.Cache = Cache()
        self.Common = Common()
        self.FileHelper = FileHelper()
        self.Lang = Lang()
        self.UDPTool = UDPTool()

        self.CommonColor = '#d9d9d9'
        self.FontFamily = 'Microsoft Yahei'
