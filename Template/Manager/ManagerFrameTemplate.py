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

        self.NewManagerButton = QPushButton(self.Lang.NewManageristrator)  # 新建管理员按钮
        self.NewManagerButton.setStyleSheet(self.ManagerFrameStyleSheet.Button())  # 设置样式
        self.NewManagerButton.setFixedHeight(30)  # 尺寸
        self.NewManagerButton.clicked.connect(lambda: self.NewManagerWindow())  # 连接槽函数
        self.ButtonLayout.addWidget(self.NewManagerButton)  # 添加控件

        self.RefreshButton = QPushButton(self.Lang.Refresh)  # 刷新按钮
        self.RefreshButton.setStyleSheet(self.ManagerFrameStyleSheet.Button())  # 设置样式
        self.RefreshButton.setFixedHeight(30)  # 尺寸
        self.RefreshButton.clicked.connect(lambda: self.TreeDataInit())  # 连接槽函数
        self.ButtonLayout.addWidget(self.RefreshButton)  # 添加控件

        self.CenterLayout.addLayout(self.ButtonLayout)  # 添加布局
        self.TreeDataInit()  # 主控件写入数据
        self.setLayout(self.CenterLayout)  # 添加布局

    # 列表
    def TreeDataInit(self):
        self.ClearLayout(self.TreeLayout)

        # 树状列表
        self.ManagerTree = BaseTreeWidget()
        self.ManagerTree.SetSelectionMode(2)  # 设置选择模式
        self.ManagerTree.setStyleSheet(self.ManagerFrameStyleSheet.TreeWidget())  # 设置样式
        self.ManagerTree.setColumnCount(4)  # 设置列数
        self.ManagerTree.setHeaderLabels(["ID", self.Lang.ManageristratorAccount, self.Lang.Name, self.Lang.ManagerStatus, self.Lang.CreationTime])  # 设置标题栏
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
            item.setText(3, '启用')  # 设置内容
            item.setText(4, '2077-12-02')  # 设置内容
            item.setTextAlignment(0, Qt.AlignHCenter | Qt.AlignVCenter)  # 设置item字体居中
            item.setTextAlignment(1, Qt.AlignHCenter | Qt.AlignVCenter)  # 设置item字体居中
            item.setTextAlignment(2, Qt.AlignHCenter | Qt.AlignVCenter)  # 设置item字体居中
            item.setTextAlignment(3, Qt.AlignHCenter | Qt.AlignVCenter)  # 设置item字体居中
            TreeItems.append(item)  # 添加到item list
        self.ManagerTree.insertTopLevelItems(0, TreeItems)  # 添加到列表

        # 设置按钮布局
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
        self.PageInput.setToolTip(self.Lang.ManageristratorAccount)  # 设置鼠标提示
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
            self.TreeMenu.AddAction(self.Lang.ChangePassword, lambda: self.ChangePasswordWindow(Item))
            self.TreeMenu.AddAction(self.Lang.Disable, lambda: self.DisableAction(Item))
        else:  # 焦点外
            return

        self.TreeMenu.move(QCursor().pos())  # 移动到焦点
        self.TreeMenu.show()  # 展示

    # 节点数据详情
    def InfoWindow(self, Item: QTreeWidgetItem):
        self.ManagerDetailsView = QDialog()
        self.ManagerDetailsView.setWindowModality(Qt.ApplicationModal)  # 禁止其他所有窗口交互
        self.ManagerDetailsView.setStyleSheet(self.ManagerFrameStyleSheet.Dialog())  # 设置样式
        self.ManagerDetailsView.setFixedSize(222, 88)  # 尺寸

        VLayout = QVBoxLayout()

        NameInput = QLineEdit()  # 管理员名称输入
        NameInput.setFixedSize(200, 30)  # 尺寸
        NameInput.setAlignment(Qt.AlignVCenter | Qt.AlignHCenter)  # 内容居中
        NameInput.setPlaceholderText(self.Lang.Name)  # 设置空内容提示
        NameInput.setStyleSheet(self.ManagerFrameStyleSheet.InputBox())  # 设置样式
        NameInput.setToolTip(self.Lang.Name)  # 设置鼠标提示
        VLayout.addWidget(NameInput)  # 添加控件

        UpdateButton = QPushButton(self.Lang.Confirm)  # 修改管理员按钮
        UpdateButton.setStyleSheet(self.ManagerFrameStyleSheet.Button())  # 设置样式
        UpdateButton.setFixedHeight(30)  # 尺寸
        # UpdateButton.clicked.connect(lambda: ())  # 连接槽函数
        self.ButtonLayout.addWidget(UpdateButton)  # 添加控件
        VLayout.addWidget(UpdateButton)

        self.ManagerDetailsView.setLayout(VLayout)  # 添加布局
        self.ManagerDetailsView.show()

    # 修改密码
    def ChangePasswordWindow(self, Item: QTreeWidgetItem):
        self.ManagerPassworView = QDialog()
        self.ManagerPassworView.setWindowModality(Qt.ApplicationModal)  # 禁止其他所有窗口交互
        self.ManagerPassworView.setStyleSheet(self.ManagerFrameStyleSheet.Dialog())  # 设置样式
        self.ManagerPassworView.setFixedSize(222, 88)  # 尺寸

        VLayout = QVBoxLayout()

        PWDInput = QLineEdit()  # 管理员密码输入
        PWDInput.setFixedSize(200, 30)  # 尺寸
        PWDInput.setAlignment(Qt.AlignVCenter | Qt.AlignHCenter)  # 内容居中
        PWDInput.setPlaceholderText(self.Lang.ChangePassword)  # 设置空内容提示
        PWDInput.setStyleSheet(self.ManagerFrameStyleSheet.InputBox())  # 设置样式
        PWDInput.setToolTip(self.Lang.ChangePassword)  # 设置鼠标提示
        VLayout.addWidget(PWDInput)  # 添加控件

        UpdateButton = QPushButton(self.Lang.Confirm)  # 修改管理员按钮
        UpdateButton.setStyleSheet(self.ManagerFrameStyleSheet.Button())  # 设置样式
        UpdateButton.setFixedHeight(30)  # 尺寸
        # UpdateButton.clicked.connect(lambda: ())  # 连接槽函数
        self.ButtonLayout.addWidget(UpdateButton)  # 添加控件
        VLayout.addWidget(UpdateButton)

        self.ManagerPassworView.setLayout(VLayout)  # 添加布局
        self.ManagerPassworView.show()

    # 删除节点数据
    def DisableAction(self, Item: QTreeWidgetItem):
        self.TreeDataInit()

    # 新建节点
    def NewManagerWindow(self):
        self.NewManagerView = QDialog()
        self.NewManagerView.setWindowModality(Qt.ApplicationModal)  # 禁止其他所有窗口交互
        self.NewManagerView.setStyleSheet(self.ManagerFrameStyleSheet.Dialog())  # 设置样式
        self.NewManagerView.setFixedSize(222, 160)  # 尺寸

        VLayout = QVBoxLayout()

        AccountInput = QLineEdit()  # 管理员账号输入
        AccountInput.setFixedSize(200, 30)  # 尺寸
        AccountInput.setAlignment(Qt.AlignVCenter | Qt.AlignHCenter)  # 内容居中
        AccountInput.setPlaceholderText(self.Lang.ManageristratorAccount)  # 设置空内容提示
        AccountInput.setStyleSheet(self.ManagerFrameStyleSheet.InputBox())  # 设置样式
        AccountInput.setToolTip(self.Lang.ManageristratorAccount)  # 设置鼠标提示
        VLayout.addWidget(AccountInput)  # 添加控件

        NameInput = QLineEdit()  # 管理员名称输入
        NameInput.setFixedSize(200, 30)  # 尺寸
        NameInput.setAlignment(Qt.AlignVCenter | Qt.AlignHCenter)  # 内容居中
        NameInput.setPlaceholderText(self.Lang.Name)  # 设置空内容提示
        NameInput.setStyleSheet(self.ManagerFrameStyleSheet.InputBox())  # 设置样式
        NameInput.setToolTip(self.Lang.Name)  # 设置鼠标提示
        VLayout.addWidget(NameInput)  # 添加控件

        PWDInput = QLineEdit()  # 管理员名称输入
        PWDInput.setFixedSize(200, 30)  # 尺寸
        PWDInput.setAlignment(Qt.AlignVCenter | Qt.AlignHCenter)  # 内容居中
        PWDInput.setPlaceholderText(self.Lang.Password)  # 设置空内容提示
        PWDInput.setStyleSheet(self.ManagerFrameStyleSheet.InputBox())  # 设置样式
        PWDInput.setToolTip(self.Lang.Password)  # 设置鼠标提示
        VLayout.addWidget(PWDInput)  # 添加控件

        UpdateButton = QPushButton(self.Lang.Confirm)  # 修改管理员按钮
        UpdateButton.setStyleSheet(self.ManagerFrameStyleSheet.Button())  # 设置样式
        UpdateButton.setFixedHeight(30)  # 尺寸
        # UpdateButton.clicked.connect(lambda: ())  # 连接槽函数
        self.ButtonLayout.addWidget(UpdateButton)  # 添加控件
        VLayout.addWidget(UpdateButton)

        self.NewManagerView.setLayout(VLayout)  # 添加布局
        self.NewManagerView.show()
