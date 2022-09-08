# -*- coding:utf-8 -*-
from Template.BaseTemplate import *
from StyleSheet.Manager.SubjectStyleSheet import *


# 科目管理界面
class SubjectFrameTemplate(BaseTemplate, QFrame):

    def __init__(self):
        super().__init__()
        self.SubjectStyleSheet = SubjectStyleSheet()
        self.SubjectController = SubjectController()
        self.setStyleSheet(self.SubjectStyleSheet.BaseStyleSheet())  # 设置样式

        self.CenterLayout = QVBoxLayout()  # 设置主布局

        # 标题栏
        self.Headline = QLabel(self.Lang.Subject)
        self.Headline.setAlignment(Qt.AlignVCenter | Qt.AlignHCenter)  # 字体居中
        self.Headline.adjustSize()  # 根据内容自适应宽度
        self.Headline.setFixedHeight(30)  # 尺寸
        self.Headline.setStyleSheet(self.SubjectStyleSheet.Headline())  # 设置样式
        self.CenterLayout.addWidget(self.Headline)  # 添加控件

        self.TreeLayout = QVBoxLayout()  # 设置列表布局
        self.CenterLayout.addLayout(self.TreeLayout)  # 添加布局

        # =====================================================================================================================================================================
        self.CurrentPageNo = 1
        self.TotalPageNo = 0

        # 页码按钮布局
        self.PageButtonLayout = QHBoxLayout()  # 设置按钮布局

        # 当前页码
        self.CurrentPage = QLabel(self.Lang.CurrentPage + ' ' + str(self.CurrentPageNo))
        self.CurrentPage.setAlignment(Qt.AlignVCenter | Qt.AlignHCenter)  # 字体居中
        self.CurrentPage.adjustSize()  # 根据内容自适应宽度
        self.CurrentPage.setFixedSize(120, 30)  # 尺寸
        self.CurrentPage.setStyleSheet(self.SubjectStyleSheet.CurrentPage())  # 设置样式
        self.PageButtonLayout.addWidget(self.CurrentPage)  # 添加控件

        # 总页码数
        self.TotalPage = QLabel(self.Lang.TotalPages + ' ' + str(self.TotalPageNo))
        self.TotalPage.setAlignment(Qt.AlignVCenter | Qt.AlignHCenter)  # 字体居中
        self.TotalPage.adjustSize()  # 根据内容自适应宽度
        self.TotalPage.setFixedSize(120, 30)  # 尺寸
        self.TotalPage.setStyleSheet(self.SubjectStyleSheet.CurrentPage())  # 设置样式
        self.PageButtonLayout.addWidget(self.TotalPage)  # 添加控件

        # 输入页码
        self.PageInput = QLineEdit()
        self.PageInput.setValidator(self.QIntValidator)  # 输入为整数类型
        self.PageInput.setFixedSize(170, 30)  # 尺寸
        self.PageInput.setAlignment(Qt.AlignVCenter | Qt.AlignHCenter)  # 内容居中
        self.PageInput.setPlaceholderText(self.Lang.EnterPageNumber)  # 设置空内容提示
        self.PageInput.setStyleSheet(self.SubjectStyleSheet.InputBox())  # 设置样式
        self.PageInput.setToolTip(self.Lang.EnterPageNumber)  # 设置鼠标提示
        self.PageButtonLayout.addWidget(self.PageInput)  # 添加控件

        # 每一页展示行数
        self.RowsInput = QLineEdit()
        self.RowsInput.setValidator(self.QIntValidator)  # 输入为整数类型
        self.RowsInput.setFixedSize(170, 30)  # 尺寸
        self.RowsInput.setAlignment(Qt.AlignVCenter | Qt.AlignHCenter)  # 内容居中
        self.RowsInput.setPlaceholderText(self.Lang.EnterTheNumberOfLines)  # 设置空内容提示
        self.RowsInput.setStyleSheet(self.SubjectStyleSheet.InputBox())  # 设置样式
        self.RowsInput.setToolTip(self.Lang.EnterTheNumberOfLines)  # 设置鼠标提示
        self.PageButtonLayout.addWidget(self.RowsInput)  # 添加控件

        # 搜索
        self.SearchInput = QLineEdit()
        self.SearchInput.setFixedSize(170, 30)  # 尺寸
        self.SearchInput.setAlignment(Qt.AlignVCenter | Qt.AlignHCenter)  # 内容居中
        self.SearchInput.setPlaceholderText(self.Lang.Search)  # 设置空内容提示
        self.SearchInput.setStyleSheet(self.SubjectStyleSheet.InputBox())  # 设置样式
        self.SearchInput.setToolTip(self.Lang.Search)  # 设置鼠标提示
        self.PageButtonLayout.addWidget(self.SearchInput)  # 添加控件

        # 状态
        self.StateSelect = QComboBox()  # 设置下拉框
        self.StateSelect.adjustSize()  # 按内容自适应宽度
        self.StateSelect.setView(QListView())  # 设置内容控件
        self.StateSelect.setFixedHeight(30)  # 尺寸
        self.StateSelect.setMinimumWidth(110)  # 尺寸
        self.StateSelect.setStyleSheet(self.SubjectStyleSheet.SelectBox())  # 设置样式
        self.StateSelect.insertItem(0, self.Lang.SubjectStatus)  # 设置下拉内容
        self.StateSelect.setItemData(0, self.Lang.SubjectStatus, Qt.ToolTipRole)  # 设置下拉内容提示
        self.StateSelect.insertItem(1, self.Lang.Normal)  # 设置下拉内容
        self.StateSelect.setItemData(1, self.Lang.Normal, Qt.ToolTipRole)  # 设置下拉内容提示
        self.StateSelect.insertItem(2, self.Lang.Disabled)  # 设置下拉内容
        self.StateSelect.setItemData(2, self.Lang.Disabled, Qt.ToolTipRole)  # 设置下拉内容提示
        self.StateSelect.setCurrentIndex(0)  # 设置默认选项
        self.PageButtonLayout.addWidget(self.StateSelect)  # 添加控件

        # 确认按钮
        self.ConfirmButton = QPushButton(self.Lang.Confirm)
        self.ConfirmButton.setStyleSheet(self.SubjectStyleSheet.Button())  # 设置样式
        self.ConfirmButton.setFixedHeight(30)  # 尺寸
        self.ConfirmButton.clicked.connect(lambda: self.TreeDataInit())  # 连接槽函数
        self.PageButtonLayout.addWidget(self.ConfirmButton)  # 添加控件

        # =====================================================================================================================================================================

        # 页码按钮布局
        self.PNButtonLayout = QHBoxLayout()  # 设置按钮布局

        # 上一页
        self.PreviousPageButton = QPushButton(self.Lang.PreviousPage)
        self.PreviousPageButton.setStyleSheet(self.SubjectStyleSheet.Button())  # 设置样式
        self.PreviousPageButton.setFixedHeight(30)  # 尺寸
        self.PreviousPageButton.clicked.connect(lambda: self.SetPreviousPage())  # 连接槽函数
        self.PNButtonLayout.addWidget(self.PreviousPageButton)  # 添加控件

        # 下一页
        self.NextPageButton = QPushButton(self.Lang.NextPage)
        self.NextPageButton.setStyleSheet(self.SubjectStyleSheet.Button())  # 设置样式
        self.NextPageButton.setFixedHeight(30)  # 尺寸
        self.NextPageButton.clicked.connect(lambda: self.SetNextPage())  # 连接槽函数
        self.PNButtonLayout.addWidget(self.NextPageButton)  # 添加控件

        # =====================================================================================================================================================================

        self.ButtonLayout = QHBoxLayout()  # 设置按钮布局

        # 新建
        self.NewSubjectButton = QPushButton(self.Lang.NewSubject)
        self.NewSubjectButton.setStyleSheet(self.SubjectStyleSheet.Button())  # 设置样式
        self.NewSubjectButton.setFixedHeight(30)  # 尺寸
        self.NewSubjectButton.clicked.connect(lambda: self.NewSubjectWindow())  # 连接槽函数
        self.ButtonLayout.addWidget(self.NewSubjectButton)  # 添加控件

        # 刷新
        self.RefreshButton = QPushButton(self.Lang.Refresh)
        self.RefreshButton.setStyleSheet(self.SubjectStyleSheet.Button())  # 设置样式
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
        Result = self.SubjectController.SubjectList(Page, PageSize, Stext, State)
        self.TotalPageNo = Result['TotalPage']
        self.TotalPage.setText(self.Lang.TotalPages + ' ' + str(self.TotalPageNo))

        if Result['State'] != True:
            self.MSGBOX.ERROR(Result['Memo'])
        else:
            Data = Result['Data']

            # 树状列表
            self.SubjectTree = BaseTreeWidget()
            self.SubjectTree.SetSelectionMode(2)  # 设置选择模式
            self.SubjectTree.setStyleSheet(self.SubjectStyleSheet.TreeWidget())  # 设置样式
            self.SubjectTree.setColumnCount(6)  # 设置列数
            self.SubjectTree.hideColumn(4)  # 隐藏列
            self.SubjectTree.hideColumn(5)  # 隐藏列
            self.SubjectTree.setHeaderLabels(['ID', self.Lang.SubjectName, self.Lang.SubjectStatus, self.Lang.CreationTime, 'SubjectCode', 'UpdateTime'])  # 设置标题栏
            # self.SubjectTree.header().setSectionResizeMode(0, QHeaderView.ResizeToContents)  # 列宽自适应数据长度
            self.SubjectTree.Connect(self.RightContextMenuExec)  # 鼠标右键菜单 链接槽函数
            self.TreeLayout.addWidget(self.SubjectTree)  # 添加控件

            if len(Data) > 0:
                TreeItems = []
                for i in range(len(Data)):
                    item = QTreeWidgetItem()  # 设置item控件
                    # item.setIcon(0, QtGui.QIcon(os.getcwd() + '/avatar.png'))
                    item.setText(0, str(Data[i]['ID']))  # 设置内容
                    item.setText(1, Data[i]['SubjectName'])  # 设置内容
                    if Data[i]['SubjectState'] == 1:
                        item.setText(2, self.Lang.Normal)  # 设置内容
                    else:
                        item.setText(2, self.Lang.Disabled)  # 设置内容
                    item.setText(3, self.Common.TimeToStr(Data[i]['CreateTime']))  # 设置内容
                    item.setText(4, Data[i]['SubjectCode'])  # 设置内容
                    item.setText(5, str(Data[i]['UpdateTime']))  # 设置内容
                    item.setTextAlignment(0, Qt.AlignHCenter | Qt.AlignVCenter)  # 设置item字体居中
                    item.setTextAlignment(1, Qt.AlignHCenter | Qt.AlignVCenter)  # 设置item字体居中
                    item.setTextAlignment(2, Qt.AlignHCenter | Qt.AlignVCenter)  # 设置item字体居中
                    item.setTextAlignment(3, Qt.AlignHCenter | Qt.AlignVCenter)  # 设置item字体居中
                    item.setTextAlignment(4, Qt.AlignHCenter | Qt.AlignVCenter)  # 设置item字体居中
                    item.setTextAlignment(5, Qt.AlignHCenter | Qt.AlignVCenter)  # 设置item字体居中
                    TreeItems.append(item)  # 添加到item list
                self.SubjectTree.insertTopLevelItems(0, TreeItems)  # 添加到列表

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
        self.TreeMenu.setStyleSheet(self.SubjectStyleSheet.TreeMenu())  # 设置样式
        Item = self.SubjectTree.currentItem()  # 获取被点击行控件
        ItemAt = self.SubjectTree.itemAt(pos)  # 获取点击焦点

        # 展示判断
        if type(Item) == QTreeWidgetItem and type(ItemAt) == QTreeWidgetItem:  # 焦点内
            self.TreeMenu.AddAction(self.Lang.SubjectDetails, lambda: self.InfoWindow(Item))
            self.TreeMenu.AddAction(self.Lang.Disable, lambda: self.DisableAction())
        else:  # 焦点外
            return

        self.TreeMenu.move(QCursor().pos())  # 移动到焦点
        self.TreeMenu.show()  # 展示

    # 节点数据详情
    def InfoWindow(self, Item):
        ID: int = int(Item.text(0))
        Name: str = Item.text(1)
        SubjectCode: int = Item.text(4)
        UpdateTime: int = Item.text(5)

        self.SubjectDetailsView = QDialog()
        self.SubjectDetailsView.setWindowTitle(TITLE)
        self.SubjectDetailsView.setWindowModality(Qt.ApplicationModal)  # 禁止其他所有窗口交互
        self.SubjectDetailsView.setStyleSheet(self.SubjectStyleSheet.Dialog())  # 设置样式
        self.SubjectDetailsView.setFixedSize(322, 160)  # 尺寸

        VLayout = QVBoxLayout()

        NameInput = QLineEdit()  # 输入
        NameInput.setText(Name)  # 设置内容
        NameInput.setFixedHeight(30)  # 尺寸
        NameInput.setAlignment(Qt.AlignVCenter | Qt.AlignHCenter)  # 内容居中
        NameInput.setPlaceholderText(self.Lang.SubjectName)  # 设置空内容提示
        NameInput.setStyleSheet(self.SubjectStyleSheet.InputBox())  # 设置样式
        NameInput.setToolTip(self.Lang.SubjectName)  # 设置鼠标提示
        VLayout.addWidget(NameInput)  # 添加控件

        CodeInput = QLineEdit()
        CodeInput.setText(SubjectCode)  # 设置内容
        CodeInput.setFixedHeight(30)  # 尺寸
        CodeInput.setAlignment(Qt.AlignVCenter | Qt.AlignHCenter)  # 内容居中
        CodeInput.setPlaceholderText(self.Lang.SubjectCode)  # 设置空内容提示
        CodeInput.setStyleSheet(self.SubjectStyleSheet.InputBox())  # 设置样式
        CodeInput.setToolTip(self.Lang.SubjectCode)  # 设置鼠标提示
        CodeInput.setEnabled(False)  # 禁止输入
        VLayout.addWidget(CodeInput)  # 添加控件

        UpdateTimeInput = QLineEdit()
        UpdateTimeInput.setText(self.Common.TimeToStr(UpdateTime))  # 设置内容
        UpdateTimeInput.setFixedHeight(30)  # 尺寸
        UpdateTimeInput.setAlignment(Qt.AlignVCenter | Qt.AlignHCenter)  # 内容居中
        UpdateTimeInput.setPlaceholderText(self.Lang.UpdateTime)  # 设置空内容提示
        UpdateTimeInput.setStyleSheet(self.SubjectStyleSheet.InputBox())  # 设置样式
        UpdateTimeInput.setToolTip(self.Lang.UpdateTime)  # 设置鼠标提示
        UpdateTimeInput.setEnabled(False)  # 禁止输入
        VLayout.addWidget(UpdateTimeInput)  # 添加控件

        UpdateButton = QPushButton(self.Lang.Confirm)  # 按钮
        UpdateButton.setStyleSheet(self.SubjectStyleSheet.Button())  # 设置样式
        UpdateButton.setFixedHeight(30)  # 尺寸
        UpdateButton.clicked.connect(lambda: self.InfoWindowAction(ID, NameInput.text(), Name))  # 连接槽函数
        self.ButtonLayout.addWidget(UpdateButton)  # 添加控件
        VLayout.addWidget(UpdateButton)

        self.SubjectDetailsView.setLayout(VLayout)  # 添加布局
        self.SubjectDetailsView.show()

    # 更新信息
    def InfoWindowAction(self, ID: int, Name: str, OldName: str):
        if Name != OldName:
            Result = self.SubjectController.UpdateSubjectInfo(ID, Name)
            if Result['State'] != True:
                self.MSGBOX.ERROR(Result['Memo'])
            else:
                self.SubjectDetailsView.close()
                self.TreeDataInit()

    # 修改节点数据
    def DisableAction(self):
        Subjects = self.SubjectTree.selectedItems()
        for i in range(len(Subjects)):
            Item = Subjects[i]
            ID: int = int(Item.text(0))
            Result = self.SubjectController.SubjectDisabled(ID)
            if Result['State'] != True:
                self.TreeDataInit()
                self.MSGBOX.ERROR(Result['Memo'])
                break
            else:
                self.TreeDataInit()

    # 新建节点
    def NewSubjectWindow(self):
        self.NewSubjectView = QDialog()
        self.NewSubjectView.setWindowTitle(TITLE)
        self.NewSubjectView.setWindowModality(Qt.ApplicationModal)  # 禁止其他所有窗口交互
        self.NewSubjectView.setStyleSheet(self.SubjectStyleSheet.Dialog())  # 设置样式
        self.NewSubjectView.setFixedSize(222, 80)  # 尺寸

        VLayout = QVBoxLayout()

        NameInput = QLineEdit()  # 输入
        NameInput.setFixedHeight(30)  # 尺寸
        NameInput.setAlignment(Qt.AlignVCenter | Qt.AlignHCenter)  # 内容居中
        NameInput.setPlaceholderText(self.Lang.SubjectName)  # 设置空内容提示
        NameInput.setStyleSheet(self.SubjectStyleSheet.InputBox())  # 设置样式
        NameInput.setToolTip(self.Lang.SubjectName)  # 设置鼠标提示
        VLayout.addWidget(NameInput)  # 添加控件

        AddButton = QPushButton(self.Lang.Confirm)  # 按钮
        AddButton.setStyleSheet(self.SubjectStyleSheet.Button())  # 设置样式
        AddButton.setFixedHeight(30)  # 尺寸
        AddButton.clicked.connect(lambda: self.NewSubjectAction(NameInput.text()))  # 连接槽函数
        VLayout.addWidget(AddButton)

        self.NewSubjectView.setLayout(VLayout)  # 添加布局
        self.NewSubjectView.show()

    # 新建
    def NewSubjectAction(self, Name: str):
        if Name != '':
            Result = self.SubjectController.NewSubject(Name)
            if Result['State'] != True:
                self.MSGBOX.ERROR(Result['Memo'])
            else:
                self.NewSubjectView.close()  # 关闭窗口
                self.TreeDataInit()  # 主控件写入数据
