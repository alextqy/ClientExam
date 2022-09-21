# -*- coding:utf-8 -*-
from Template.BaseTemplate import *
from StyleSheet.Manager.PaperStyleSheet import *


# 试卷管理界面
class PaperFrameTemplate(BaseTemplate, QFrame):

    def __init__(self):
        super().__init__()
        self.PaperStyleSheet = PaperStyleSheet()
        self.PaperController = PaperController()
        self.SubjectController = SubjectController()
        self.setStyleSheet(self.PaperStyleSheet.BaseStyleSheet())  # 设置样式

        self.CenterLayout = QVBoxLayout()  # 设置主布局

        # 标题栏
        self.Headline = QLabel(self.Lang.TestPaper)
        self.Headline.setAlignment(Qt.AlignVCenter | Qt.AlignHCenter)  # 字体居中
        self.Headline.adjustSize()  # 根据内容自适应宽度
        self.Headline.setFixedHeight(30)  # 尺寸
        self.Headline.setStyleSheet(self.PaperStyleSheet.Headline())  # 设置样式
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
        self.CurrentPage.setStyleSheet(self.PaperStyleSheet.CurrentPage())  # 设置样式
        self.PageButtonLayout.addWidget(self.CurrentPage)  # 添加控件

        # 总页码数
        self.TotalPage = QLabel(self.Lang.TotalPages + ' ' + str(self.TotalPageNo))
        self.TotalPage.setAlignment(Qt.AlignVCenter | Qt.AlignHCenter)  # 字体居中
        self.TotalPage.adjustSize()  # 根据内容自适应宽度
        self.TotalPage.setFixedSize(120, 30)  # 尺寸
        self.TotalPage.setStyleSheet(self.PaperStyleSheet.CurrentPage())  # 设置样式
        self.PageButtonLayout.addWidget(self.TotalPage)  # 添加控件

        # 输入页码
        self.PageInput = QLineEdit()
        self.PageInput.setValidator(self.QIntValidator)  # 输入为整数类型
        self.PageInput.setFixedSize(170, 30)  # 尺寸
        self.PageInput.setAlignment(Qt.AlignVCenter | Qt.AlignHCenter)  # 内容居中
        self.PageInput.setPlaceholderText(self.Lang.EnterPageNumber)  # 设置空内容提示
        self.PageInput.setStyleSheet(self.PaperStyleSheet.InputBox())  # 设置样式
        self.PageInput.setToolTip(self.Lang.EnterPageNumber)  # 设置鼠标提示
        self.PageButtonLayout.addWidget(self.PageInput)  # 添加控件

        # 每一页展示行数
        self.RowsInput = QLineEdit()
        self.RowsInput.setValidator(self.QIntValidator)  # 输入为整数类型
        self.RowsInput.setFixedSize(170, 30)  # 尺寸
        self.RowsInput.setAlignment(Qt.AlignVCenter | Qt.AlignHCenter)  # 内容居中
        self.RowsInput.setPlaceholderText(self.Lang.EnterTheNumberOfLines)  # 设置空内容提示
        self.RowsInput.setStyleSheet(self.PaperStyleSheet.InputBox())  # 设置样式
        self.RowsInput.setToolTip(self.Lang.EnterTheNumberOfLines)  # 设置鼠标提示
        self.PageButtonLayout.addWidget(self.RowsInput)  # 添加控件

        # 搜索
        self.SearchInput = QLineEdit()
        self.SearchInput.setFixedSize(170, 30)  # 尺寸
        self.SearchInput.setAlignment(Qt.AlignVCenter | Qt.AlignHCenter)  # 内容居中
        self.SearchInput.setPlaceholderText(self.Lang.Search)  # 设置空内容提示
        self.SearchInput.setStyleSheet(self.PaperStyleSheet.InputBox())  # 设置样式
        self.SearchInput.setToolTip(self.Lang.Search)  # 设置鼠标提示
        self.PageButtonLayout.addWidget(self.SearchInput)  # 添加控件

        # 状态
        self.StateSelect = QComboBox()  # 设置下拉框
        self.StateSelect.adjustSize()  # 按内容自适应宽度
        self.StateSelect.setView(QListView())  # 设置内容控件
        self.StateSelect.setFixedHeight(30)  # 尺寸
        self.StateSelect.setMinimumWidth(110)  # 尺寸
        self.StateSelect.setStyleSheet(self.PaperStyleSheet.SelectBox())  # 设置样式
        self.StateSelect.insertItem(0, self.Lang.ExamPaperStatus)  # 设置下拉内容
        self.StateSelect.setItemData(0, self.Lang.ExamPaperStatus, Qt.ToolTipRole)  # 设置下拉内容提示
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
        self.SubjectSelect.setStyleSheet(self.PaperStyleSheet.SelectBox())  # 设置样式
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
        self.ConfirmButton.setStyleSheet(self.PaperStyleSheet.Button())  # 设置样式
        self.ConfirmButton.setFixedHeight(30)  # 尺寸
        self.ConfirmButton.clicked.connect(lambda: self.TreeDataInit())  # 连接槽函数
        self.PageButtonLayout.addWidget(self.ConfirmButton)  # 添加控件

        # =====================================================================================================================================================================

        # 页码按钮布局
        self.PNButtonLayout = QHBoxLayout()  # 设置按钮布局

        # 上一页
        self.PreviousPageButton = QPushButton(self.Lang.PreviousPage)
        self.PreviousPageButton.setStyleSheet(self.PaperStyleSheet.Button())  # 设置样式
        self.PreviousPageButton.setFixedHeight(30)  # 尺寸
        self.PreviousPageButton.clicked.connect(lambda: self.SetPreviousPage())  # 连接槽函数
        self.PNButtonLayout.addWidget(self.PreviousPageButton)  # 添加控件

        # 下一页
        self.NextPageButton = QPushButton(self.Lang.NextPage)
        self.NextPageButton.setStyleSheet(self.PaperStyleSheet.Button())  # 设置样式
        self.NextPageButton.setFixedHeight(30)  # 尺寸
        self.NextPageButton.clicked.connect(lambda: self.SetNextPage())  # 连接槽函数
        self.PNButtonLayout.addWidget(self.NextPageButton)  # 添加控件

        # =====================================================================================================================================================================

        self.ButtonLayout = QHBoxLayout()  # 设置按钮布局

        # 新建
        self.NewPaperButton = QPushButton(self.Lang.NewTestPaper)
        self.NewPaperButton.setStyleSheet(self.PaperStyleSheet.Button())  # 设置样式
        self.NewPaperButton.setFixedHeight(30)  # 尺寸
        self.NewPaperButton.clicked.connect(lambda: self.NewPaperWindow())  # 连接槽函数
        self.ButtonLayout.addWidget(self.NewPaperButton)  # 添加控件

        # 刷新
        self.RefreshButton = QPushButton(self.Lang.Refresh)
        self.RefreshButton.setStyleSheet(self.PaperStyleSheet.Button())  # 设置样式
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
        SubjectID = self.SubjectSelect.currentIndex()
        State = self.StateSelect.currentIndex()
        Result = self.PaperController.PaperList(Page, PageSize, Stext, SubjectID, State)
        self.TotalPageNo = Result['TotalPage']
        self.TotalPage.setText(self.Lang.TotalPages + ' ' + str(self.TotalPageNo))

        if Result['State'] != True:
            self.MSGBOX.ERROR(Result['Memo'])
        else:
            Data = Result['Data']

            # 树状列表
            self.PaperTree = BaseTreeWidget()
            self.PaperTree.SetSelectionMode(2)  # 设置选择模式
            self.PaperTree.setStyleSheet(self.PaperStyleSheet.TreeWidget())  # 设置样式
            self.PaperTree.setColumnCount(11)  # 设置列数
            self.PaperTree.hideColumn(2)  # 隐藏列
            self.PaperTree.hideColumn(8)  # 隐藏列
            self.PaperTree.hideColumn(9)  # 隐藏列
            self.PaperTree.setHeaderLabels([
                'ID',
                self.Lang.PaperName,
                self.Lang.TestPaperCode,
                self.Lang.TotalScore,
                self.Lang.PassLine,
                self.Lang.ExamDuration,
                self.Lang.ExamPaperStatus,
                self.Lang.CreationTime,
                'SubjectID',
                'UpdateTime',
                self.Lang.SubjectName,
            ])  # 设置标题栏
            # self.PaperTree.header().setSectionResizeMode(0, QHeaderView.ResizeToContents)  # 列宽自适应数据长度
            self.PaperTree.Connect(self.RightContextMenuExec)  # 鼠标右键菜单 链接槽函数
            self.TreeLayout.addWidget(self.PaperTree)  # 添加控件

            if len(Data) > 0:
                TreeItems = []
                for i in range(len(Data)):
                    item = QTreeWidgetItem()  # 设置item控件
                    # item.setIcon(0, QtGui.QIcon(os.getcwd() + '/avatar.png'))
                    item.setText(0, str(Data[i]['ID']))  # 设置内容
                    item.setText(1, Data[i]['PaperName'])  # 设置内容
                    item.setText(2, Data[i]['PaperCode'])  # 设置内容
                    item.setText(3, str(Data[i]['TotalScore']))  # 设置内容
                    item.setText(4, str(Data[i]['PassLine']))  # 设置内容
                    item.setText(5, str(Data[i]['ExamDuration']))  # 设置内容
                    if Data[i]['PaperState'] == 1:
                        item.setText(6, self.Lang.Normal)  # 设置内容
                    else:
                        item.setText(6, self.Lang.Disabled)  # 设置内容
                    item.setText(7, self.Common.TimeToStr(Data[i]['CreateTime']))  # 设置内容
                    item.setText(8, str(Data[i]['SubjectID']))  # 设置内容
                    item.setText(9, str(Data[i]['UpdateTime']))  # 设置内容
                    item.setText(10, Data[i]['SubjectName'])  # 设置内容
                    item.setTextAlignment(0, Qt.AlignHCenter | Qt.AlignVCenter)  # 设置item字体居中
                    item.setTextAlignment(1, Qt.AlignHCenter | Qt.AlignVCenter)  # 设置item字体居中
                    item.setTextAlignment(2, Qt.AlignHCenter | Qt.AlignVCenter)  # 设置item字体居中
                    item.setTextAlignment(3, Qt.AlignHCenter | Qt.AlignVCenter)  # 设置item字体居中
                    item.setTextAlignment(4, Qt.AlignHCenter | Qt.AlignVCenter)  # 设置item字体居中
                    item.setTextAlignment(5, Qt.AlignHCenter | Qt.AlignVCenter)  # 设置item字体居中
                    item.setTextAlignment(6, Qt.AlignHCenter | Qt.AlignVCenter)  # 设置item字体居中
                    item.setTextAlignment(7, Qt.AlignHCenter | Qt.AlignVCenter)  # 设置item字体居中
                    item.setTextAlignment(8, Qt.AlignHCenter | Qt.AlignVCenter)  # 设置item字体居中
                    item.setTextAlignment(9, Qt.AlignHCenter | Qt.AlignVCenter)  # 设置item字体居中
                    item.setTextAlignment(10, Qt.AlignHCenter | Qt.AlignVCenter)  # 设置item字体居中
                    TreeItems.append(item)  # 添加到item list
                self.PaperTree.insertTopLevelItems(0, TreeItems)  # 添加到列表

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
        self.TreeMenu.setStyleSheet(self.PaperStyleSheet.TreeMenu())  # 设置样式
        Item = self.PaperTree.currentItem()  # 获取被点击行控件
        ItemAt = self.PaperTree.itemAt(pos)  # 获取点击焦点

        # 展示判断
        if type(Item) == QTreeWidgetItem and type(ItemAt) == QTreeWidgetItem:  # 焦点内
            self.TreeMenu.AddAction(self.Lang.PaperDetails, lambda: self.InfoWindow(Item))
            self.TreeMenu.AddAction(self.Lang.TestPaperRules, lambda: self.TestPaperRulesWindow(Item))
            self.TreeMenu.AddAction(self.Lang.Disable, lambda: self.DisableAction())
        else:  # 焦点外
            return

        self.TreeMenu.move(QCursor().pos())  # 移动到焦点
        self.TreeMenu.show()  # 展示

    # 节点数据详情
    def InfoWindow(self, Item):
        ID: int = int(Item.text(0))
        PaperName: str = Item.text(1)
        PaperCode: int = Item.text(2)
        TotalScore: int = Item.text(3)
        PassLine: int = Item.text(4)
        ExamDuration: int = Item.text(5)
        SubjectID: int = Item.text(8)
        UpdateTime: int = Item.text(9)
        SubjectName: str = ''

        Result = self.SubjectController.SubjectInfo(SubjectID)
        if Result['State'] == True:
            SubjectName = Result['Data']['SubjectName']

        self.PaperDetailsView = QDialog()
        self.PaperDetailsView.setWindowTitle(TITLE)
        self.PaperDetailsView.setWindowModality(Qt.ApplicationModal)  # 禁止其他所有窗口交互
        self.PaperDetailsView.setStyleSheet(self.PaperStyleSheet.Dialog())  # 设置样式
        self.PaperDetailsView.setFixedSize(322, 304)  # 尺寸

        VLayout = QVBoxLayout()

        PaperNameInput = QLineEdit()  # 输入
        PaperNameInput.setText(PaperName)  # 设置内容
        PaperNameInput.setFixedHeight(30)  # 尺寸
        PaperNameInput.setAlignment(Qt.AlignVCenter | Qt.AlignHCenter)  # 内容居中
        PaperNameInput.setPlaceholderText(self.Lang.PaperName)  # 设置空内容提示
        PaperNameInput.setStyleSheet(self.PaperStyleSheet.InputBox())  # 设置样式
        PaperNameInput.setToolTip(self.Lang.PaperName)  # 设置鼠标提示
        VLayout.addWidget(PaperNameInput)  # 添加控件

        TotalScoreInput = QLineEdit()
        TotalScoreInput.setText(TotalScore)  # 设置内容
        TotalScoreInput.setFixedHeight(30)  # 尺寸
        TotalScoreInput.setAlignment(Qt.AlignVCenter | Qt.AlignHCenter)  # 内容居中
        TotalScoreInput.setPlaceholderText(self.Lang.TotalScore)  # 设置空内容提示
        TotalScoreInput.setStyleSheet(self.PaperStyleSheet.InputBox())  # 设置样式
        TotalScoreInput.setToolTip(self.Lang.TotalScore)  # 设置鼠标提示
        VLayout.addWidget(TotalScoreInput)  # 添加控件

        PassLineInput = QLineEdit()
        PassLineInput.setText(PassLine)  # 设置内容
        PassLineInput.setFixedHeight(30)  # 尺寸
        PassLineInput.setAlignment(Qt.AlignVCenter | Qt.AlignHCenter)  # 内容居中
        PassLineInput.setPlaceholderText(self.Lang.PassLine)  # 设置空内容提示
        PassLineInput.setStyleSheet(self.PaperStyleSheet.InputBox())  # 设置样式
        PassLineInput.setToolTip(self.Lang.PassLine)  # 设置鼠标提示
        VLayout.addWidget(PassLineInput)  # 添加控件

        ExamDurationInput = QLineEdit()
        ExamDurationInput.setText(ExamDuration)  # 设置内容
        ExamDurationInput.setFixedHeight(30)  # 尺寸
        ExamDurationInput.setAlignment(Qt.AlignVCenter | Qt.AlignHCenter)  # 内容居中
        ExamDurationInput.setPlaceholderText(self.Lang.ExamDuration)  # 设置空内容提示
        ExamDurationInput.setStyleSheet(self.PaperStyleSheet.InputBox())  # 设置样式
        ExamDurationInput.setToolTip(self.Lang.ExamDuration)  # 设置鼠标提示
        VLayout.addWidget(ExamDurationInput)  # 添加控件

        PaperCodeInput = QLineEdit()  # 输入
        PaperCodeInput.setText(PaperCode)  # 设置内容
        PaperCodeInput.setFixedHeight(30)  # 尺寸
        PaperCodeInput.setAlignment(Qt.AlignVCenter | Qt.AlignHCenter)  # 内容居中
        PaperCodeInput.setPlaceholderText(self.Lang.TestPaperCode)  # 设置空内容提示
        PaperCodeInput.setStyleSheet(self.PaperStyleSheet.InputBox())  # 设置样式
        PaperCodeInput.setToolTip(self.Lang.TestPaperCode)  # 设置鼠标提示
        PaperCodeInput.setEnabled(False)  # 禁止输入
        VLayout.addWidget(PaperCodeInput)  # 添加控件

        SubjectInput = QLineEdit()  # 输入
        SubjectInput.setText(SubjectName)  # 设置内容
        SubjectInput.setFixedHeight(30)  # 尺寸
        SubjectInput.setAlignment(Qt.AlignVCenter | Qt.AlignHCenter)  # 内容居中
        SubjectInput.setPlaceholderText(self.Lang.Subject)  # 设置空内容提示
        SubjectInput.setStyleSheet(self.PaperStyleSheet.InputBox())  # 设置样式
        SubjectInput.setToolTip(self.Lang.Subject)  # 设置鼠标提示
        SubjectInput.setEnabled(False)  # 禁止输入
        VLayout.addWidget(SubjectInput)  # 添加控件

        UpdateTimeInput = QLineEdit()
        UpdateTimeInput.setText(self.Common.TimeToStr(UpdateTime))  # 设置内容
        UpdateTimeInput.setFixedHeight(30)  # 尺寸
        UpdateTimeInput.setAlignment(Qt.AlignVCenter | Qt.AlignHCenter)  # 内容居中
        UpdateTimeInput.setPlaceholderText(self.Lang.UpdateTime)  # 设置空内容提示
        UpdateTimeInput.setStyleSheet(self.PaperStyleSheet.InputBox())  # 设置样式
        UpdateTimeInput.setToolTip(self.Lang.UpdateTime)  # 设置鼠标提示
        UpdateTimeInput.setEnabled(False)  # 禁止输入
        VLayout.addWidget(UpdateTimeInput)  # 添加控件

        UpdateButton = QPushButton(self.Lang.Confirm)  # 按钮
        UpdateButton.setStyleSheet(self.PaperStyleSheet.Button())  # 设置样式
        UpdateButton.setFixedHeight(30)  # 尺寸
        UpdateButton.clicked.connect(lambda: self.InfoWindowAction(ID, PaperNameInput.text(), TotalScoreInput.text(), PassLineInput.text(), ExamDurationInput.text()))  # 连接槽函数
        self.ButtonLayout.addWidget(UpdateButton)  # 添加控件
        VLayout.addWidget(UpdateButton)

        self.PaperDetailsView.setLayout(VLayout)  # 添加布局
        self.PaperDetailsView.show()

    # 更新信息
    def InfoWindowAction(self, ID: int, PaperName: str, TotalScore: float, PassLine: float, ExamDuration: int):
        Result = self.PaperController.UpdatePaperInfo(ID, PaperName, TotalScore, PassLine, ExamDuration)
        if Result['State'] != True:
            self.MSGBOX.ERROR(Result['Memo'])
        else:
            self.PaperDetailsView.close()
            self.TreeDataInit()

    # 修改节点数据
    def DisableAction(self):
        Papers = self.PaperTree.selectedItems()
        for i in range(len(Papers)):
            Item = Papers[i]
            ID: int = int(Item.text(0))
            Result = self.PaperController.PaperDisabled(ID)
            if Result['State'] != True:
                self.TreeDataInit()
                self.MSGBOX.ERROR(Result['Memo'])
                break
            else:
                self.TreeDataInit()

    # 新建节点
    def NewPaperWindow(self):
        CheckSubjects = self.SubjectController.Subjects()
        if CheckSubjects['State'] != True and len(CheckSubjects['Data']) == 0:
            self.MSGBOX.WARNING(self.Lang.NoDataAvailable)
        else:
            self.NewPaperView = QDialog()
            self.NewPaperView.setWindowTitle(TITLE)
            self.NewPaperView.setWindowModality(Qt.ApplicationModal)  # 禁止其他所有窗口交互
            self.NewPaperView.setStyleSheet(self.PaperStyleSheet.Dialog())  # 设置样式
            self.NewPaperView.setFixedSize(222, 232)  # 尺寸

            VLayout = QVBoxLayout()

            PaperNameInput = QLineEdit()  # 输入
            PaperNameInput.setFixedHeight(30)  # 尺寸
            PaperNameInput.setAlignment(Qt.AlignVCenter | Qt.AlignHCenter)  # 内容居中
            PaperNameInput.setPlaceholderText(self.Lang.PaperName)  # 设置空内容提示
            PaperNameInput.setStyleSheet(self.PaperStyleSheet.InputBox())  # 设置样式
            PaperNameInput.setToolTip(self.Lang.PaperName)  # 设置鼠标提示
            VLayout.addWidget(PaperNameInput)  # 添加控件

            TotalScoreInput = QLineEdit()
            TotalScoreInput.setFixedHeight(30)  # 尺寸
            TotalScoreInput.setAlignment(Qt.AlignVCenter | Qt.AlignHCenter)  # 内容居中
            TotalScoreInput.setPlaceholderText(self.Lang.TotalScore)  # 设置空内容提示
            TotalScoreInput.setStyleSheet(self.PaperStyleSheet.InputBox())  # 设置样式
            TotalScoreInput.setToolTip(self.Lang.TotalScore)  # 设置鼠标提示
            VLayout.addWidget(TotalScoreInput)  # 添加控件

            PassLineInput = QLineEdit()
            PassLineInput.setFixedHeight(30)  # 尺寸
            PassLineInput.setAlignment(Qt.AlignVCenter | Qt.AlignHCenter)  # 内容居中
            PassLineInput.setPlaceholderText(self.Lang.PassLine)  # 设置空内容提示
            PassLineInput.setStyleSheet(self.PaperStyleSheet.InputBox())  # 设置样式
            PassLineInput.setToolTip(self.Lang.PassLine)  # 设置鼠标提示
            VLayout.addWidget(PassLineInput)  # 添加控件

            ExamDurationInput = QLineEdit()
            ExamDurationInput.setFixedHeight(30)  # 尺寸
            ExamDurationInput.setAlignment(Qt.AlignVCenter | Qt.AlignHCenter)  # 内容居中
            ExamDurationInput.setPlaceholderText(self.Lang.ExamDuration)  # 设置空内容提示
            ExamDurationInput.setStyleSheet(self.PaperStyleSheet.InputBox())  # 设置样式
            ExamDurationInput.setToolTip(self.Lang.ExamDuration)  # 设置鼠标提示
            VLayout.addWidget(ExamDurationInput)  # 添加控件

            self.SubjectSelectButton = QPushButton(self.Lang.Subject)  # 按钮
            self.SubjectSelectButton.setStyleSheet(self.PaperStyleSheet.Button())  # 设置样式
            self.SubjectSelectButton.setFixedHeight(30)  # 尺寸
            self.SubjectSelectButton.clicked.connect(lambda: self.ChooseSubjects(CheckSubjects['Data']))  # 连接槽函数
            self.SubjectSelectButton.setWhatsThis('0')  # 设置默认值
            VLayout.addWidget(self.SubjectSelectButton)

            AddButton = QPushButton(self.Lang.Confirm)  # 按钮
            AddButton.setStyleSheet(self.PaperStyleSheet.Button())  # 设置样式
            AddButton.setFixedHeight(30)  # 尺寸
            AddButton.clicked.connect(lambda: self.NewPaperAction(PaperNameInput.text(), int(self.SubjectSelectButton.whatsThis()), TotalScoreInput.text(), PassLineInput.text(), ExamDurationInput.text()))  # 连接槽函数
            VLayout.addWidget(AddButton)

            self.NewPaperView.setLayout(VLayout)  # 添加布局
            self.NewPaperView.show()

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
    def NewPaperAction(self, PaperName: str, SubjectID: int, TotalScore: float, PassLine: float, ExamDuration: int):
        Result = self.PaperController.NewPaper(PaperName, SubjectID, TotalScore, PassLine, ExamDuration)
        if Result['State'] != True:
            self.MSGBOX.ERROR(Result['Memo'])
        else:
            self.NewPaperView.close()  # 关闭窗口
            self.TreeDataInit()  # 主控件写入数据

    # 试卷规则
    def TestPaperRulesWindow(self, Item):
        ID: int = int(Item.text(0))
        self.PaperRulesWindow = PaperRulesWindow(ID)
        self.PaperRulesWindow.ActionSignal.connect(self.TreeDataInit)
        self.PaperRulesWindow.show()


# 选择科目
class SubjectsWindow(BaseTemplate, QDialog):
    ActionSignal = Signal(str, str)  # 设置信号

    def __init__(self, SubjectList: list):
        super().__init__()
        self.PaperStyleSheet = PaperStyleSheet()
        self.setWindowTitle(TITLE)
        self.setFixedSize(286, 274)  # 尺寸
        self.setWindowModality(Qt.ApplicationModal)  # 禁止其他所有窗口交互
        self.setStyleSheet(self.PaperStyleSheet.Dialog())  # 设置样式
        self.VLayout = QVBoxLayout()
        self.HLayout = QHBoxLayout()
        self.VLayout.addLayout(self.HLayout)
        self.setLayout(self.VLayout)

        self.SearchBar = QLineEdit()
        self.SearchBar.setFixedHeight(30)
        self.SearchBar.setPlaceholderText(self.Lang.Name)
        self.SearchBar.setAlignment(Qt.AlignVCenter | Qt.AlignHCenter)  # 字体居中
        self.SearchBar.setStyleSheet(self.PaperStyleSheet.InputBox())
        self.HLayout.addWidget(self.SearchBar)
        self.SearchButton = QPushButton(self.Lang.Search)
        self.SearchButton.setFixedWidth(90)
        self.SearchButton.setFixedHeight(30)
        self.SearchButton.setStyleSheet(self.PaperStyleSheet.Button())
        self.SearchButton.clicked.connect(self.SearchName)
        self.HLayout.addWidget(self.SearchButton)

        self.Tree = QListWidget()
        # self.Tree.setSelectionMode(QAbstractItemView.ExtendedSelection)  # 设置多选
        self.Tree.setStyleSheet(self.PaperStyleSheet.List())
        self.Tree.setFocusPolicy(Qt.NoFocus)
        self.VLayout.addWidget(self.Tree)

        self.SubmitButton = QPushButton(self.Lang.Submit)
        self.SubmitButton.setFixedHeight(30)
        self.SubmitButton.setStyleSheet(self.PaperStyleSheet.Button())
        self.SubmitButton.clicked.connect(self.Send)
        self.VLayout.addWidget(self.SubmitButton)

        self.SubjectList = SubjectList
        if len(self.SubjectList) > 0:
            for i in range(len(self.SubjectList)):
                Item = QListWidgetItem()
                Item.setSizeHint(QSize(200, 30))
                Item.setText(self.SubjectList[i]['SubjectName'])
                Item.setToolTip(self.SubjectList[i]['SubjectName'])
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


# 试卷规则
class PaperRulesWindow(BaseTemplate, QDialog):
    ActionSignal = Signal()  # 设置信号

    def __init__(self, PaperID: int):
        super().__init__()
        self.PaperID = PaperID
        self.PaperRuleController = PaperRuleController()
        self.HeadlineController = HeadlineController()
        self.KnowledgeController = KnowledgeController()
        self.PaperStyleSheet = PaperStyleSheet()
        self.setWindowTitle(TITLE)
        self.setMinimumSize(840, 480)  # 尺寸
        self.setWindowModality(Qt.ApplicationModal)  # 禁止其他所有窗口交互
        self.setStyleSheet(self.PaperStyleSheet.Dialog())  # 设置样式
        self.VLayout = QVBoxLayout()
        self.TreeDataInit()
        self.setLayout(self.VLayout)

    def TreeDataInit(self):
        self.ClearLayout(self.VLayout)
        self.PaperRulesTree = BaseTreeWidget()
        self.PaperRulesTree.SetSelectionMode(2)  # 设置选择模式
        self.PaperRulesTree.setStyleSheet(self.PaperStyleSheet.TreeWidget())  # 设置样式
        self.PaperRulesTree.setColumnCount(12)  # 设置列数
        self.PaperRulesTree.hideColumn(5)  # 隐藏列
        self.PaperRulesTree.hideColumn(6)  # 隐藏列
        self.PaperRulesTree.hideColumn(7)  # 隐藏列
        self.PaperRulesTree.hideColumn(9)  # 隐藏列
        self.PaperRulesTree.setHeaderLabels([
            'ID',
            self.Lang.QuestionType,
            self.Lang.NumberOfQuestionsDrawn,
            self.Lang.SingleQuestionScore,
            self.Lang.ExamRulesStatus,
            'PaperID',
            'HeadlineID',
            'KnowledgeID',
            self.Lang.Sort,
            'UpdateTime',
            self.Lang.CreationTime,
        ])  # 设置标题栏
        self.PaperRulesTree.Connect(self.RightContextMenuExec)  # 鼠标右键菜单 链接槽函数
        self.VLayout.addWidget(self.PaperRulesTree)  # 添加控件

        HLayout = QHBoxLayout()

        NewHeadlineButton = QPushButton(self.Lang.AddHeadline)
        NewHeadlineButton.setStyleSheet(self.PaperStyleSheet.Button())  # 设置样式
        NewHeadlineButton.setFixedHeight(30)  # 尺寸
        NewHeadlineButton.clicked.connect(lambda: self.NewHeadline())  # 连接槽函数
        HLayout.addWidget(NewHeadlineButton)  # 添加控件

        NewPaperRuleButton = QPushButton(self.Lang.NewTestPaperRule)
        NewPaperRuleButton.setStyleSheet(self.PaperStyleSheet.Button())  # 设置样式
        NewPaperRuleButton.setFixedHeight(30)  # 尺寸
        NewPaperRuleButton.clicked.connect(lambda: self.NewPaperRule())  # 连接槽函数
        HLayout.addWidget(NewPaperRuleButton)  # 添加控件

        self.VLayout.addLayout(HLayout)  # 添加控件

        Result = self.PaperRuleController.PaperRules(self.PaperID)
        if Result['State'] != True:
            self.MSGBOX.ERROR(Result['Memo'])
        else:
            self.Rules = Result['Data']

        # 写入试题选项
        if len(self.Rules) > 0:
            TreeItems = []
            for i in range(len(self.Rules)):
                item = QTreeWidgetItem()  # 设置item控件
                Data = self.Rules[i]
                # item.setIcon(0, QtGui.QIcon(os.getcwd() + '/avatar.png'))
                item.setText(0, str(Data['ID']))  # 设置内容
                if Data['QuestionType'] == 1:
                    item.setText(1, self.Lang.MultipleChoiceQuestions)  # 设置内容
                elif Data['QuestionType'] == 2:
                    item.setText(1, self.Lang.TrueOrFalse)  # 设置内容
                elif Data['QuestionType'] == 3:
                    item.setText(1, self.Lang.MultipleChoices)  # 设置内容
                elif Data['QuestionType'] == 4:
                    item.setText(1, self.Lang.FillInTheBlank)  # 设置内容
                elif Data['QuestionType'] == 5:
                    item.setText(1, self.Lang.QuestionsAndAnswers)  # 设置内容
                elif Data['QuestionType'] == 6:
                    item.setText(1, self.Lang.ProgrammingQuestions)  # 设置内容
                elif Data['QuestionType'] == 7:
                    item.setText(1, self.Lang.DragAndDrop)  # 设置内容
                elif Data['QuestionType'] == 8:
                    item.setText(1, self.Lang.ConnectingQuestion)  # 设置内容
                else:
                    item.setText(1, self.Lang.Headline)  # 设置内容
                item.setText(2, str(Data['QuestionNum']))  # 设置内容
                item.setText(3, str(Data['SingleScore']))  # 设置内容
                if Data['PaperRuleState'] == 1:
                    item.setText(4, self.Lang.Normal)  # 设置内容
                else:
                    item.setText(4, self.Lang.Disabled)  # 设置内容
                item.setText(5, str(Data['PaperID']))  # 设置内容
                item.setText(6, str(Data['HeadlineID']))  # 设置内容
                item.setText(7, str(Data['KnowledgeID']))  # 设置内容
                item.setText(8, str(Data['SerialNumber']))  # 设置内容
                item.setText(9, str(Data['UpdateTime']))  # 设置内容
                item.setText(10, self.Common.TimeToStr(Data['CreateTime']))  # 设置内容
                item.setText(11, str(Data['QuestionType']))  # 设置内容
                item.setTextAlignment(0, Qt.AlignHCenter | Qt.AlignVCenter)  # 设置item字体居中
                item.setTextAlignment(1, Qt.AlignHCenter | Qt.AlignVCenter)  # 设置item字体居中
                item.setTextAlignment(2, Qt.AlignHCenter | Qt.AlignVCenter)  # 设置item字体居中
                item.setTextAlignment(3, Qt.AlignHCenter | Qt.AlignVCenter)  # 设置item字体居中
                item.setTextAlignment(4, Qt.AlignHCenter | Qt.AlignVCenter)  # 设置item字体居中
                item.setTextAlignment(5, Qt.AlignHCenter | Qt.AlignVCenter)  # 设置item字体居中
                item.setTextAlignment(6, Qt.AlignHCenter | Qt.AlignVCenter)  # 设置item字体居中
                item.setTextAlignment(7, Qt.AlignHCenter | Qt.AlignVCenter)  # 设置item字体居中
                item.setTextAlignment(8, Qt.AlignHCenter | Qt.AlignVCenter)  # 设置item字体居中
                item.setTextAlignment(9, Qt.AlignHCenter | Qt.AlignVCenter)  # 设置item字体居中
                item.setTextAlignment(10, Qt.AlignHCenter | Qt.AlignVCenter)  # 设置item字体居中
                item.setTextAlignment(11, Qt.AlignHCenter | Qt.AlignVCenter)  # 设置item字体居中
                TreeItems.append(item)  # 添加到item list
            self.PaperRulesTree.insertTopLevelItems(0, TreeItems)  # 添加到列表

    # 添加大标题
    def NewHeadline(self):
        self.HeadlineView = QDialog()
        self.HeadlineView.setWindowTitle(TITLE)
        self.HeadlineView.setWindowModality(Qt.ApplicationModal)  # 禁止其他所有窗口交互
        self.HeadlineView.setStyleSheet(self.PaperStyleSheet.Dialog())  # 设置样式
        self.HeadlineView.setFixedSize(222, 88)  # 尺寸

        VLayout = QVBoxLayout()

        # HeadlineInput = QComboBox()  # 设置下拉框
        # HeadlineInput.adjustSize()  # 按内容自适应宽度
        # HeadlineInput.setView(QListView())  # 设置内容控件
        # HeadlineInput.setFixedHeight(30)  # 尺寸
        # HeadlineInput.setStyleSheet(self.PaperStyleSheet.SelectBox())  # 设置样式
        # HeadlineInput.insertItem(0, self.Lang.Headline)  # 设置下拉内容
        # HeadlineInput.setItemData(0, self.Lang.Headline, Qt.ToolTipRole)  # 设置下拉内容提示
        # Knowledge = self.HeadlineController.Headlines()
        # if len(Knowledge['Data']) > 0:
        #     KnowledgeData = Knowledge['Data']
        #     j = 1
        #     for i in range(len(KnowledgeData)):
        #         Data = KnowledgeData[i]
        #         HeadlineInput.insertItem(j, Data['Content'])  # 设置下拉内容
        #         HeadlineInput.setItemData(j, Data['Content'], Qt.ToolTipRole)  # 设置下拉内容提示
        #         HeadlineInput.setItemData(j, Data['ID'])  # 设值
        #         j += 1
        # HeadlineInput.setCurrentIndex(0)  # 设置默认选项
        # VLayout.addWidget(HeadlineInput)  # 添加控件

        self.HeadlineInput = QPushButton(self.Lang.Headline)  # 按钮
        self.HeadlineInput.setStyleSheet(self.PaperStyleSheet.Button())  # 设置样式
        self.HeadlineInput.setFixedHeight(30)  # 尺寸
        self.HeadlineInput.clicked.connect(lambda: self.ChooseHeadline())  # 连接槽函数
        self.HeadlineInput.setWhatsThis('0')  # 设置默认值
        VLayout.addWidget(self.HeadlineInput)

        AddButton = QPushButton(self.Lang.Confirm)  # 按钮
        AddButton.setStyleSheet(self.PaperStyleSheet.Button())  # 设置样式
        AddButton.setFixedHeight(30)  # 尺寸
        AddButton.clicked.connect(lambda: self.NewRuleAction(int(self.HeadlineInput.whatsThis()), 0, 0, 0, 0, self.PaperID, 0, 1))  # 连接槽函数
        VLayout.addWidget(AddButton)

        self.HeadlineView.setLayout(VLayout)  # 添加布局
        self.HeadlineView.show()

    # 大标题选择
    def ChooseHeadline(self):
        CheckHeadlines = self.HeadlineController.Headlines()
        if CheckHeadlines['State'] != True:
            self.MSGBOX.ERROR(CheckHeadlines['Memo'])
        else:
            self.HeadlinesWindow = HeadlinesWindow(CheckHeadlines['Data'])
            self.HeadlinesWindow.ActionSignal.connect(self.SetHeadline)
            self.HeadlinesWindow.show()

    # 设置大标题
    def SetHeadline(self, HeadlineContent: str, HeadlineID: str):
        if HeadlineContent != '' and HeadlineID != '':
            self.HeadlineInput.setText(HeadlineContent)
            self.HeadlineInput.setWhatsThis(HeadlineID)

    # 添加试卷规则
    def NewPaperRule(self):
        self.PaperRuleView = QDialog()
        self.PaperRuleView.setWindowTitle(TITLE)
        self.PaperRuleView.setWindowModality(Qt.ApplicationModal)  # 禁止其他所有窗口交互
        self.PaperRuleView.setStyleSheet(self.PaperStyleSheet.Dialog())  # 设置样式
        self.PaperRuleView.setFixedSize(222, 232)  # 尺寸

        VLayout = QVBoxLayout()

        # 试题类型 1单选 2判断 3多选 4填空 5问答 6编程 7拖拽 8连线
        QuestionTypeInput = QComboBox()  # 设置下拉框
        QuestionTypeInput.adjustSize()  # 按内容自适应宽度
        QuestionTypeInput.setView(QListView())  # 设置内容控件
        QuestionTypeInput.setFixedHeight(30)  # 尺寸
        QuestionTypeInput.setStyleSheet(self.PaperStyleSheet.SelectBox())  # 设置样式
        QuestionTypeInput.insertItem(0, self.Lang.QuestionType)  # 设置下拉内容
        QuestionTypeInput.setItemData(0, self.Lang.QuestionType, Qt.ToolTipRole)  # 设置下拉内容提示
        QuestionTypeInput.insertItem(1, self.Lang.MultipleChoiceQuestions)  # 设置下拉内容
        QuestionTypeInput.setItemData(1, self.Lang.MultipleChoiceQuestions, Qt.ToolTipRole)  # 设置下拉内容提示
        QuestionTypeInput.insertItem(2, self.Lang.TrueOrFalse)  # 设置下拉内容
        QuestionTypeInput.setItemData(2, self.Lang.TrueOrFalse, Qt.ToolTipRole)  # 设置下拉内容提示
        QuestionTypeInput.insertItem(3, self.Lang.MultipleChoices)  # 设置下拉内容
        QuestionTypeInput.setItemData(3, self.Lang.MultipleChoices, Qt.ToolTipRole)  # 设置下拉内容提示
        QuestionTypeInput.insertItem(4, self.Lang.FillInTheBlank)  # 设置下拉内容
        QuestionTypeInput.setItemData(4, self.Lang.FillInTheBlank, Qt.ToolTipRole)  # 设置下拉内容提示
        QuestionTypeInput.insertItem(5, self.Lang.QuestionsAndAnswers)  # 设置下拉内容
        QuestionTypeInput.setItemData(5, self.Lang.QuestionsAndAnswers, Qt.ToolTipRole)  # 设置下拉内容提示
        QuestionTypeInput.insertItem(6, self.Lang.ProgrammingQuestions)  # 设置下拉内容
        QuestionTypeInput.setItemData(6, self.Lang.ProgrammingQuestions, Qt.ToolTipRole)  # 设置下拉内容提示
        QuestionTypeInput.insertItem(7, self.Lang.DragAndDrop)  # 设置下拉内容
        QuestionTypeInput.setItemData(7, self.Lang.DragAndDrop, Qt.ToolTipRole)  # 设置下拉内容提示
        QuestionTypeInput.insertItem(8, self.Lang.ConnectingQuestion)  # 设置下拉内容
        QuestionTypeInput.setItemData(8, self.Lang.ConnectingQuestion, Qt.ToolTipRole)  # 设置下拉内容提示
        QuestionTypeInput.setCurrentIndex(0)  # 设置默认选项
        VLayout.addWidget(QuestionTypeInput)  # 添加控件

        KnowledgeInput = QComboBox()  # 设置下拉框
        KnowledgeInput.adjustSize()  # 按内容自适应宽度
        KnowledgeInput.setView(QListView())  # 设置内容控件
        KnowledgeInput.setFixedHeight(30)  # 尺寸
        KnowledgeInput.setStyleSheet(self.PaperStyleSheet.SelectBox())  # 设置样式
        KnowledgeInput.insertItem(0, self.Lang.KnowledgePoint)  # 设置下拉内容
        KnowledgeInput.setItemData(0, self.Lang.KnowledgePoint, Qt.ToolTipRole)  # 设置下拉内容提示
        Knowledge = self.KnowledgeController.Knowledge()
        if len(Knowledge['Data']) > 0:
            KnowledgeData = Knowledge['Data']
            j = 1
            for i in range(len(KnowledgeData)):
                Data = KnowledgeData[i]
                KnowledgeInput.insertItem(j, Data['KnowledgeName'])  # 设置下拉内容
                KnowledgeInput.setItemData(j, Data['KnowledgeName'], Qt.ToolTipRole)  # 设置下拉内容提示
                KnowledgeInput.setItemData(j, Data['ID'])  # 设值
                j += 1
        KnowledgeInput.setCurrentIndex(0)  # 设置默认选项
        VLayout.addWidget(KnowledgeInput)  # 添加控件

        QuestionNumInput = QLineEdit()
        QuestionNumInput.setFixedHeight(30)  # 尺寸
        QuestionNumInput.setAlignment(Qt.AlignVCenter | Qt.AlignHCenter)  # 内容居中
        QuestionNumInput.setPlaceholderText(self.Lang.NumberOfQuestionsDrawn)  # 设置空内容提示
        QuestionNumInput.setStyleSheet(self.PaperStyleSheet.InputBox())  # 设置样式
        QuestionNumInput.setToolTip(self.Lang.NumberOfQuestionsDrawn)  # 设置鼠标提示
        QuestionNumInput.setValidator(QIntValidator())  # 输入整数
        VLayout.addWidget(QuestionNumInput)  # 添加控件

        SingleScoreInput = QLineEdit()
        SingleScoreInput.setFixedHeight(30)  # 尺寸
        SingleScoreInput.setAlignment(Qt.AlignVCenter | Qt.AlignHCenter)  # 内容居中
        SingleScoreInput.setPlaceholderText(self.Lang.SingleQuestionScore)  # 设置空内容提示
        SingleScoreInput.setStyleSheet(self.PaperStyleSheet.InputBox())  # 设置样式
        SingleScoreInput.setToolTip(self.Lang.SingleQuestionScore)  # 设置鼠标提示
        SingleScoreInput.setValidator(QDoubleValidator())  # 输入浮点数
        VLayout.addWidget(SingleScoreInput)  # 添加控件

        SerialNumberInput = QLineEdit()
        SerialNumberInput.setFixedHeight(30)  # 尺寸
        SerialNumberInput.setAlignment(Qt.AlignVCenter | Qt.AlignHCenter)  # 内容居中
        SerialNumberInput.setPlaceholderText(self.Lang.Sort)  # 设置空内容提示
        SerialNumberInput.setStyleSheet(self.PaperStyleSheet.InputBox())  # 设置样式
        SerialNumberInput.setToolTip(self.Lang.Sort)  # 设置鼠标提示
        SerialNumberInput.setValidator(QDoubleValidator())  # 输入浮点数
        VLayout.addWidget(SerialNumberInput)  # 添加控件

        AddButton = QPushButton(self.Lang.Confirm)  # 按钮
        AddButton.setStyleSheet(self.PaperStyleSheet.Button())  # 设置样式
        AddButton.setFixedHeight(30)  # 尺寸
        AddButton.clicked.connect(lambda: self.NewRuleAction(0, QuestionTypeInput.currentIndex(), KnowledgeInput.currentData(), QuestionNumInput.text(), SingleScoreInput.text(), self.PaperID, SerialNumberInput.text(), 2))  # 连接槽函数
        VLayout.addWidget(AddButton)

        self.PaperRuleView.setLayout(VLayout)  # 添加布局
        self.PaperRuleView.show()

    def NewRuleAction(self, HeadlineID: int, QuestionType: int, KnowledgeID: int, QuestionNum: int, SingleScore: int, PaperID: int, SerialNumber: int, WinType: int):
        Result = self.PaperRuleController.NewPaperRule(HeadlineID, QuestionType, KnowledgeID, QuestionNum, SingleScore, PaperID, SerialNumber)
        if Result['State'] != True:
            self.MSGBOX.ERROR(Result['Memo'])
        else:
            self.ActionSignal.emit()
            self.TreeDataInit()  # 主控件写入数据
            if WinType == 1:
                self.HeadlineView.close()  # 关闭窗口
            if WinType == 2:
                self.PaperRuleView.close()  # 关闭窗口

    # 列表节点右键菜单
    def RightContextMenuExec(self, pos):
        self.TreeMenu = BaseMenu()
        self.TreeMenu.setStyleSheet(self.PaperStyleSheet.TreeMenu())  # 设置样式
        Item = self.PaperRulesTree.currentItem()  # 获取被点击行控件
        ItemAt = self.PaperRulesTree.itemAt(pos)  # 获取点击焦点

        # 展示判断
        if type(Item) == QTreeWidgetItem and type(ItemAt) == QTreeWidgetItem:  # 焦点内
            self.TreeMenu.AddAction(self.Lang.TestPaperRulesDetails, lambda: self.InfoWindow(Item))
            self.TreeMenu.AddAction(self.Lang.Disable, lambda: self.DisableAction())
            self.TreeMenu.AddAction(self.Lang.Delete, lambda: self.DeleteAction())
        else:  # 焦点外
            return

        self.TreeMenu.move(QCursor().pos())  # 移动到焦点
        self.TreeMenu.show()  # 展示

    # 试卷规则详情
    def InfoWindow(self, Item):
        ID: int = int(Item.text(0))
        QuestionNum: str = Item.text(2)
        SingleScore: str = Item.text(3)
        SerialNumber: str = Item.text(8)
        QuestionType: int = Item.text(11)

        HeadlineID: int = int(Item.text(6))
        KnowledgeID: int = int(Item.text(7))
        UpdateTime: str = self.Common.TimeToStr(int(Item.text(9)))
        HeadlineInfo: str = ''
        KnowledgeInfo: str = ''

        self.DetailsView = QDialog()
        self.DetailsView.setWindowTitle(TITLE)
        self.DetailsView.setWindowModality(Qt.ApplicationModal)  # 禁止其他所有窗口交互
        self.DetailsView.setStyleSheet(self.PaperStyleSheet.Dialog())  # 设置样式
        self.DetailsView.setFixedSize(222, 232)  # 尺寸

        VLayout = QVBoxLayout()

        if HeadlineID > 0:
            CheckHeadline = self.HeadlineController.HeadlineInfo(HeadlineID)
            if CheckHeadline['State'] == True:
                HeadlineInfo = CheckHeadline['Data']['Content']
        if KnowledgeID > 0:
            CheckKnowledge = self.KnowledgeController.KnowledgeInfo(KnowledgeID)
            if CheckKnowledge['State'] == True:
                KnowledgeInfo = CheckKnowledge['Data']['KnowledgeName']

        if HeadlineInfo != '':
            HeadlineInput = QTextEdit()  # 输入
            HeadlineInput.setText(HeadlineInfo)  # 设置内容
            HeadlineInput.setAlignment(Qt.AlignVCenter | Qt.AlignHCenter)  # 内容居中
            HeadlineInput.setPlaceholderText(self.Lang.Content)  # 设置空内容提示
            HeadlineInput.setStyleSheet(self.PaperStyleSheet.TextEdit())  # 设置样式
            HeadlineInput.setToolTip(self.Lang.Content)  # 设置鼠标提示
            VLayout.addWidget(HeadlineInput)  # 添加控件
        if KnowledgeInfo != '':
            QuestionNumInput = QLineEdit()
            QuestionNumInput.setText(QuestionNum)  # 设置内容
            QuestionNumInput.setFixedHeight(30)  # 尺寸
            QuestionNumInput.setAlignment(Qt.AlignVCenter | Qt.AlignHCenter)  # 内容居中
            QuestionNumInput.setPlaceholderText(self.Lang.NumberOfQuestionsDrawn)  # 设置空内容提示
            QuestionNumInput.setStyleSheet(self.PaperStyleSheet.InputBox())  # 设置样式
            QuestionNumInput.setToolTip(self.Lang.NumberOfQuestionsDrawn)  # 设置鼠标提示
            QuestionNumInput.setValidator(QIntValidator())  # 输入整数
            VLayout.addWidget(QuestionNumInput)  # 添加控件

            SingleScoreInput = QLineEdit()
            SingleScoreInput.setText(SingleScore)  # 设置内容
            SingleScoreInput.setFixedHeight(30)  # 尺寸
            SingleScoreInput.setAlignment(Qt.AlignVCenter | Qt.AlignHCenter)  # 内容居中
            SingleScoreInput.setPlaceholderText(self.Lang.SingleQuestionScore)  # 设置空内容提示
            SingleScoreInput.setStyleSheet(self.PaperStyleSheet.InputBox())  # 设置样式
            SingleScoreInput.setToolTip(self.Lang.SingleQuestionScore)  # 设置鼠标提示
            SingleScoreInput.setValidator(QDoubleValidator())  # 输入浮点数
            VLayout.addWidget(SingleScoreInput)  # 添加控件

            SerialNumberInput = QLineEdit()
            SerialNumberInput.setText(SerialNumber)  # 设置内容
            SerialNumberInput.setFixedHeight(30)  # 尺寸
            SerialNumberInput.setAlignment(Qt.AlignVCenter | Qt.AlignHCenter)  # 内容居中
            SerialNumberInput.setPlaceholderText(self.Lang.Sort)  # 设置空内容提示
            SerialNumberInput.setStyleSheet(self.PaperStyleSheet.InputBox())  # 设置样式
            SerialNumberInput.setToolTip(self.Lang.Sort)  # 设置鼠标提示
            SerialNumberInput.setValidator(QDoubleValidator())  # 输入浮点数
            VLayout.addWidget(SerialNumberInput)  # 添加控件

            # 试题类型 1单选 2判断 3多选 4填空 5问答 6编程 7拖拽 8连线
            QuestionTypeInput = QComboBox()  # 设置下拉框
            QuestionTypeInput.adjustSize()  # 按内容自适应宽度
            QuestionTypeInput.setView(QListView())  # 设置内容控件
            QuestionTypeInput.setFixedHeight(30)  # 尺寸
            QuestionTypeInput.setStyleSheet(self.PaperStyleSheet.SelectBox())  # 设置样式
            QuestionTypeInput.insertItem(0, self.Lang.QuestionType)  # 设置下拉内容
            QuestionTypeInput.setItemData(0, self.Lang.QuestionType, Qt.ToolTipRole)  # 设置下拉内容提示
            QuestionTypeInput.insertItem(1, self.Lang.MultipleChoiceQuestions)  # 设置下拉内容
            QuestionTypeInput.setItemData(1, self.Lang.MultipleChoiceQuestions, Qt.ToolTipRole)  # 设置下拉内容提示
            QuestionTypeInput.insertItem(2, self.Lang.TrueOrFalse)  # 设置下拉内容
            QuestionTypeInput.setItemData(2, self.Lang.TrueOrFalse, Qt.ToolTipRole)  # 设置下拉内容提示
            QuestionTypeInput.insertItem(3, self.Lang.MultipleChoices)  # 设置下拉内容
            QuestionTypeInput.setItemData(3, self.Lang.MultipleChoices, Qt.ToolTipRole)  # 设置下拉内容提示
            QuestionTypeInput.insertItem(4, self.Lang.FillInTheBlank)  # 设置下拉内容
            QuestionTypeInput.setItemData(4, self.Lang.FillInTheBlank, Qt.ToolTipRole)  # 设置下拉内容提示
            QuestionTypeInput.insertItem(5, self.Lang.QuestionsAndAnswers)  # 设置下拉内容
            QuestionTypeInput.setItemData(5, self.Lang.QuestionsAndAnswers, Qt.ToolTipRole)  # 设置下拉内容提示
            QuestionTypeInput.insertItem(6, self.Lang.ProgrammingQuestions)  # 设置下拉内容
            QuestionTypeInput.setItemData(6, self.Lang.ProgrammingQuestions, Qt.ToolTipRole)  # 设置下拉内容提示
            QuestionTypeInput.insertItem(7, self.Lang.DragAndDrop)  # 设置下拉内容
            QuestionTypeInput.setItemData(7, self.Lang.DragAndDrop, Qt.ToolTipRole)  # 设置下拉内容提示
            QuestionTypeInput.insertItem(8, self.Lang.ConnectingQuestion)  # 设置下拉内容
            QuestionTypeInput.setItemData(8, self.Lang.ConnectingQuestion, Qt.ToolTipRole)  # 设置下拉内容提示
            QuestionTypeInput.setCurrentIndex(int(QuestionType))  # 设置默认选项
            VLayout.addWidget(QuestionTypeInput)  # 添加控件

            UpdateTimeInput = QLineEdit()
            UpdateTimeInput.setText(UpdateTime)  # 设置内容
            UpdateTimeInput.setFixedHeight(30)  # 尺寸
            UpdateTimeInput.setAlignment(Qt.AlignVCenter | Qt.AlignHCenter)  # 内容居中
            UpdateTimeInput.setPlaceholderText(self.Lang.UpdateTime)  # 设置空内容提示
            UpdateTimeInput.setStyleSheet(self.PaperStyleSheet.InputBox())  # 设置样式
            UpdateTimeInput.setToolTip(self.Lang.UpdateTime)  # 设置鼠标提示
            UpdateTimeInput.setEnabled(False)  # 禁止输入
            VLayout.addWidget(UpdateTimeInput)  # 添加控件

            UpdateButton = QPushButton(self.Lang.Confirm)  # 按钮
            UpdateButton.setStyleSheet(self.PaperStyleSheet.Button())  # 设置样式
            UpdateButton.setFixedHeight(30)  # 尺寸
            UpdateButton.clicked.connect(lambda: self.UpdatePaperRuleAction(ID, QuestionTypeInput.currentIndex(), QuestionNumInput.text(), SingleScoreInput.text(), SerialNumberInput.text()))  # 连接槽函数
            VLayout.addWidget(UpdateButton)

        self.DetailsView.setLayout(VLayout)  # 添加布局
        self.DetailsView.show()

    def UpdatePaperRuleAction(self, ID: int, QuestionType: int, QuestionNum: int, SingleScore: float, SerialNumber: int):
        Result = self.PaperRuleController.UpdatePaperRule(ID, QuestionType, QuestionNum, SingleScore, SerialNumber)
        if Result['State'] != True:
            self.MSGBOX.ERROR(Result['Memo'])
        else:
            self.ActionSignal.emit()
            self.TreeDataInit()  # 主控件写入数据
            self.DetailsView.close()  # 关闭窗口

    # 禁用试卷规则
    def DisableAction(self):
        Papers = self.PaperRulesTree.selectedItems()
        for i in range(len(Papers)):
            Item = Papers[i]
            ID: int = int(Item.text(0))
            Result = self.PaperRuleController.PaperRuleDisabled(ID)
            if Result['State'] != True:
                self.TreeDataInit()
                self.MSGBOX.ERROR(Result['Memo'])
                break
            else:
                self.ActionSignal.emit()
                self.TreeDataInit()

    # 删除试卷规则
    def DeleteAction(self):
        Papers = self.PaperRulesTree.selectedItems()
        for i in range(len(Papers)):
            Item = Papers[i]
            ID: int = int(Item.text(0))
            Result = self.PaperRuleController.PaperRuleDelete(ID)
            if Result['State'] != True:
                self.TreeDataInit()
                self.MSGBOX.ERROR(Result['Memo'])
                break
            else:
                self.ActionSignal.emit()
                self.TreeDataInit()


# 选择考生
class HeadlinesWindow(BaseTemplate, QDialog):
    ActionSignal = Signal(str, str)  # 设置信号

    def __init__(self, HeadlineList: list):
        super().__init__()
        self.PaperStyleSheet = PaperStyleSheet()
        self.setWindowTitle(TITLE)
        self.setFixedSize(286, 274)  # 尺寸
        self.setWindowModality(Qt.ApplicationModal)  # 禁止其他所有窗口交互
        self.setStyleSheet(self.PaperStyleSheet.Dialog())  # 设置样式
        self.VLayout = QVBoxLayout()
        self.HLayout = QHBoxLayout()
        self.VLayout.addLayout(self.HLayout)
        self.setLayout(self.VLayout)

        self.SearchBar = QLineEdit()
        self.SearchBar.setFixedHeight(30)
        self.SearchBar.setPlaceholderText(self.Lang.Name)
        self.SearchBar.setAlignment(Qt.AlignVCenter | Qt.AlignHCenter)  # 字体居中
        self.SearchBar.setStyleSheet(self.PaperStyleSheet.InputBox())
        self.HLayout.addWidget(self.SearchBar)
        self.SearchButton = QPushButton(self.Lang.Search)
        self.SearchButton.setFixedSize(85, 30)
        self.SearchButton.setStyleSheet(self.PaperStyleSheet.Button())
        self.SearchButton.clicked.connect(self.SearchName)
        self.HLayout.addWidget(self.SearchButton)

        self.Tree = QListWidget()
        # self.Tree.setSelectionMode(QAbstractItemView.ExtendedSelection)  # 设置多选
        self.Tree.setStyleSheet(self.PaperStyleSheet.List())
        self.Tree.setFocusPolicy(Qt.NoFocus)
        self.VLayout.addWidget(self.Tree)

        self.SubmitButton = QPushButton(self.Lang.Submit)
        self.SubmitButton.setFixedHeight(30)
        self.SubmitButton.setStyleSheet(self.PaperStyleSheet.Button())
        self.SubmitButton.clicked.connect(self.Send)
        self.VLayout.addWidget(self.SubmitButton)

        self.HeadlineList = HeadlineList
        if len(self.HeadlineList) > 0:
            for i in range(len(self.HeadlineList)):
                Item = QListWidgetItem()
                Item.setSizeHint(QSize(200, 30))
                Item.setText(self.HeadlineList[i]['Content'])
                Item.setToolTip(self.HeadlineList[i]['Content'])
                Item.setWhatsThis(str(self.HeadlineList[i]['ID']))
                self.Tree.addItem(Item)

    # 搜索
    def SearchName(self):
        Name = self.SearchBar.text()
        if Name != '':
            SearchList = self.Tree.findItems(Name, Qt.MatchContains)
            if len(SearchList) > 0:
                for i in range(len(SearchList)):
                    if SearchList[i].text() != self.Cache.Get('Name'):
                        self.Tree.setCurrentItem(SearchList[i])

    # 发送
    def Send(self):
        HeadlineItem = self.Tree.currentItem()
        if HeadlineItem is not None and HeadlineItem.text() != '' and HeadlineItem.whatsThis() != '':
            self.ActionSignal.emit(HeadlineItem.text(), HeadlineItem.whatsThis())
            self.close()