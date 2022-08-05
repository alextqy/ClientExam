# -*- coding:utf-8 -*-
from Template.BaseTemplate import *
from StyleSheet.ExamInfoFrameStyleSheet import *


# 报名管理界面
class ExamInfoFrameTemplate(BaseTemplate, QFrame):

    def __init__(self):
        super().__init__()
        self.ExamInfoFrameStyleSheet = ExamInfoFrameStyleSheet()
        self.ExamInfoController = ExamInfoController()
        self.ExamineeController = ExamineeController()
        self.SubjectController = SubjectController()
        self.setStyleSheet(self.ExamInfoFrameStyleSheet.BaseStyleSheet())  # 设置样式

        self.CenterLayout = QVBoxLayout()  # 设置主布局
        self.CenterLayout.setContentsMargins(0, 0, 0, 0)  # 设置边距

        # 标题栏
        self.Headline = QLabel(self.Lang.RegisterInformation)
        self.Headline.setAlignment(Qt.AlignVCenter | Qt.AlignHCenter)  # 字体居中
        self.Headline.adjustSize()  # 根据内容自适应宽度
        self.Headline.setFixedHeight(30)  # 尺寸
        self.Headline.setContentsMargins(0, 0, 0, 0)  # 设置边距
        self.Headline.setStyleSheet(self.ExamInfoFrameStyleSheet.Headline())  # 设置样式
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
        self.CurrentPage.setStyleSheet(self.ExamInfoFrameStyleSheet.CurrentPage())  # 设置样式
        self.PageButtonLayout.addWidget(self.CurrentPage)  # 添加控件

        # 总页码数
        self.TotalPage = QLabel(self.Lang.TotalPages + ' ' + str(self.TotalPageNo))
        self.TotalPage.setAlignment(Qt.AlignVCenter | Qt.AlignHCenter)  # 字体居中
        self.TotalPage.adjustSize()  # 根据内容自适应宽度
        self.TotalPage.setFixedSize(120, 30)  # 尺寸
        self.TotalPage.setContentsMargins(0, 0, 0, 0)  # 设置边距
        self.TotalPage.setStyleSheet(self.ExamInfoFrameStyleSheet.CurrentPage())  # 设置样式
        self.PageButtonLayout.addWidget(self.TotalPage)  # 添加控件

        # 输入页码
        self.PageInput = QLineEdit()
        self.PageInput.setValidator(self.QIntValidator)  # 输入为整数类型
        self.PageInput.setFixedSize(150, 30)  # 尺寸
        self.PageInput.setAlignment(Qt.AlignVCenter | Qt.AlignHCenter)  # 内容居中
        self.PageInput.setPlaceholderText(self.Lang.EnterPageNumber)  # 设置空内容提示
        self.PageInput.setStyleSheet(self.ExamInfoFrameStyleSheet.InputBox())  # 设置样式
        self.PageInput.setToolTip(self.Lang.EnterPageNumber)  # 设置鼠标提示
        self.PageButtonLayout.addWidget(self.PageInput)  # 添加控件

        # 每一页展示行数
        self.RowsInput = QLineEdit()
        self.RowsInput.setValidator(self.QIntValidator)  # 输入为整数类型
        self.RowsInput.setFixedSize(150, 30)  # 尺寸
        self.RowsInput.setAlignment(Qt.AlignVCenter | Qt.AlignHCenter)  # 内容居中
        self.RowsInput.setPlaceholderText(self.Lang.EnterTheNumberOfLines)  # 设置空内容提示
        self.RowsInput.setStyleSheet(self.ExamInfoFrameStyleSheet.InputBox())  # 设置样式
        self.RowsInput.setToolTip(self.Lang.EnterTheNumberOfLines)  # 设置鼠标提示
        self.PageButtonLayout.addWidget(self.RowsInput)  # 添加控件

        # 搜索
        self.SearchInput = QLineEdit()
        self.SearchInput.setFixedSize(150, 30)  # 尺寸
        self.SearchInput.setAlignment(Qt.AlignVCenter | Qt.AlignHCenter)  # 内容居中
        self.SearchInput.setPlaceholderText(self.Lang.Search)  # 设置空内容提示
        self.SearchInput.setStyleSheet(self.ExamInfoFrameStyleSheet.InputBox())  # 设置样式
        self.SearchInput.setToolTip(self.Lang.Search)  # 设置鼠标提示
        self.PageButtonLayout.addWidget(self.SearchInput)  # 添加控件

        # 通过状态
        self.PassSelect = QComboBox()  # 设置下拉框
        self.PassSelect.adjustSize()  # 按内容自适应宽度
        self.PassSelect.setView(QListView())  # 设置内容控件
        self.PassSelect.setFixedHeight(30)  # 尺寸
        self.PassSelect.setMinimumWidth(110)  # 尺寸
        self.PassSelect.setStyleSheet(self.ExamInfoFrameStyleSheet.SelectBox())  # 设置样式
        self.PassSelect.insertItem(0, ' ' + self.Lang.PassStatus)  # 设置下拉内容
        self.PassSelect.setItemData(0, self.Lang.PassStatus, Qt.ToolTipRole)  # 设置下拉内容提示
        self.PassSelect.insertItem(1, self.Lang.No)  # 设置下拉内容
        self.PassSelect.setItemData(1, self.Lang.No, Qt.ToolTipRole)  # 设置下拉内容提示
        self.PassSelect.insertItem(2, self.Lang.Yes)  # 设置下拉内容
        self.PassSelect.setItemData(2, self.Lang.Yes, Qt.ToolTipRole)  # 设置下拉内容提示
        self.PassSelect.setCurrentIndex(0)  # 设置默认选项
        self.PageButtonLayout.addWidget(self.PassSelect)  # 添加控件

        # 状态
        self.StateSelect = QComboBox()  # 设置下拉框
        self.StateSelect.adjustSize()  # 按内容自适应宽度
        self.StateSelect.setView(QListView())  # 设置内容控件
        self.StateSelect.setFixedHeight(30)  # 尺寸
        self.StateSelect.setMinimumWidth(100)  # 尺寸
        self.StateSelect.setStyleSheet(self.ExamInfoFrameStyleSheet.SelectBox())  # 设置样式
        self.StateSelect.insertItem(0, ' ' + self.Lang.ExamState)  # 设置下拉内容
        self.StateSelect.setItemData(0, self.Lang.ExamState, Qt.ToolTipRole)  # 设置下拉内容提示
        self.StateSelect.insertItem(1, self.Lang.NoAnswerSheet)  # 设置下拉内容
        self.StateSelect.setItemData(1, self.Lang.NoAnswerSheet, Qt.ToolTipRole)  # 设置下拉内容提示
        self.StateSelect.insertItem(2, self.Lang.WaitForVerification)  # 设置下拉内容
        self.StateSelect.setItemData(2, self.Lang.WaitForVerification, Qt.ToolTipRole)  # 设置下拉内容提示
        self.StateSelect.insertItem(3, self.Lang.Tested)  # 设置下拉内容
        self.StateSelect.setItemData(3, self.Lang.Tested, Qt.ToolTipRole)  # 设置下拉内容提示
        self.StateSelect.insertItem(4, self.Lang.RegistrationVoid)  # 设置下拉内容
        self.StateSelect.setItemData(4, self.Lang.RegistrationVoid, Qt.ToolTipRole)  # 设置下拉内容提示
        self.StateSelect.setCurrentIndex(0)  # 设置默认选项
        self.PageButtonLayout.addWidget(self.StateSelect)  # 添加控件

        # 类型
        self.TypeSelect = QComboBox()  # 设置下拉框
        self.TypeSelect.adjustSize()  # 按内容自适应宽度
        self.TypeSelect.setView(QListView())  # 设置内容控件
        self.TypeSelect.setFixedHeight(30)  # 尺寸
        self.TypeSelect.setMinimumWidth(100)  # 尺寸
        self.TypeSelect.setStyleSheet(self.ExamInfoFrameStyleSheet.SelectBox())  # 设置样式
        self.TypeSelect.insertItem(0, ' ' + self.Lang.ExamType)  # 设置下拉内容
        self.TypeSelect.setItemData(0, self.Lang.ExamType, Qt.ToolTipRole)  # 设置下拉内容提示
        self.TypeSelect.insertItem(1, self.Lang.FormalExam)  # 设置下拉内容
        self.TypeSelect.setItemData(1, self.Lang.FormalExam, Qt.ToolTipRole)  # 设置下拉内容提示
        self.TypeSelect.insertItem(2, self.Lang.InformalExam)  # 设置下拉内容
        self.TypeSelect.setItemData(2, self.Lang.InformalExam, Qt.ToolTipRole)  # 设置下拉内容提示
        self.TypeSelect.setCurrentIndex(0)  # 设置默认选项
        self.PageButtonLayout.addWidget(self.TypeSelect)  # 添加控件

        # 确认按钮
        self.ConfirmButton = QPushButton(self.Lang.Confirm)
        self.ConfirmButton.setStyleSheet(self.ExamInfoFrameStyleSheet.Button())  # 设置样式
        self.ConfirmButton.setFixedHeight(30)  # 尺寸
        self.ConfirmButton.clicked.connect(lambda: self.TreeDataInit())  # 连接槽函数
        self.PageButtonLayout.addWidget(self.ConfirmButton)  # 添加控件

        # =====================================================================================================================================================================

        # 页码按钮布局
        self.PNButtonLayout = QHBoxLayout()  # 设置按钮布局
        self.PNButtonLayout.setContentsMargins(0, 0, 0, 0)  # 设置边距

        # 上一页
        self.PreviousPageButton = QPushButton(self.Lang.PreviousPage)
        self.PreviousPageButton.setStyleSheet(self.ExamInfoFrameStyleSheet.Button())  # 设置样式
        self.PreviousPageButton.setFixedHeight(30)  # 尺寸
        self.PreviousPageButton.clicked.connect(lambda: self.SetPreviousPage())  # 连接槽函数
        self.PNButtonLayout.addWidget(self.PreviousPageButton)  # 添加控件

        # 下一页
        self.NextPageButton = QPushButton(self.Lang.NextPage)
        self.NextPageButton.setStyleSheet(self.ExamInfoFrameStyleSheet.Button())  # 设置样式
        self.NextPageButton.setFixedHeight(30)  # 尺寸
        self.NextPageButton.clicked.connect(lambda: self.SetNextPage())  # 连接槽函数
        self.PNButtonLayout.addWidget(self.NextPageButton)  # 添加控件

        # =====================================================================================================================================================================

        self.ButtonLayout = QHBoxLayout()  # 设置按钮布局
        self.ButtonLayout.setContentsMargins(0, 0, 0, 0)  # 设置边距

        # 新建
        self.NewExamInfoButton = QPushButton(self.Lang.NewRegistration)
        self.NewExamInfoButton.setStyleSheet(self.ExamInfoFrameStyleSheet.Button())  # 设置样式
        self.NewExamInfoButton.setFixedHeight(30)  # 尺寸
        self.NewExamInfoButton.clicked.connect(lambda: self.NewExamInfoWindow())  # 连接槽函数
        self.ButtonLayout.addWidget(self.NewExamInfoButton)  # 添加控件

        # 导入报名
        self.ImportRegistrationButton = QPushButton(self.Lang.ImportRegistration)
        self.ImportRegistrationButton.setStyleSheet(self.ExamInfoFrameStyleSheet.Button())  # 设置样式
        self.ImportRegistrationButton.setFixedHeight(30)  # 尺寸
        self.ImportRegistrationButton.clicked.connect(lambda: self.ImportRegistrationWindow())  # 连接槽函数
        self.ButtonLayout.addWidget(self.ImportRegistrationButton)  # 添加控件

        # 刷新
        self.RefreshButton = QPushButton(self.Lang.Refresh)
        self.RefreshButton.setStyleSheet(self.ExamInfoFrameStyleSheet.Button())  # 设置样式
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
        Pass = self.PassSelect.currentIndex()
        ExamState = self.StateSelect.currentIndex()
        ExamType = self.TypeSelect.currentIndex()
        Result = self.ExamInfoController.ExamInfoList(Page, PageSize, Stext, ExamState, ExamType, Pass)
        self.TotalPageNo = Result['TotalPage']
        self.TotalPage.setText(self.Lang.TotalPages + ' ' + str(self.TotalPageNo))

        if Result['State'] != True:
            self.MSGBOX.ERROR(Result['Memo'])
        else:
            Data = Result['Data']

            # 树状列表
            self.ExamInfoTree = BaseTreeWidget()
            self.ExamInfoTree.SetSelectionMode(2)  # 设置选择模式
            self.ExamInfoTree.setStyleSheet(self.ExamInfoFrameStyleSheet.TreeWidget())  # 设置样式
            self.ExamInfoTree.setColumnCount(16)  # 设置列数
            self.ExamInfoTree.hideColumn(14)  # 隐藏列
            self.ExamInfoTree.hideColumn(15)  # 隐藏列
            self.ExamInfoTree.setHeaderLabels([
                'ID',
                self.Lang.SubjectName,
                self.Lang.ExamNo,
                self.Lang.CreationTime,
                self.Lang.StartTime,
                self.Lang.EndTime,
                self.Lang.ExamDuration,
                self.Lang.ActualDuration,
                self.Lang.PassLine,
                self.Lang.PassStatus,
                self.Lang.ExamState,
                self.Lang.TotalScore,
                self.Lang.ActualScore,
                self.Lang.ExamType,
                'ExamineeID',
                'UpdateTime',
            ])  # 设置标题栏
            # self.ExamInfoTree.header().setSectionResizeMode(0, QHeaderView.ResizeToContents)  # 列宽自适应数据长度
            self.ExamInfoTree.setContentsMargins(0, 0, 0, 0)  # 设置边距
            self.ExamInfoTree.Connect(self.RightContextMenuExec)  # 鼠标右键菜单 链接槽函数
            self.TreeLayout.addWidget(self.ExamInfoTree)  # 添加控件

            TreeItems = []
            for i in range(len(Data)):
                item = QTreeWidgetItem()  # 设置item控件
                # item.setIcon(0, QtGui.QIcon(os.getcwd() + '/avatar.png'))
                item.setText(0, str(Data[i]['ID']))  # 设置内容
                item.setText(1, Data[i]['SubjectName'])  # 设置内容
                item.setText(2, Data[i]['ExamNo'])  # 设置内容
                item.setText(3, self.Common.TimeToStr(Data[i]['CreateTime']))  # 设置内容
                if Data[i]['StartTime'] > 0:
                    item.setText(4, self.Common.TimeToStr(Data[i]['StartTime']))  # 设置内容
                else:
                    item.setText(4, str(Data[i]['StartTime']))  # 设置内容
                if Data[i]['EndTime'] > 0:
                    item.setText(5, self.Common.TimeToStr(Data[i]['EndTime']))  # 设置内容
                else:
                    item.setText(5, str(Data[i]['EndTime']))  # 设置内容
                item.setText(6, str(Data[i]['ExamDuration']))  # 设置内容
                item.setText(7, str(Data[i]['ActualDuration']))  # 设置内容
                item.setText(8, str(Data[i]['PassLine']))  # 设置内容

                if Data[i]['Pass'] == 2:
                    item.setText(9, self.Lang.Yes)  # 设置内容
                else:
                    item.setText(9, self.Lang.No)  # 设置内容
                if Data[i]['ExamState'] == 1:
                    item.setText(10, self.Lang.NoAnswerSheet)  # 设置内容
                elif Data[i]['ExamState'] == 2:
                    item.setText(10, self.Lang.WaitForVerification)  # 设置内容
                elif Data[i]['ExamState'] == 3:
                    item.setText(10, self.Lang.Tested)  # 设置内容
                elif Data[i]['ExamState'] == 4:
                    item.setText(10, self.Lang.RegistrationVoid)  # 设置内容
                else:
                    item.setText(10, '')  # 设置内容

                item.setText(11, str(Data[i]['TotalScore']))  # 设置内容
                item.setText(12, str(Data[i]['ActualScore']))  # 设置内容

                if Data[i]['ExamType'] == 1:
                    item.setText(13, self.Lang.FormalExam)  # 设置内容
                else:
                    item.setText(13, self.Lang.InformalExam)  # 设置内容

                item.setText(14, str(Data[i]['ExamineeID']))  # 设置内容
                item.setText(15, str(Data[i]['UpdateTime']))  # 设置内容

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
                item.setTextAlignment(12, Qt.AlignHCenter | Qt.AlignVCenter)  # 设置item字体居中
                item.setTextAlignment(13, Qt.AlignHCenter | Qt.AlignVCenter)  # 设置item字体居中
                item.setTextAlignment(14, Qt.AlignHCenter | Qt.AlignVCenter)  # 设置item字体居中
                item.setTextAlignment(15, Qt.AlignHCenter | Qt.AlignVCenter)  # 设置item字体居中
                TreeItems.append(item)  # 添加到item list
            self.ExamInfoTree.insertTopLevelItems(0, TreeItems)  # 添加到列表

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
        self.TreeMenu.setStyleSheet(self.ExamInfoFrameStyleSheet.TreeMenu())  # 设置样式
        Item = self.ExamInfoTree.currentItem()  # 获取被点击行控件
        ItemAt = self.ExamInfoTree.itemAt(pos)  # 获取点击焦点

        # 展示判断
        if type(Item) == QTreeWidgetItem and type(ItemAt) == QTreeWidgetItem:  # 焦点内
            self.TreeMenu.AddAction(self.Lang.RegistrationDetails, lambda: self.InfoWindow(Item))
            self.TreeMenu.AddAction(self.Lang.GenerateTestPaper, lambda: self.GenerateTestPaperAction())
            self.TreeMenu.AddAction(self.Lang.ResetTestPaper, lambda: self.ResetTestPaperAction())
            self.TreeMenu.AddAction(self.Lang.RegistrationVoid, lambda: self.RegistrationVoidAction())
            self.TreeMenu.AddAction(self.Lang.TestPaperScoring, lambda: self.TestPaperScoringAction())
            self.TreeMenu.AddAction(self.Lang.DataIntoHistory, lambda: self.DataIntoHistoryAction())
        else:  # 焦点外
            return

        self.TreeMenu.move(QCursor().pos())  # 移动到焦点
        self.TreeMenu.show()  # 展示

    # 节点数据详情
    def InfoWindow(self, Item):
        ExamNo: str = Item.text(2)
        ExamineeID: int = int(Item.text(14))
        UpdateTime: int = int(Item.text(15))

        self.ExamInfoDetailsView = QDialog()
        self.ExamInfoDetailsView.setWindowTitle(TITLE)
        self.ExamInfoDetailsView.setWindowModality(Qt.ApplicationModal)  # 禁止其他所有窗口交互
        self.ExamInfoDetailsView.setStyleSheet(self.ExamInfoFrameStyleSheet.Dialog())  # 设置样式
        self.ExamInfoDetailsView.setFixedSize(222, 160)  # 尺寸

        VLayout = QVBoxLayout()

        ExamNoInput = QLineEdit()  # 输入
        ExamNoInput.setText(ExamNo)  # 设置内容
        ExamNoInput.setFixedSize(200, 30)  # 尺寸
        ExamNoInput.setAlignment(Qt.AlignVCenter | Qt.AlignHCenter)  # 内容居中
        ExamNoInput.setPlaceholderText(self.Lang.ExamNo)  # 设置空内容提示
        ExamNoInput.setStyleSheet(self.ExamInfoFrameStyleSheet.InputBox())  # 设置样式
        ExamNoInput.setToolTip(self.Lang.ExamNo)  # 设置鼠标提示
        ExamNoInput.setEnabled(False)  # 禁止输入
        VLayout.addWidget(ExamNoInput)  # 添加控件

        ExamineeNameInput = QLineEdit()  # 输入
        ExamineeNameInput.setFixedSize(200, 30)  # 尺寸
        ExamineeNameInput.setAlignment(Qt.AlignVCenter | Qt.AlignHCenter)  # 内容居中
        ExamineeNameInput.setPlaceholderText(self.Lang.Name)  # 设置空内容提示
        ExamineeNameInput.setStyleSheet(self.ExamInfoFrameStyleSheet.InputBox())  # 设置样式
        ExamineeNameInput.setToolTip(self.Lang.Name)  # 设置鼠标提示
        ExamineeNameInput.setEnabled(False)  # 禁止输入
        VLayout.addWidget(ExamineeNameInput)  # 添加控件

        ExamineeNoInput = QLineEdit()  # 输入
        ExamineeNoInput.setFixedSize(200, 30)  # 尺寸
        ExamineeNoInput.setAlignment(Qt.AlignVCenter | Qt.AlignHCenter)  # 内容居中
        ExamineeNoInput.setPlaceholderText(self.Lang.ExamineeNo)  # 设置空内容提示
        ExamineeNoInput.setStyleSheet(self.ExamInfoFrameStyleSheet.InputBox())  # 设置样式
        ExamineeNoInput.setToolTip(self.Lang.ExamineeNo)  # 设置鼠标提示
        ExamineeNoInput.setEnabled(False)  # 禁止输入
        VLayout.addWidget(ExamineeNoInput)  # 添加控件

        if ExamineeID > 0:
            Result = self.ExamineeController.ExamineeInfo(ExamineeID)
            if Result['State'] == True:
                ExamineeData = Result['Data']
                ExamineeNameInput.setText(ExamineeData['Name'])  # 设置内容
                ExamineeNoInput.setText(ExamineeData['ExamineeNo'])  # 设置内容

        UpdateTimeInput = QLineEdit()
        UpdateTimeInput.setText(self.Common.TimeToStr(UpdateTime))  # 设置内容
        UpdateTimeInput.setFixedSize(200, 30)  # 尺寸
        UpdateTimeInput.setAlignment(Qt.AlignVCenter | Qt.AlignHCenter)  # 内容居中
        UpdateTimeInput.setPlaceholderText(self.Lang.UpdateTime)  # 设置空内容提示
        UpdateTimeInput.setStyleSheet(self.ExamInfoFrameStyleSheet.InputBox())  # 设置样式
        UpdateTimeInput.setToolTip(self.Lang.UpdateTime)  # 设置鼠标提示
        UpdateTimeInput.setEnabled(False)  # 禁止输入
        VLayout.addWidget(UpdateTimeInput)  # 添加控件

        self.ExamInfoDetailsView.setLayout(VLayout)  # 添加布局
        self.ExamInfoDetailsView.show()

    # 生成试卷
    def GenerateTestPaperAction(self):
        ExamInfoData = self.ExamInfoTree.selectedItems()
        for i in range(len(ExamInfoData)):
            Item = ExamInfoData[i]
            ID: int = int(Item.text(0))
            Result = self.ExamInfoController.GenerateTestPaper(ID)
            if Result['State'] != True:
                self.TreeDataInit()
                self.MSGBOX.ERROR('ID:' + str(ID) + ' ' + Result['Memo'])
                break
            else:
                self.TreeDataInit()

    # 重置试卷
    def ResetTestPaperAction(self):
        ExamInfoData = self.ExamInfoTree.selectedItems()
        for i in range(len(ExamInfoData)):
            Item = ExamInfoData[i]
            ID: int = int(Item.text(0))
            Result = self.ExamInfoController.ResetExamQuestionData(ID)
            if Result['State'] != True:
                self.TreeDataInit()
                self.MSGBOX.ERROR('ID:' + str(ID) + ' ' + Result['Memo'])
                break
            else:
                self.TreeDataInit()

    # 报名作废
    def RegistrationVoidAction(self):
        ExamInfoData = self.ExamInfoTree.selectedItems()
        for i in range(len(ExamInfoData)):
            Item = ExamInfoData[i]
            ID: int = int(Item.text(0))
            Result = self.ExamInfoController.ExamInfoDisabled(ID)
            if Result['State'] != True:
                self.TreeDataInit()
                self.MSGBOX.ERROR('ID:' + str(ID) + ' ' + Result['Memo'])
                break
            else:
                self.TreeDataInit()

    # 打分
    def TestPaperScoringAction(self):
        ExamInfoData = self.ExamInfoTree.selectedItems()
        for i in range(len(ExamInfoData)):
            Item = ExamInfoData[i]
            ID: int = int(Item.text(0))
            Result = self.ExamInfoController.GradeTheExam(ID)
            if Result['State'] != True:
                self.TreeDataInit()
                self.MSGBOX.ERROR('ID:' + str(ID) + ' ' + Result['Memo'])
                break
            else:
                self.TreeDataInit()

    # 转到历史
    def DataIntoHistoryAction(self):
        ExamInfoData = self.ExamInfoTree.selectedItems()
        for i in range(len(ExamInfoData)):
            Item = ExamInfoData[i]
            ID: int = int(Item.text(0))
            Result = self.ExamInfoController.ExamIntoHistory(ID)
            if Result['State'] != True:
                self.TreeDataInit()
                self.MSGBOX.ERROR('ID:' + str(ID) + ' ' + Result['Memo'])
                break
            else:
                self.TreeDataInit()

    # 新建节点
    def NewExamInfoWindow(self):
        CheckSubjects = self.SubjectController.Subjects()
        if CheckSubjects['State'] != True and len(CheckSubjects['Data']) == 0:
            self.MSGBOX.WARNING(self.Lang.NoDataAvailable)
        else:
            self.NewExamInfoView = QDialog()
            self.NewExamInfoView.setWindowTitle(TITLE)
            self.NewExamInfoView.setWindowModality(Qt.ApplicationModal)  # 禁止其他所有窗口交互
            self.NewExamInfoView.setStyleSheet(self.ExamInfoFrameStyleSheet.Dialog())  # 设置样式
            self.NewExamInfoView.setFixedSize(222, 196)  # 尺寸

            VLayout = QVBoxLayout()

            ExamNoInput = QLineEdit()  # 账号输入
            ExamNoInput.setFixedSize(200, 30)  # 尺寸
            ExamNoInput.setAlignment(Qt.AlignVCenter | Qt.AlignHCenter)  # 内容居中
            ExamNoInput.setPlaceholderText(self.Lang.ExamNo)  # 设置空内容提示
            ExamNoInput.setStyleSheet(self.ExamInfoFrameStyleSheet.InputBox())  # 设置样式
            ExamNoInput.setToolTip(self.Lang.ExamNo)  # 设置鼠标提示
            VLayout.addWidget(ExamNoInput)  # 添加控件

            TypeSelect = QComboBox()  # 设置下拉框
            TypeSelect.adjustSize()  # 按内容自适应宽度
            TypeSelect.setView(QListView())  # 设置内容控件
            TypeSelect.setFixedHeight(30)  # 尺寸
            TypeSelect.setMinimumWidth(100)  # 尺寸
            TypeSelect.setStyleSheet(self.ExamInfoFrameStyleSheet.SelectBox())  # 设置样式
            TypeSelect.insertItem(0, ' ' + self.Lang.ExamType)  # 设置下拉内容
            TypeSelect.setItemData(0, self.Lang.ExamType, Qt.ToolTipRole)  # 设置下拉内容提示
            TypeSelect.insertItem(1, self.Lang.FormalExam)  # 设置下拉内容
            TypeSelect.setItemData(1, self.Lang.FormalExam, Qt.ToolTipRole)  # 设置下拉内容提示
            TypeSelect.insertItem(2, self.Lang.InformalExam)  # 设置下拉内容
            TypeSelect.setItemData(2, self.Lang.InformalExam, Qt.ToolTipRole)  # 设置下拉内容提示
            TypeSelect.setCurrentIndex(0)  # 设置默认选项
            VLayout.addWidget(TypeSelect)  # 添加控件

            self.SubjectSelectButton = QPushButton(self.Lang.Subject)  # 按钮
            self.SubjectSelectButton.setStyleSheet(self.ExamInfoFrameStyleSheet.Button())  # 设置样式
            self.SubjectSelectButton.setFixedHeight(30)  # 尺寸
            self.SubjectSelectButton.clicked.connect(lambda: self.ChooseSubjects(CheckSubjects['Data']))  # 连接槽函数
            VLayout.addWidget(self.SubjectSelectButton)

            self.ExamineeSelectButton = QPushButton(self.Lang.Examinee)  # 按钮
            self.ExamineeSelectButton.setStyleSheet(self.ExamInfoFrameStyleSheet.Button())  # 设置样式
            self.ExamineeSelectButton.setFixedHeight(30)  # 尺寸
            self.ExamineeSelectButton.clicked.connect(lambda: self.ChooseExaminees())  # 连接槽函数
            self.ExamineeSelectButton.setWhatsThis('0')  # 设置默认值
            VLayout.addWidget(self.ExamineeSelectButton)

            AddButton = QPushButton(self.Lang.Confirm)  # 按钮
            AddButton.setStyleSheet(self.ExamInfoFrameStyleSheet.Button())  # 设置样式
            AddButton.setFixedHeight(30)  # 尺寸
            AddButton.clicked.connect(lambda: self.NewExamInfoAction(self.SubjectSelectButton.text(), ExamNoInput.text(), int(self.ExamineeSelectButton.whatsThis()), TypeSelect.currentIndex()))  # 连接槽函数
            VLayout.addWidget(AddButton)

            self.NewExamInfoView.setLayout(VLayout)  # 添加布局
            self.NewExamInfoView.show()

    # 科目选择
    def ChooseSubjects(self, Subjects: list):
        self.SubjectsWindow = SubjectsWindow(Subjects)
        self.SubjectsWindow.ActionSignal.connect(self.SetSubject)
        self.SubjectsWindow.show()

    # 设置科目
    def SetSubject(self, SubjectName: str):
        if SubjectName != '':
            self.SubjectSelectButton.setText(SubjectName)

    # 考生选择
    def ChooseExaminees(self):
        CheckExaminees = self.ExamineeController.Examinees()
        if CheckExaminees['State'] != True:
            self.MSGBOX.ERROR(CheckExaminees['Memo'])
        else:
            self.ExamineesWindow = ExamineesWindow(CheckExaminees['Data'])
            self.ExamineesWindow.ActionSignal.connect(self.SetExaminee)
            self.ExamineesWindow.show()

    # 设置考生
    def SetExaminee(self, ExamineeName: str, ExamineeID: str):
        if ExamineeName != '' and ExamineeID != '':
            self.ExamineeSelectButton.setText(ExamineeName)
            self.ExamineeSelectButton.setWhatsThis(ExamineeID)

    # 新建
    def NewExamInfoAction(self, SubjectName: str, ExamNo: str, ExamineeID: int, ExamType: int):
        Result = self.ExamInfoController.NewExamInfo(SubjectName, ExamNo, ExamineeID, ExamType)
        if Result['State'] != True:
            self.MSGBOX.ERROR(Result['Memo'])
        else:
            self.TreeDataInit()
            self.NewExamInfoView.close()

    # 新建节点
    def ImportRegistrationWindow(self):
        pass

    # 导入
    def ImportRegistrationAction(self):
        pass


# 选择科目
class SubjectsWindow(BaseTemplate, QDialog):
    ActionSignal = Signal(str)  # 设置信号

    def __init__(self, SubjectList: list):
        super().__init__()
        self.ExamInfoFrameStyleSheet = ExamInfoFrameStyleSheet()
        self.setWindowTitle(TITLE)
        self.setFixedSize(266, 274)  # 尺寸
        self.setWindowModality(Qt.ApplicationModal)  # 禁止其他所有窗口交互
        self.setStyleSheet(self.ExamInfoFrameStyleSheet.Dialog())  # 设置样式
        self.VLayout = QVBoxLayout()
        self.VLayout.setContentsMargins(5, 5, 5, 5)
        self.HLayout = QHBoxLayout()
        self.VLayout.addLayout(self.HLayout)
        self.setLayout(self.VLayout)

        self.SearchBar = QLineEdit()
        self.SearchBar.setFixedHeight(30)
        self.SearchBar.setPlaceholderText(self.Lang.Name)
        self.SearchBar.setAlignment(Qt.AlignVCenter | Qt.AlignHCenter)  # 字体居中
        self.SearchBar.setStyleSheet(self.ExamInfoFrameStyleSheet.InputBox())
        self.HLayout.addWidget(self.SearchBar)
        self.SearchButton = QPushButton(self.Lang.Search)
        self.SearchButton.setFixedWidth(100)
        self.SearchButton.setFixedHeight(30)
        self.SearchButton.setStyleSheet(self.ExamInfoFrameStyleSheet.Button())
        self.SearchButton.clicked.connect(self.SearchName)
        self.HLayout.addWidget(self.SearchButton)

        self.Tree = QListWidget()
        # self.Tree.setSelectionMode(QAbstractItemView.ExtendedSelection)  # 设置多选
        self.Tree.setStyleSheet(self.ExamInfoFrameStyleSheet.List())
        self.Tree.setFocusPolicy(Qt.NoFocus)
        self.VLayout.addWidget(self.Tree)

        self.SubmitButton = QPushButton(self.Lang.Submit)
        self.SubmitButton.setFixedHeight(30)
        self.SubmitButton.setStyleSheet(self.ExamInfoFrameStyleSheet.Button())
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
        self.ActionSignal.emit(SubjectItem.text())
        self.close()


# 选择考生
class ExamineesWindow(BaseTemplate, QDialog):
    ActionSignal = Signal(str, str)  # 设置信号

    def __init__(self, ExamineeList: list):
        super().__init__()
        self.ExamInfoFrameStyleSheet = ExamInfoFrameStyleSheet()
        self.setWindowTitle(TITLE)
        self.setFixedSize(266, 274)  # 尺寸
        self.setWindowModality(Qt.ApplicationModal)  # 禁止其他所有窗口交互
        self.setStyleSheet(self.ExamInfoFrameStyleSheet.Dialog())  # 设置样式
        self.VLayout = QVBoxLayout()
        self.VLayout.setContentsMargins(5, 5, 5, 5)
        self.HLayout = QHBoxLayout()
        self.VLayout.addLayout(self.HLayout)
        self.setLayout(self.VLayout)

        self.SearchBar = QLineEdit()
        self.SearchBar.setFixedHeight(30)
        self.SearchBar.setPlaceholderText(self.Lang.Name)
        self.SearchBar.setAlignment(Qt.AlignVCenter | Qt.AlignHCenter)  # 字体居中
        self.SearchBar.setStyleSheet(self.ExamInfoFrameStyleSheet.InputBox())
        self.HLayout.addWidget(self.SearchBar)
        self.SearchButton = QPushButton(self.Lang.Search)
        self.SearchButton.setFixedWidth(100)
        self.SearchButton.setFixedHeight(30)
        self.SearchButton.setStyleSheet(self.ExamInfoFrameStyleSheet.Button())
        self.SearchButton.clicked.connect(self.SearchName)
        self.HLayout.addWidget(self.SearchButton)

        self.Tree = QListWidget()
        # self.Tree.setSelectionMode(QAbstractItemView.ExtendedSelection)  # 设置多选
        self.Tree.setStyleSheet(self.ExamInfoFrameStyleSheet.List())
        self.Tree.setFocusPolicy(Qt.NoFocus)
        self.VLayout.addWidget(self.Tree)

        self.SubmitButton = QPushButton(self.Lang.Submit)
        self.SubmitButton.setFixedHeight(30)
        self.SubmitButton.setStyleSheet(self.ExamInfoFrameStyleSheet.Button())
        self.SubmitButton.clicked.connect(self.Send)
        self.VLayout.addWidget(self.SubmitButton)

        self.ExamineeList = ExamineeList
        if len(self.ExamineeList) > 0:
            for i in range(len(self.ExamineeList)):
                Item = QListWidgetItem()
                Item.setSizeHint(QSize(200, 30))
                Item.setText(self.ExamineeList[i]['Name'])
                Item.setWhatsThis(str(self.ExamineeList[i]['ID']))
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
        ExamineeItem = self.Tree.currentItem()
        self.ActionSignal.emit(ExamineeItem.text(), ExamineeItem.whatsThis())
        self.close()