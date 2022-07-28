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

        # =====================================================================================================================================================================
        self.CurrentPageNo = 1
        self.TotalPageNo = 0

        # 页码按钮布局
        self.PageButtonLayout = QHBoxLayout()  # 设置按钮布局
        self.PageButtonLayout.setContentsMargins(0, 0, 0, 0)  # 设置边距

        # 当前页码
        self.CurrentPage = QLabel(self.Lang.CurrentPage + ' ' + str(self.CurrentPageNo))
        self.CurrentPage.setAlignment(Qt.AlignVCenter | Qt.AlignHCenter)  # 字体居中
        self.CurrentPage.adjustSize()  # 根据内容自适应宽度
        self.CurrentPage.setFixedSize(120, 30)  # 尺寸
        self.CurrentPage.setContentsMargins(0, 0, 0, 0)  # 设置边距
        self.CurrentPage.setStyleSheet(self.ManagerFrameStyleSheet.CurrentPage())  # 设置样式
        self.PageButtonLayout.addWidget(self.CurrentPage)  # 添加控件

        # 总页码数
        self.TotalPage = QLabel(self.Lang.TotalPages + ' ' + str(self.TotalPageNo))
        self.TotalPage.setAlignment(Qt.AlignVCenter | Qt.AlignHCenter)  # 字体居中
        self.TotalPage.adjustSize()  # 根据内容自适应宽度
        self.TotalPage.setFixedSize(120, 30)  # 尺寸
        self.TotalPage.setContentsMargins(0, 0, 0, 0)  # 设置边距
        self.TotalPage.setStyleSheet(self.ManagerFrameStyleSheet.CurrentPage())  # 设置样式
        self.PageButtonLayout.addWidget(self.TotalPage)  # 添加控件

        # 输入页码
        self.PageInput = QLineEdit()
        self.PageInput.setValidator(self.QIntValidator)  # 输入为整数类型
        self.PageInput.setFixedSize(170, 30)  # 尺寸
        self.PageInput.setAlignment(Qt.AlignVCenter | Qt.AlignHCenter)  # 内容居中
        self.PageInput.setPlaceholderText(self.Lang.EnterPageNumber)  # 设置空内容提示
        self.PageInput.setStyleSheet(self.ManagerFrameStyleSheet.InputBox())  # 设置样式
        self.PageInput.setToolTip(self.Lang.EnterPageNumber)  # 设置鼠标提示
        self.PageButtonLayout.addWidget(self.PageInput)  # 添加控件

        # 每一页展示行数
        self.RowsInput = QLineEdit()
        self.RowsInput.setValidator(self.QIntValidator)  # 输入为整数类型
        self.RowsInput.setFixedSize(170, 30)  # 尺寸
        self.RowsInput.setAlignment(Qt.AlignVCenter | Qt.AlignHCenter)  # 内容居中
        self.RowsInput.setPlaceholderText(self.Lang.EnterTheNumberOfLines)  # 设置空内容提示
        self.RowsInput.setStyleSheet(self.ManagerFrameStyleSheet.InputBox())  # 设置样式
        self.RowsInput.setToolTip(self.Lang.EnterTheNumberOfLines)  # 设置鼠标提示
        self.PageButtonLayout.addWidget(self.RowsInput)  # 添加控件

        # 搜索
        self.SearchInput = QLineEdit()
        self.SearchInput.setFixedSize(170, 30)  # 尺寸
        self.SearchInput.setAlignment(Qt.AlignVCenter | Qt.AlignHCenter)  # 内容居中
        self.SearchInput.setPlaceholderText(self.Lang.Search)  # 设置空内容提示
        self.SearchInput.setStyleSheet(self.ManagerFrameStyleSheet.InputBox())  # 设置样式
        self.SearchInput.setToolTip(self.Lang.Search)  # 设置鼠标提示
        self.PageButtonLayout.addWidget(self.SearchInput)  # 添加控件

        # 状态
        self.StateSelect = QComboBox()  # 设置下拉框
        self.StateSelect.adjustSize()  # 按内容自适应宽度
        self.StateSelect.setView(QListView())  # 设置内容控件
        self.StateSelect.setFixedHeight(30)  # 尺寸
        self.StateSelect.setMinimumWidth(110)  # 尺寸
        self.StateSelect.setStyleSheet(self.ManagerFrameStyleSheet.SelectBox())  # 设置样式
        self.StateSelect.insertItem(0, ' ' + self.Lang.ManagerStatus)  # 设置下拉内容
        self.StateSelect.setItemData(0, self.Lang.ManagerStatus, Qt.ToolTipRole)  # 设置下拉内容提示
        self.StateSelect.insertItem(1, self.Lang.Normal)  # 设置下拉内容
        self.StateSelect.setItemData(1, self.Lang.Normal, Qt.ToolTipRole)  # 设置下拉内容提示
        self.StateSelect.insertItem(2, self.Lang.Disabled)  # 设置下拉内容
        self.StateSelect.setItemData(2, self.Lang.Disabled, Qt.ToolTipRole)  # 设置下拉内容提示
        self.StateSelect.setCurrentIndex(0)  # 设置默认选项
        self.PageButtonLayout.addWidget(self.StateSelect)  # 添加控件

        # 确认按钮
        self.ConfirmButton = QPushButton(self.Lang.Confirm)
        self.ConfirmButton.setStyleSheet(self.ManagerFrameStyleSheet.Button())  # 设置样式
        self.ConfirmButton.setFixedHeight(30)  # 尺寸
        self.ConfirmButton.clicked.connect(lambda: self.TreeDataInit())  # 连接槽函数
        self.PageButtonLayout.addWidget(self.ConfirmButton)  # 添加控件

        # =====================================================================================================================================================================

        # 页码按钮布局
        self.PNButtonLayout = QHBoxLayout()  # 设置按钮布局
        self.PNButtonLayout.setContentsMargins(0, 0, 0, 0)  # 设置边距

        # 上一页
        self.PreviousPageButton = QPushButton(self.Lang.PreviousPage)
        self.PreviousPageButton.setStyleSheet(self.ManagerFrameStyleSheet.Button())  # 设置样式
        self.PreviousPageButton.setFixedHeight(30)  # 尺寸
        self.PreviousPageButton.clicked.connect(lambda: self.SetPreviousPage())  # 连接槽函数
        self.PNButtonLayout.addWidget(self.PreviousPageButton)  # 添加控件

        # 下一页
        self.NextPageButton = QPushButton(self.Lang.NextPage)
        self.NextPageButton.setStyleSheet(self.ManagerFrameStyleSheet.Button())  # 设置样式
        self.NextPageButton.setFixedHeight(30)  # 尺寸
        self.NextPageButton.clicked.connect(lambda: self.SetNextPage())  # 连接槽函数
        self.PNButtonLayout.addWidget(self.NextPageButton)  # 添加控件

        # =====================================================================================================================================================================

        self.ButtonLayout = QHBoxLayout()  # 设置按钮布局
        self.ButtonLayout.setContentsMargins(0, 0, 0, 0)  # 设置边距

        # 新建管理员
        self.NewManagerButton = QPushButton(self.Lang.NewManageristrator)
        self.NewManagerButton.setStyleSheet(self.ManagerFrameStyleSheet.Button())  # 设置样式
        self.NewManagerButton.setFixedHeight(30)  # 尺寸
        self.NewManagerButton.clicked.connect(lambda: self.NewManagerWindow())  # 连接槽函数
        self.ButtonLayout.addWidget(self.NewManagerButton)  # 添加控件

        # 刷新
        self.RefreshButton = QPushButton(self.Lang.Refresh)
        self.RefreshButton.setStyleSheet(self.ManagerFrameStyleSheet.Button())  # 设置样式
        self.RefreshButton.setFixedHeight(30)  # 尺寸
        self.RefreshButton.clicked.connect(lambda: self.TreeDataInit())  # 连接槽函数
        self.ButtonLayout.addWidget(self.RefreshButton)  # 添加控件

        self.CenterLayout.addLayout(self.PageButtonLayout)  # 添加布局
        self.CenterLayout.addLayout(self.PNButtonLayout)  # 添加布局
        self.CenterLayout.addLayout(self.ButtonLayout)  # 添加布局
        self.setLayout(self.CenterLayout)  # 添加布局

        # =====================================================================================================================================================================

        self.TreeDataInit()  # 主控件写入数据

    # 列表
    def TreeDataInit(self):
        self.ClearLayout(self.TreeLayout)

        # 获取列表数据
        if self.PageInput.text() != '':
            if int(self.PageInput.text()) >= self.TotalPageNo:
                Page = self.TotalPageNo
            else:
                Page = int(self.PageInput.text())
        else:
            Page = self.CurrentPageNo
        PageSize = 0 if self.RowsInput.text() == '' else int(self.RowsInput.text())
        Stext = self.SearchInput.text()
        State = self.StateSelect.currentIndex()
        Result = ManagerController().ManagerList(Page, PageSize, Stext, State)
        self.TotalPageNo = Result['TotalPage']
        self.TotalPage.setText(self.Lang.TotalPages + ' ' + str(self.TotalPageNo))

        if Result['State'] != True:
            MSGBOX().ERROR(Result['Memo'])
        else:
            Data = Result['Data']

            # 树状列表
            self.ManagerTree = BaseTreeWidget()
            self.ManagerTree.SetSelectionMode(2)  # 设置选择模式
            self.ManagerTree.setStyleSheet(self.ManagerFrameStyleSheet.TreeWidget())  # 设置样式
            self.ManagerTree.setColumnCount(4)  # 设置列数
            self.ManagerTree.setHeaderLabels(['ID', self.Lang.ManageristratorAccount, self.Lang.Name, self.Lang.ManagerStatus, self.Lang.CreationTime])  # 设置标题栏
            # self.ManagerTree.header().setSectionResizeMode(0, QHeaderView.ResizeToContents)  # 列宽自适应数据长度
            self.ManagerTree.setContentsMargins(0, 0, 0, 0)  # 设置边距
            self.ManagerTree.Connect(self.RightContextMenuExec)  # 鼠标右键菜单 链接槽函数
            self.TreeLayout.addWidget(self.ManagerTree)  # 添加控件

            TreeItems = []
            for i in range(len(Data)):
                item = QTreeWidgetItem()  # 设置item控件
                # item.setIcon(0, QtGui.QIcon(os.getcwd() + '/avatar.png'))
                item.setText(0, str(Data[i]['ID']))  # 设置内容
                item.setText(1, Data[i]['Account'])  # 设置内容
                item.setText(2, Data[i]['Name'])  # 设置内容
                if Data[i]['State'] == 1:
                    item.setText(3, self.Lang.Normal)  # 设置内容
                else:
                    item.setText(3, self.Lang.Disabled)  # 设置内容
                item.setText(4, self.Common.TimeToStr(Data[i]['CreateTime']))  # 设置内容
                item.setTextAlignment(0, Qt.AlignHCenter | Qt.AlignVCenter)  # 设置item字体居中
                item.setTextAlignment(1, Qt.AlignHCenter | Qt.AlignVCenter)  # 设置item字体居中
                item.setTextAlignment(2, Qt.AlignHCenter | Qt.AlignVCenter)  # 设置item字体居中
                item.setTextAlignment(3, Qt.AlignHCenter | Qt.AlignVCenter)  # 设置item字体居中
                item.setTextAlignment(4, Qt.AlignHCenter | Qt.AlignVCenter)  # 设置item字体居中
                TreeItems.append(item)  # 添加到item list
            self.ManagerTree.insertTopLevelItems(0, TreeItems)  # 添加到列表

    # 设置上一页
    def SetPreviousPage(self):
        if self.CurrentPageNo == 1:
            self.CurrentPageNo = 1
        else:
            self.CurrentPageNo -= 1
        self.CurrentPage.setText(self.Lang.CurrentPage + ' ' + str(self.CurrentPageNo))
        self.TreeDataInit()

    # 设置下一页
    def SetNextPage(self):
        if self.CurrentPageNo >= self.TotalPageNo:
            self.CurrentPageNo = self.TotalPageNo
        else:
            self.CurrentPageNo += 1
        self.CurrentPage.setText(self.Lang.CurrentPage + ' ' + str(self.CurrentPageNo))
        self.TreeDataInit()

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
        UpdateButton.clicked.connect(lambda: self.NewManagerAction(AccountInput.text(), NameInput.text(), PWDInput.text()))  # 连接槽函数
        self.ButtonLayout.addWidget(UpdateButton)  # 添加控件
        VLayout.addWidget(UpdateButton)

        self.NewManagerView.setLayout(VLayout)  # 添加布局
        self.NewManagerView.show()

    def NewManagerAction(self, Account: str, Password: str, Name: str):
        if Account != '' and Password != '' and Name != '':
            Result = ManagerController().NewManager(Account, Password, Name)
            if Result['State'] != True:
                MSGBOX().ERROR(Result['Memo'])
            else:
                self.NewManagerView.close()  # 关闭窗口
                self.TreeDataInit()  # 主控件写入数据
