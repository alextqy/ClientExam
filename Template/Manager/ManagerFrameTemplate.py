from Template.BaseTemplate import *
from StyleSheet.ManagerFrameStyleSheet import *


# 管理员管理界面
class ManagerFrameTemplate(BaseTemplate, QFrame):

    def __init__(self):
        super().__init__()
        self.ManagerFrameStyleSheet = ManagerFrameStyleSheet()
        self.setStyleSheet(self.ManagerFrameStyleSheet.BaseStyleSheet())  # 设置样式