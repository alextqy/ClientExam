# -*- coding:utf-8 -*-
from Template.BaseTemplate import *
from StyleSheet.Manager.KnowledgeStyleSheet import *


# 知识点管理界面
class KnowledgeFrameTemplate(BaseTemplate, QFrame):

    def __init__(self):
        super().__init__()
        self.KnowledgeStyleSheet = KnowledgeStyleSheet()
        self.KnowledgeController = KnowledgeController()
        self.SubjectController = SubjectController()
        self.setStyleSheet(self.KnowledgeStyleSheet.BaseStyleSheet())  # 设置样式

        self.CenterLayout = QVBoxLayout()  # 设置主布局

        # 标题栏
        self.Headline = QLabel(self.Lang.KnowledgePoint)
        self.Headline.setAlignment(Qt.AlignVCenter | Qt.AlignHCenter)  # 字体居中
        self.Headline.adjustSize()  # 根据内容自适应宽度
        self.Headline.setFixedHeight(30)  # 尺寸
        self.Headline.setStyleSheet(self.KnowledgeStyleSheet.Headline())  # 设置样式
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
        self.CurrentPage.setStyleSheet(self.KnowledgeStyleSheet.CurrentPage())  # 设置样式
        self.PageButtonLayout.addWidget(self.CurrentPage)  # 添加控件

        # 总页码数
        self.TotalPage = QLabel(self.Lang.TotalPages + ' ' + str(self.TotalPageNo))
        self.TotalPage.setAlignment(Qt.AlignVCenter | Qt.AlignHCenter)  # 字体居中
        self.TotalPage.adjustSize()  # 根据内容自适应宽度
        self.TotalPage.setFixedSize(120, 30)  # 尺寸
        self.TotalPage.setStyleSheet(self.KnowledgeStyleSheet.CurrentPage())  # 设置样式
        self.PageButtonLayout.addWidget(self.TotalPage)  # 添加控件

        # 输入页码
        self.PageInput = QLineEdit()
        self.PageInput.setValidator(self.QIntValidator)  # 输入为整数类型
        self.PageInput.setFixedSize(170, 30)  # 尺寸
        self.PageInput.setAlignment(Qt.AlignVCenter | Qt.AlignHCenter)  # 内容居中
        self.PageInput.setPlaceholderText(self.Lang.EnterPageNumber)  # 设置空内容提示
        self.PageInput.setStyleSheet(self.KnowledgeStyleSheet.InputBox())  # 设置样式
        self.PageInput.setToolTip(self.Lang.EnterPageNumber)  # 设置鼠标提示
        self.PageButtonLayout.addWidget(self.PageInput)  # 添加控件

        # 每一页展示行数
        self.RowsInput = QLineEdit()
        self.RowsInput.setValidator(self.QIntValidator)  # 输入为整数类型
        self.RowsInput.setFixedSize(170, 30)  # 尺寸
        self.RowsInput.setAlignment(Qt.AlignVCenter | Qt.AlignHCenter)  # 内容居中
        self.RowsInput.setPlaceholderText(self.Lang.EnterTheNumberOfLines)  # 设置空内容提示
        self.RowsInput.setStyleSheet(self.KnowledgeStyleSheet.InputBox())  # 设置样式
        self.RowsInput.setToolTip(self.Lang.EnterTheNumberOfLines)  # 设置鼠标提示
        self.PageButtonLayout.addWidget(self.RowsInput)  # 添加控件

        # 搜索
        self.SearchInput = QLineEdit()
        self.SearchInput.setFixedSize(170, 30)  # 尺寸
        self.SearchInput.setAlignment(Qt.AlignVCenter | Qt.AlignHCenter)  # 内容居中
        self.SearchInput.setPlaceholderText(self.Lang.Search)  # 设置空内容提示
        self.SearchInput.setStyleSheet(self.KnowledgeStyleSheet.InputBox())  # 设置样式
        self.SearchInput.setToolTip(self.Lang.Search)  # 设置鼠标提示
        self.PageButtonLayout.addWidget(self.SearchInput)  # 添加控件

        # 状态
        self.StateSelect = QComboBox()  # 设置下拉框
        self.StateSelect.adjustSize()  # 按内容自适应宽度
        self.StateSelect.setView(QListView())  # 设置内容控件
        self.StateSelect.setFixedHeight(30)  # 尺寸
        self.StateSelect.setMinimumWidth(110)  # 尺寸
        self.StateSelect.setStyleSheet(self.KnowledgeStyleSheet.SelectBox())  # 设置样式
        self.StateSelect.insertItem(0, self.Lang.KnowledgePointStatus)  # 设置下拉内容
        self.StateSelect.setItemData(0, self.Lang.KnowledgePointStatus, Qt.ToolTipRole)  # 设置下拉内容提示
        self.StateSelect.insertItem(1, self.Lang.Normal)  # 设置下拉内容
        self.StateSelect.setItemData(1, self.Lang.Normal, Qt.ToolTipRole)  # 设置下拉内容提示
        self.StateSelect.insertItem(2, self.Lang.Disabled)  # 设置下拉内容
        self.StateSelect.setItemData(2, self.Lang.Disabled, Qt.ToolTipRole)  # 设置下拉内容提示
        self.StateSelect.setCurrentIndex(0)  # 设置默认选项
        self.PageButtonLayout.addWidget(self.StateSelect)  # 添加控件

        # 科目
        self.SubjectSelect = QComboBox()  # 设置下拉框
        self.SubjectSelect.adjustSize()  # 按内容自适应宽度
        self.SubjectSelect.setView(QListView())  # 设置内容控件
        self.SubjectSelect.setFixedHeight(30)  # 尺寸
        self.SubjectSelect.setMinimumWidth(110)  # 尺寸
        self.SubjectSelect.setStyleSheet(self.KnowledgeStyleSheet.SelectBox())  # 设置样式
        self.SubjectSelect.insertItem(0, self.Lang.Subject)  # 设置下拉内容
        self.SubjectSelect.setItemData(0, self.Lang.Subject, Qt.ToolTipRole)  # 设置下拉内容提示
        CheckSubjects = self.SubjectController.Subjects()
        if len(CheckSubjects['Data']) > 0:
            self.Subjects = CheckSubjects['Data']
            j = 1
            for i in range(len(self.Subjects)):
                Data = self.Subjects[i]
                self.SubjectSelect.insertItem(j, Data['SubjectName'])  # 设置下拉内容
                self.SubjectSelect.setItemData(j, Data['SubjectName'], Qt.ToolTipRole)  # 设置下拉内容提示
                self.SubjectSelect.setItemData(j, Data['ID'])  # 设值
                j += 1
        self.SubjectSelect.setCurrentIndex(0)  # 设置默认选项
        self.PageButtonLayout.addWidget(self.SubjectSelect)  # 添加控件

        # 确认按钮
        self.ConfirmButton = QPushButton(self.Lang.Confirm)
        self.ConfirmButton.setStyleSheet(self.KnowledgeStyleSheet.Button())  # 设置样式
        self.ConfirmButton.setFixedHeight(30)  # 尺寸
        self.ConfirmButton.clicked.connect(lambda: self.TreeDataInit())  # 连接槽函数
        self.PageButtonLayout.addWidget(self.ConfirmButton)  # 添加控件

        # =====================================================================================================================================================================

        # 页码按钮布局
        self.PNButtonLayout = QHBoxLayout()  # 设置按钮布局

        # 上一页
        self.PreviousPageButton = QPushButton(self.Lang.PreviousPage)
        self.PreviousPageButton.setStyleSheet(self.KnowledgeStyleSheet.Button())  # 设置样式
        self.PreviousPageButton.setFixedHeight(30)  # 尺寸
        self.PreviousPageButton.clicked.connect(lambda: self.SetPreviousPage())  # 连接槽函数
        self.PNButtonLayout.addWidget(self.PreviousPageButton)  # 添加控件

        # 下一页
        self.NextPageButton = QPushButton(self.Lang.NextPage)
        self.NextPageButton.setStyleSheet(self.KnowledgeStyleSheet.Button())  # 设置样式
        self.NextPageButton.setFixedHeight(30)  # 尺寸
        self.NextPageButton.clicked.connect(lambda: self.SetNextPage())  # 连接槽函数
        self.PNButtonLayout.addWidget(self.NextPageButton)  # 添加控件

        # =====================================================================================================================================================================

        self.ButtonLayout = QHBoxLayout()  # 设置按钮布局

        # 新建
        self.NewKnowledgeButton = QPushButton(self.Lang.NewKnowledgePoint)
        self.NewKnowledgeButton.setStyleSheet(self.KnowledgeStyleSheet.Button())  # 设置样式
        self.NewKnowledgeButton.setFixedHeight(30)  # 尺寸
        self.NewKnowledgeButton.clicked.connect(lambda: self.NewKnowledgeWindow())  # 连接槽函数
        self.ButtonLayout.addWidget(self.NewKnowledgeButton)  # 添加控件

        # 刷新
        self.RefreshButton = QPushButton(self.Lang.Refresh)
        self.RefreshButton.setStyleSheet(self.KnowledgeStyleSheet.Button())  # 设置样式
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
        SubjectID = self.SubjectSelect.currentIndex()
        Result = self.KnowledgeController.KnowledgeList(Page, PageSize, Stext, SubjectID, State)
        self.TotalPageNo = Result['TotalPage']
        self.TotalPage.setText(self.Lang.TotalPages + ' ' + str(self.TotalPageNo))

        if Result['State'] != True:
            self.MSGBOX.ERROR(Result['Memo'])
        else:
            Data = Result['Data']

            # 树状列表
            self.KnowledgeTree = BaseTreeWidget()
            self.KnowledgeTree.SetSelectionMode(2)  # 设置选择模式
            self.KnowledgeTree.setStyleSheet(self.KnowledgeStyleSheet.TreeWidget())  # 设置样式
            self.KnowledgeTree.setColumnCount(7)  # 设置列数
            self.KnowledgeTree.hideColumn(4)  # 隐藏列
            self.KnowledgeTree.hideColumn(5)  # 隐藏列
            self.KnowledgeTree.hideColumn(6)  # 隐藏列
            self.KnowledgeTree.setHeaderLabels(['ID', self.Lang.KnowledgePointName, self.Lang.KnowledgePointStatus, self.Lang.CreationTime, 'UpdateTime', 'SubjectID', 'KnowledgeCode'])  # 设置标题栏
            # self.KnowledgeTree.header().setSectionResizeMode(0, QHeaderView.ResizeToContents)  # 列宽自适应数据长度
            self.KnowledgeTree.Connect(self.RightContextMenuExec)  # 鼠标右键菜单 链接槽函数
            self.TreeLayout.addWidget(self.KnowledgeTree)  # 添加控件

            if len(Data) > 0:
                TreeItems = []
                for i in range(len(Data)):
                    item = QTreeWidgetItem()  # 设置item控件
                    # item.setIcon(0, QtGui.QIcon(os.getcwd() + '/avatar.png'))
                    item.setText(0, str(Data[i]['ID']))  # 设置内容
                    item.setText(1, Data[i]['KnowledgeName'])  # 设置内容
                    if Data[i]['KnowledgeState'] == 1:
                        item.setText(2, self.Lang.Normal)  # 设置内容
                    else:
                        item.setText(2, self.Lang.Disabled)  # 设置内容
                    item.setText(3, self.Common.TimeToStr(Data[i]['CreateTime']))  # 设置内容
                    item.setText(4, str(Data[i]['UpdateTime']))  # 设置内容
                    item.setText(5, str(Data[i]['SubjectID']))  # 设置内容
                    item.setText(6, Data[i]['KnowledgeCode'])  # 设置内容
                    item.setTextAlignment(0, Qt.AlignHCenter | Qt.AlignVCenter)  # 设置item字体居中
                    item.setTextAlignment(1, Qt.AlignHCenter | Qt.AlignVCenter)  # 设置item字体居中
                    item.setTextAlignment(2, Qt.AlignHCenter | Qt.AlignVCenter)  # 设置item字体居中
                    item.setTextAlignment(3, Qt.AlignHCenter | Qt.AlignVCenter)  # 设置item字体居中
                    item.setTextAlignment(4, Qt.AlignHCenter | Qt.AlignVCenter)  # 设置item字体居中
                    item.setTextAlignment(5, Qt.AlignHCenter | Qt.AlignVCenter)  # 设置item字体居中
                    item.setTextAlignment(6, Qt.AlignHCenter | Qt.AlignVCenter)  # 设置item字体居中
                    TreeItems.append(item)  # 添加到item list
                self.KnowledgeTree.insertTopLevelItems(0, TreeItems)  # 添加到列表

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
        self.TreeMenu.setStyleSheet(self.KnowledgeStyleSheet.TreeMenu())  # 设置样式
        Item = self.KnowledgeTree.currentItem()  # 获取被点击行控件
        ItemAt = self.KnowledgeTree.itemAt(pos)  # 获取点击焦点

        # 展示判断
        if type(Item) == QTreeWidgetItem and type(ItemAt) == QTreeWidgetItem:  # 焦点内
            self.TreeMenu.AddAction(self.Lang.KnowledgeDetails, lambda: self.InfoWindow(Item))
            self.TreeMenu.AddAction(self.Lang.Disable, lambda: self.DisableAction())
        else:  # 焦点外
            return

        self.TreeMenu.move(QCursor().pos())  # 移动到焦点
        self.TreeMenu.show()  # 展示

    # 节点数据详情
    def InfoWindow(self, Item):
        ID: int = int(Item.text(0))
        Name: str = Item.text(1)
        UpdateTime: int = Item.text(4)
        SubjectID: int = Item.text(5)
        KnowledgeCode: str = Item.text(6)
        SubjectName: str = ''

        Result = self.SubjectController.SubjectInfo(SubjectID)
        if Result['State'] == True:
            SubjectName = Result['Data']['SubjectName']

        self.KnowledgeDetailsView = QDialog()
        self.KnowledgeDetailsView.setWindowTitle(TITLE)
        self.KnowledgeDetailsView.setWindowModality(Qt.ApplicationModal)  # 禁止其他所有窗口交互
        self.KnowledgeDetailsView.setStyleSheet(self.KnowledgeStyleSheet.Dialog())  # 设置样式
        self.KnowledgeDetailsView.setFixedSize(322, 196)  # 尺寸

        VLayout = QVBoxLayout()

        NameInput = QLineEdit()  # 输入
        NameInput.setText(Name)  # 设置内容
        NameInput.setFixedHeight(30)  # 尺寸
        NameInput.setAlignment(Qt.AlignVCenter | Qt.AlignHCenter)  # 内容居中
        NameInput.setPlaceholderText(self.Lang.KnowledgePointName)  # 设置空内容提示
        NameInput.setStyleSheet(self.KnowledgeStyleSheet.InputBox())  # 设置样式
        NameInput.setToolTip(self.Lang.KnowledgePointName)  # 设置鼠标提示
        VLayout.addWidget(NameInput)  # 添加控件

        SubjectInput = QLineEdit()  # 输入
        SubjectInput.setText(SubjectName)  # 设置内容
        SubjectInput.setFixedHeight(30)  # 尺寸
        SubjectInput.setAlignment(Qt.AlignVCenter | Qt.AlignHCenter)  # 内容居中
        SubjectInput.setPlaceholderText(self.Lang.Subject)  # 设置空内容提示
        SubjectInput.setStyleSheet(self.KnowledgeStyleSheet.InputBox())  # 设置样式
        SubjectInput.setToolTip(self.Lang.Subject)  # 设置鼠标提示
        SubjectInput.setEnabled(False)  # 禁止输入
        VLayout.addWidget(SubjectInput)  # 添加控件

        KnowledgeCodeInput = QLineEdit()
        KnowledgeCodeInput.setText(KnowledgeCode)  # 设置内容
        KnowledgeCodeInput.setFixedHeight(30)  # 尺寸
        KnowledgeCodeInput.setAlignment(Qt.AlignVCenter | Qt.AlignHCenter)  # 内容居中
        KnowledgeCodeInput.setPlaceholderText(self.Lang.KnowledgePointCode)  # 设置空内容提示
        KnowledgeCodeInput.setStyleSheet(self.KnowledgeStyleSheet.InputBox())  # 设置样式
        KnowledgeCodeInput.setToolTip(self.Lang.KnowledgePointCode)  # 设置鼠标提示
        KnowledgeCodeInput.setEnabled(False)  # 禁止输入
        VLayout.addWidget(KnowledgeCodeInput)  # 添加控件

        UpdateTimeInput = QLineEdit()
        UpdateTimeInput.setText(self.Common.TimeToStr(UpdateTime))  # 设置内容
        UpdateTimeInput.setFixedHeight(30)  # 尺寸
        UpdateTimeInput.setAlignment(Qt.AlignVCenter | Qt.AlignHCenter)  # 内容居中
        UpdateTimeInput.setPlaceholderText(self.Lang.UpdateTime)  # 设置空内容提示
        UpdateTimeInput.setStyleSheet(self.KnowledgeStyleSheet.InputBox())  # 设置样式
        UpdateTimeInput.setToolTip(self.Lang.UpdateTime)  # 设置鼠标提示
        UpdateTimeInput.setEnabled(False)  # 禁止输入
        VLayout.addWidget(UpdateTimeInput)  # 添加控件

        UpdateButton = QPushButton(self.Lang.Confirm)  # 按钮
        UpdateButton.setStyleSheet(self.KnowledgeStyleSheet.Button())  # 设置样式
        UpdateButton.setFixedHeight(30)  # 尺寸
        UpdateButton.clicked.connect(lambda: self.InfoWindowAction(ID, NameInput.text(), Name))  # 连接槽函数
        self.ButtonLayout.addWidget(UpdateButton)  # 添加控件
        VLayout.addWidget(UpdateButton)

        self.KnowledgeDetailsView.setLayout(VLayout)  # 添加布局
        self.KnowledgeDetailsView.show()

    # 更新信息
    def InfoWindowAction(self, ID: int, Name: str, OldName: str):
        if Name != OldName:
            Result = self.KnowledgeController.UpdateKnowledgeInfo(ID, Name)
            if Result['State'] != True:
                self.MSGBOX.ERROR(Result['Memo'])
            else:
                self.KnowledgeDetailsView.close()
                self.TreeDataInit()

    # 修改节点数据
    def DisableAction(self):
        Knowledge = self.KnowledgeTree.selectedItems()
        for i in range(len(Knowledge)):
            Item = Knowledge[i]
            ID: int = int(Item.text(0))
            Result = self.KnowledgeController.KnowledgeDisabled(ID)
            if Result['State'] != True:
                self.TreeDataInit()
                self.MSGBOX.ERROR(Result['Memo'])
                break
            else:
                self.TreeDataInit()

    # 新建节点
    def NewKnowledgeWindow(self):
        CheckSubjects = self.SubjectController.Subjects()
        if CheckSubjects['State'] != True and len(CheckSubjects['Data']) == 0:
            self.MSGBOX.WARNING(self.Lang.NoDataAvailable)
        else:
            self.NewKnowledgeView = QDialog()
            self.NewKnowledgeView.setWindowTitle(TITLE)
            self.NewKnowledgeView.setWindowModality(Qt.ApplicationModal)  # 禁止其他所有窗口交互
            self.NewKnowledgeView.setStyleSheet(self.KnowledgeStyleSheet.Dialog())  # 设置样式
            self.NewKnowledgeView.setFixedSize(222, 124)  # 尺寸

            VLayout = QVBoxLayout()

            NameInput = QLineEdit()  # 输入
            NameInput.setFixedHeight(30)  # 尺寸
            NameInput.setAlignment(Qt.AlignVCenter | Qt.AlignHCenter)  # 内容居中
            NameInput.setPlaceholderText(self.Lang.KnowledgePointName)  # 设置空内容提示
            NameInput.setStyleSheet(self.KnowledgeStyleSheet.InputBox())  # 设置样式
            NameInput.setToolTip(self.Lang.KnowledgePointName)  # 设置鼠标提示
            VLayout.addWidget(NameInput)  # 添加控件

            self.SubjectSelectButton = QPushButton(self.Lang.Subject)  # 按钮
            self.SubjectSelectButton.setStyleSheet(self.KnowledgeStyleSheet.Button())  # 设置样式
            self.SubjectSelectButton.setFixedHeight(30)  # 尺寸
            self.SubjectSelectButton.clicked.connect(lambda: self.ChooseSubjects(CheckSubjects['Data']))  # 连接槽函数
            self.SubjectSelectButton.setWhatsThis('0')  # 设置默认值
            VLayout.addWidget(self.SubjectSelectButton)

            AddButton = QPushButton(self.Lang.Confirm)  # 按钮
            AddButton.setStyleSheet(self.KnowledgeStyleSheet.Button())  # 设置样式
            AddButton.setFixedHeight(30)  # 尺寸
            AddButton.clicked.connect(lambda: self.NewKnowledgeAction(NameInput.text(), int(self.SubjectSelectButton.whatsThis())))  # 连接槽函数
            VLayout.addWidget(AddButton)

            self.NewKnowledgeView.setLayout(VLayout)  # 添加布局
            self.NewKnowledgeView.show()

    # 科目选择
    def ChooseSubjects(self, Subjects: list):
        self.SubjectsWindow = SubjectsWindow(Subjects)
        self.SubjectsWindow.ActionSignal.connect(self.SetSubject)
        self.SubjectsWindow.show()

    # 设置科目
    def SetSubject(self, SubjectName: str, SubjectID: str):
        if SubjectName != '' and SubjectID != '':
            self.SubjectSelectButton.setText(SubjectName)
            self.SubjectSelectButton.setWhatsThis(SubjectID)

    # 新建
    def NewKnowledgeAction(self, Name: str, SubjectID: int):
        if Name != '' and SubjectID > 0:
            Result = self.KnowledgeController.NewKnowledge(Name, SubjectID)
            if Result['State'] != True:
                self.MSGBOX.ERROR(Result['Memo'])
            else:
                self.NewKnowledgeView.close()  # 关闭窗口
                self.TreeDataInit()  # 主控件写入数据


# 选择科目
class SubjectsWindow(BaseTemplate, QDialog):
    ActionSignal = Signal(str, str)  # 设置信号

    def __init__(self, SubjectList: list):
        super().__init__()
        self.KnowledgeStyleSheet = KnowledgeStyleSheet()
        self.setWindowTitle(TITLE)
        self.setFixedSize(266, 274)  # 尺寸
        self.setWindowModality(Qt.ApplicationModal)  # 禁止其他所有窗口交互
        self.setStyleSheet(self.KnowledgeStyleSheet.Dialog())  # 设置样式
        self.VLayout = QVBoxLayout()
        self.HLayout = QHBoxLayout()
        self.VLayout.addLayout(self.HLayout)
        self.setLayout(self.VLayout)

        self.SearchBar = QLineEdit()
        self.SearchBar.setFixedHeight(30)
        self.SearchBar.setPlaceholderText(self.Lang.Name)
        self.SearchBar.setAlignment(Qt.AlignVCenter | Qt.AlignHCenter)  # 字体居中
        self.SearchBar.setStyleSheet(self.KnowledgeStyleSheet.InputBox())
        self.HLayout.addWidget(self.SearchBar)
        self.SearchButton = QPushButton(self.Lang.Search)
        self.SearchButton.setFixedWidth(90)
        self.SearchButton.setFixedHeight(30)
        self.SearchButton.setStyleSheet(self.KnowledgeStyleSheet.Button())
        self.SearchButton.clicked.connect(self.SearchName)
        self.HLayout.addWidget(self.SearchButton)

        self.Tree = QListWidget()
        # self.Tree.setSelectionMode(QAbstractItemView.ExtendedSelection)  # 设置多选
        self.Tree.setStyleSheet(self.KnowledgeStyleSheet.List())
        self.Tree.setFocusPolicy(Qt.NoFocus)
        self.VLayout.addWidget(self.Tree)

        self.SubmitButton = QPushButton(self.Lang.Submit)
        self.SubmitButton.setFixedHeight(30)
        self.SubmitButton.setStyleSheet(self.KnowledgeStyleSheet.Button())
        self.SubmitButton.clicked.connect(self.Send)
        self.VLayout.addWidget(self.SubmitButton)

        self.SubjectList = SubjectList
        if len(self.SubjectList) > 0:
            for i in range(len(self.SubjectList)):
                Item = QListWidgetItem()
                Item.setSizeHint(QSize(200, 30))
                Item.setText(self.SubjectList[i]['SubjectName'])
                Item.setWhatsThis(str(self.SubjectList[i]['ID']))
                self.Tree.addItem(Item)

    # 搜索
    def SearchName(self):
        Name = self.SearchBar.text()
        if Name != '':
            SearchList = self.Tree.findItems(Name, Qt.MatchContains)
            if len(SearchList) > 0:
                for i in range(len(SearchList)):
                    if SearchList[i].text() != self.Cache.Get('SubjectName'):
                        self.Tree.setCurrentItem(SearchList[i])

    # 发送
    def Send(self):
        SubjectItem = self.Tree.currentItem()
        if SubjectItem is not None and SubjectItem.text() != '' and SubjectItem.whatsThis() != '':
            self.ActionSignal.emit(SubjectItem.text(), SubjectItem.whatsThis())
            self.close()
