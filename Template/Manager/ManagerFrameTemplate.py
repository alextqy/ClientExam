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
        self.Headline.setFixedHeight(30)  # 尺寸
        self.Headline.setContentsMargins(0, 0, 0, 0)  # 设置边距
        self.Headline.setStyleSheet(self.ManagerFrameStyleSheet.Headline())  # 设置样式
        self.CenterLayout.addWidget(self.Headline)  # 添加控件

        self.TreeLayout = QVBoxLayout()  # 设置列表布局
        self.CenterLayout.addLayout(self.TreeLayout)  # 添加布局

        self.ButtonLayout = QHBoxLayout()  # 设置按钮布局
        self.ButtonLayout.setContentsMargins(0, 0, 0, 0)  # 设置边距

        self.NewManagerButton = QPushButton(self.Lang.NewAdministrator)  # 新建管理员按钮
        self.NewManagerButton.setStyleSheet(self.ManagerFrameStyleSheet.Button())  # 设置样式
        self.NewManagerButton.setFixedHeight(30)  # 尺寸
        # self.NewManagerButton.clicked.connect(lambda: ())  # 连接槽函数

        self.ButtonLayout.addWidget(self.NewManagerButton)  # 添加控件 向上居中对齐
        self.CenterLayout.addLayout(self.ButtonLayout)  # 添加布局

        self.TreeDataInit()  # 主控件写入数据

        self.setLayout(self.CenterLayout)  # 添加布局

    # 管理员列表
    def TreeDataInit(self):
        self.ClearLayout(self.TreeLayout)

        # 树状列表
        self.ManagerTree = BaseTreeWidget()
        self.ManagerTree.SetSelectionMode(2)  # 设置选择模式
        self.ManagerTree.setStyleSheet(self.ManagerFrameStyleSheet.TreeWidget())  # 设置样式
        self.ManagerTree.setColumnCount(3)  # 设置列数
        self.ManagerTree.setHeaderLabels(["ID", self.Lang.AdministratorAccount, self.Lang.Name])  # 设置标题栏
        # self.ManagerTree.header().setSectionResizeMode(0, QHeaderView.ResizeToContents)  # 列宽自适应数据长度
        self.ManagerTree.setContentsMargins(0, 0, 0, 0)  # 设置边距
        self.ManagerTree.Connect(self.RightContextMenuExec)  # 鼠标右键菜单 链接槽函数
        self.TreeLayout.addWidget(self.ManagerTree)  # 添加控件

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
        self.ManagerTree.insertTopLevelItems(0, TreeItems)  # 添加到列表

        self.PageButtonLayout = QHBoxLayout()
        self.TreeLayout.addLayout(self.PageButtonLayout)

        # 当前页码
        self.CurrentPage = QLabel(self.Lang.CurrentPage + " 1")
        self.CurrentPage.setAlignment(Qt.AlignVCenter | Qt.AlignHCenter)  # 字体居中
        self.CurrentPage.adjustSize()  # 根据内容自适应宽度
        self.CurrentPage.setFixedSize(200, 30)  # 尺寸
        self.CurrentPage.setContentsMargins(0, 0, 0, 0)  # 设置边距
        self.CurrentPage.setStyleSheet(self.ManagerFrameStyleSheet.CurrentPage())  # 设置样式
        self.PageButtonLayout.addWidget(self.CurrentPage)  # 添加控件

        # 上一页
        self.PreviousPageButton = QPushButton(self.Lang.PreviousPage)
        self.PreviousPageButton.setStyleSheet(self.ManagerFrameStyleSheet.Button())  # 设置样式
        self.PreviousPageButton.setFixedHeight(30)  # 尺寸
        # self.PreviousPageButton.clicked.connect(lambda: ())  # 连接槽函数
        self.PageButtonLayout.addWidget(self.PreviousPageButton)  # 添加控件

        # 下一页
        self.NextPageButton = QPushButton(self.Lang.NextPage)
        self.NextPageButton.setStyleSheet(self.ManagerFrameStyleSheet.Button())  # 设置样式
        self.NextPageButton.setFixedHeight(30)  # 尺寸
        # self.NextPageButton.clicked.connect(lambda: ())  # 连接槽函数
        self.PageButtonLayout.addWidget(self.NextPageButton)  # 添加控件

        # 输入页码
        self.PageInput = QLineEdit()
        self.PageInput.setFixedSize(200, 30)  # 尺寸
        self.PageInput.setAlignment(Qt.AlignVCenter | Qt.AlignHCenter)  # 内容居中
        self.PageInput.setPlaceholderText(self.Lang.EnterPageNumber)  # 设置空内容提示
        self.PageInput.setStyleSheet(self.ManagerFrameStyleSheet.InputBox())  # 设置样式
        self.PageInput.setToolTip(self.Lang.AdministratorAccount)  # 设置鼠标提示
        self.PageButtonLayout.addWidget(self.PageInput)  # 添加控件

        # 确认按钮
        self.ConfirmButton = QPushButton(self.Lang.Confirm)
        self.ConfirmButton.setStyleSheet(self.ManagerFrameStyleSheet.Button())  # 设置样式
        self.ConfirmButton.setFixedSize(120, 30)  # 尺寸
        # self.ConfirmButton.clicked.connect(lambda: ())  # 连接槽函数
        self.PageButtonLayout.addWidget(self.ConfirmButton)  # 添加控件

    # 列表节点右键菜单
    def RightContextMenuExec(self, pos):
        self.TreeMenu = BaseMenu()
        self.TreeMenu.setStyleSheet(self.ManagerFrameStyleSheet.TreeMenu())  # 设置样式
        Item = self.ManagerTree.currentItem()  # 获取被点击行控件
        ItemAt = self.ManagerTree.itemAt(pos)  # 获取点击焦点

        # 展示判断
        if type(Item) == QTreeWidgetItem and type(ItemAt) == QTreeWidgetItem:  # 焦点内
            self.TreeMenu.AddAction(self.Lang.ManagerDetails, lambda: self.InfoWindow(Item))
            self.TreeMenu.AddAction(self.Lang.Delete, lambda: self.RemoveAction(Item))
        else:  # 焦点外
            return

        self.TreeMenu.move(QCursor().pos())  # 移动到焦点
        self.TreeMenu.show()  # 展示

    # 节点数据详情
    def InfoWindow(self, Item: QTreeWidgetItem):
        pass

    # 删除节点数据
    def RemoveAction(self, Item: QTreeWidgetItem):
        pass
