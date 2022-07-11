# -*- coding:utf-8 -*-
from Template.BaseTemplate import *
from StyleSheet.ManagerMainStyleSheet import *


class ManagerMainTemplate(BaseTemplate, QDialog):

    def __init__(self, Title=TITLE, Icon=ICON):
        super().__init__()
        self.ManagerMainStyleSheet = ManagerMainStyleSheet()
        self.setStyleSheet(self.ManagerMainStyleSheet.BaseStyleSheet())
        self.setWindowTitle(Title)  # 窗口标题
        self.setWindowIcon(QIcon(Icon))  # 设置ICON
        SelfSize = self.geometry()  # 获取本窗口大小
        self.move(int((self.SW - SelfSize.width()) / 2), int((self.SH - SelfSize.height()) / 2))  # 居中显示
        self.setMinimumSize(300, 500)

        self.CenterLayout = QVBoxLayout()  # 设置主佈局
        self.CenterLayout.setAlignment(Qt.AlignHCenter | Qt.AlignVCenter)  # 居中
        self.CenterLayout.setContentsMargins(0, 0, 0, 0)  # 设置边距

        self.MainView()

        self.setLayout(self.CenterLayout)  # 添加中央布局

    # 主页
    def MainView(self):
        self.ClearLayout(self.CenterLayout)
        self.TopFrame = QFrame()
        self.BodyFrame = QFrame()
        self.BottomFrame = QFrame()
        self.CenterLayout.addWidget(self.TopFrame)
        self.CenterLayout.addWidget(self.BodyFrame)
        self.CenterLayout.addWidget(self.BottomFrame)
