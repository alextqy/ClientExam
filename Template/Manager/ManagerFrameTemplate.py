from Template.BaseTemplate import *
from StyleSheet.ManagerFrameStyleSheet import *


# 管理员管理界面
class ManagerFrameTemplate(BaseTemplate, QFrame):

    def __init__(self):
        super().__init__()
        self.ManagerFrameStyleSheet = ManagerFrameStyleSheet()
        self.setStyleSheet(self.ManagerFrameStyleSheet.BaseStyleSheet())  # 设置样式

        self.CenterLayout = QVBoxLayout()  # 设置主布局
        self.CenterLayout.setContentsMargins(0, 0, 0, 0)  # 设置边距

        # 标题栏
        self.Headline = QLabel(self.Lang.Manager)
        self.Headline.setAlignment(Qt.AlignVCenter | Qt.AlignHCenter)  # 字体居中
        self.Headline.adjustSize()  # 根据内容自适应宽度
        self.Headline.setFixedHeight(30)  # 设置固定大小
        self.Headline.setContentsMargins(0, 0, 0, 0)  # 设置边距
        self.Headline.setStyleSheet(self.ManagerFrameStyleSheet.HeadlineStyleSheet())  # 设置样式
        self.CenterLayout.addWidget(self.Headline)  # 添加控件

        # 树状列表
        self.ManagerTree = BaseTreeWidget()
        self.ManagerTree.setStyleSheet(self.ManagerFrameStyleSheet.TreeWidget())  # 设置样式
        self.ManagerTree.setColumnCount(3)  # 设置列数
        self.ManagerTree.setHeaderLabels(["ID", self.Lang.AdministratorAccount, self.Lang.Name])  # 设置标题栏
        self.ManagerTree.setContentsMargins(0, 0, 0, 0)  # 设置边距
        self.CenterLayout.addWidget(self.ManagerTree)  # 添加控件

        # 主控件写入数据
        self.DataInit()

        self.setLayout(self.CenterLayout)  # 添加布局

    # 管理员列表
    def DataInit(self):
        TreeItems = []
        j = 0
        for i in range(3):
            j += 1
            item = QTreeWidgetItem()  # 设置item控件
            # item.setIcon(0, QtGui.QIcon(os.getcwd() + "/avatar.png"))
            item.setText(0, str(j))  # 设置内容
            item.setText(1, 'root')  # 设置内容
            item.setText(2, '超级管理员')  # 设置内容
            item.setTextAlignment(0, Qt.AlignHCenter | Qt.AlignVCenter)  # 设置item字体居中
            item.setTextAlignment(1, Qt.AlignHCenter | Qt.AlignVCenter)  # 设置item字体居中
            item.setTextAlignment(2, Qt.AlignHCenter | Qt.AlignVCenter)  # 设置item字体居中
            TreeItems.append(item)  # 添加到item list
        self.ManagerTree.insertTopLevelItems(0, TreeItems)  # 添加到用户列表