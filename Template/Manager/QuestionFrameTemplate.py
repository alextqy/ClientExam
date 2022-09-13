# -*- coding:utf-8 -*-
from Template.BaseTemplate import *
from StyleSheet.Manager.QuestionStyleSheet import *


# 试题管理界面
class QuestionFrameTemplate(BaseTemplate, QFrame):

    def __init__(self):
        super().__init__()
        self.QuestionStyleSheet = QuestionStyleSheet()
        self.QuestionController = QuestionController()
        self.QuestionSolutionController = QuestionSolutionController()
        self.SubjectController = SubjectController()
        self.KnowledgeController = KnowledgeController()
        self.setStyleSheet(self.QuestionStyleSheet.BaseStyleSheet())  # 设置样式

        self.CenterLayout = QVBoxLayout()  # 设置主布局

        # 标题栏
        self.Headline = QLabel(self.Lang.Question)
        self.Headline.setAlignment(Qt.AlignVCenter | Qt.AlignHCenter)  # 字体居中
        self.Headline.adjustSize()  # 根据内容自适应宽度
        self.Headline.setFixedHeight(30)  # 尺寸
        self.Headline.setStyleSheet(self.QuestionStyleSheet.Headline())  # 设置样式
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
        self.CurrentPage.setStyleSheet(self.QuestionStyleSheet.CurrentPage())  # 设置样式
        self.PageButtonLayout.addWidget(self.CurrentPage)  # 添加控件

        # 总页码数
        self.TotalPage = QLabel(self.Lang.TotalPages + ' ' + str(self.TotalPageNo))
        self.TotalPage.setAlignment(Qt.AlignVCenter | Qt.AlignHCenter)  # 字体居中
        self.TotalPage.adjustSize()  # 根据内容自适应宽度
        self.TotalPage.setFixedSize(120, 30)  # 尺寸
        self.TotalPage.setStyleSheet(self.QuestionStyleSheet.CurrentPage())  # 设置样式
        self.PageButtonLayout.addWidget(self.TotalPage)  # 添加控件

        # 输入页码
        self.PageInput = QLineEdit()
        self.PageInput.setValidator(self.QIntValidator)  # 输入为整数类型
        self.PageInput.setFixedSize(150, 30)  # 尺寸
        self.PageInput.setAlignment(Qt.AlignVCenter | Qt.AlignHCenter)  # 内容居中
        self.PageInput.setPlaceholderText(self.Lang.EnterPageNumber)  # 设置空内容提示
        self.PageInput.setStyleSheet(self.QuestionStyleSheet.InputBox())  # 设置样式
        self.PageInput.setToolTip(self.Lang.EnterPageNumber)  # 设置鼠标提示
        self.PageButtonLayout.addWidget(self.PageInput)  # 添加控件

        # 每一页展示行数
        self.RowsInput = QLineEdit()
        self.RowsInput.setValidator(self.QIntValidator)  # 输入为整数类型
        self.RowsInput.setFixedSize(150, 30)  # 尺寸
        self.RowsInput.setAlignment(Qt.AlignVCenter | Qt.AlignHCenter)  # 内容居中
        self.RowsInput.setPlaceholderText(self.Lang.EnterTheNumberOfLines)  # 设置空内容提示
        self.RowsInput.setStyleSheet(self.QuestionStyleSheet.InputBox())  # 设置样式
        self.RowsInput.setToolTip(self.Lang.EnterTheNumberOfLines)  # 设置鼠标提示
        self.PageButtonLayout.addWidget(self.RowsInput)  # 添加控件

        # 搜索
        self.SearchInput = QLineEdit()
        self.SearchInput.setFixedSize(150, 30)  # 尺寸
        self.SearchInput.setAlignment(Qt.AlignVCenter | Qt.AlignHCenter)  # 内容居中
        self.SearchInput.setPlaceholderText(self.Lang.Search)  # 设置空内容提示
        self.SearchInput.setStyleSheet(self.QuestionStyleSheet.InputBox())  # 设置样式
        self.SearchInput.setToolTip(self.Lang.Search)  # 设置鼠标提示
        self.PageButtonLayout.addWidget(self.SearchInput)  # 添加控件

        # 状态
        self.StateSelect = QComboBox()  # 设置下拉框
        self.StateSelect.adjustSize()  # 按内容自适应宽度
        self.StateSelect.setView(QListView())  # 设置内容控件
        self.StateSelect.setFixedHeight(30)  # 尺寸
        self.StateSelect.setStyleSheet(self.QuestionStyleSheet.SelectBox())  # 设置样式
        self.StateSelect.insertItem(0, self.Lang.QuestionStatus)  # 设置下拉内容
        self.StateSelect.setItemData(0, self.Lang.QuestionStatus, Qt.ToolTipRole)  # 设置下拉内容提示
        self.StateSelect.insertItem(1, self.Lang.Normal)  # 设置下拉内容
        self.StateSelect.setItemData(1, self.Lang.Normal, Qt.ToolTipRole)  # 设置下拉内容提示
        self.StateSelect.insertItem(2, self.Lang.Disabled)  # 设置下拉内容
        self.StateSelect.setItemData(2, self.Lang.Disabled, Qt.ToolTipRole)  # 设置下拉内容提示
        self.StateSelect.setCurrentIndex(0)  # 设置默认选项
        self.PageButtonLayout.addWidget(self.StateSelect)  # 添加控件

        self.TypeSelect = QComboBox()  # 设置下拉框
        self.TypeSelect.adjustSize()  # 按内容自适应宽度
        self.TypeSelect.setView(QListView())  # 设置内容控件
        self.TypeSelect.setFixedHeight(30)  # 尺寸
        self.TypeSelect.setStyleSheet(self.QuestionStyleSheet.SelectBox())  # 设置样式
        self.TypeSelect.insertItem(0, self.Lang.QuestionType)  # 设置下拉内容
        self.TypeSelect.setItemData(0, self.Lang.QuestionType, Qt.ToolTipRole)  # 设置下拉内容提示
        self.TypeSelect.insertItem(1, self.Lang.MultipleChoiceQuestions)  # 设置下拉内容
        self.TypeSelect.setItemData(1, self.Lang.MultipleChoiceQuestions, Qt.ToolTipRole)  # 设置下拉内容提示
        self.TypeSelect.insertItem(2, self.Lang.TrueOrFalse)  # 设置下拉内容
        self.TypeSelect.setItemData(2, self.Lang.TrueOrFalse, Qt.ToolTipRole)  # 设置下拉内容提示
        self.TypeSelect.insertItem(3, self.Lang.MultipleChoices)  # 设置下拉内容
        self.TypeSelect.setItemData(3, self.Lang.MultipleChoices, Qt.ToolTipRole)  # 设置下拉内容提示
        self.TypeSelect.insertItem(4, self.Lang.FillInTheBlank)  # 设置下拉内容
        self.TypeSelect.setItemData(4, self.Lang.FillInTheBlank, Qt.ToolTipRole)  # 设置下拉内容提示
        self.TypeSelect.insertItem(5, self.Lang.QuestionsAndAnswers)  # 设置下拉内容
        self.TypeSelect.setItemData(5, self.Lang.QuestionsAndAnswers, Qt.ToolTipRole)  # 设置下拉内容提示
        self.TypeSelect.insertItem(6, self.Lang.ProgrammingQuestions)  # 设置下拉内容
        self.TypeSelect.setItemData(6, self.Lang.ProgrammingQuestions, Qt.ToolTipRole)  # 设置下拉内容提示
        self.TypeSelect.insertItem(7, self.Lang.DragAndDrop)  # 设置下拉内容
        self.TypeSelect.setItemData(7, self.Lang.DragAndDrop, Qt.ToolTipRole)  # 设置下拉内容提示
        self.TypeSelect.insertItem(8, self.Lang.ConnectingQuestion)  # 设置下拉内容
        self.TypeSelect.setItemData(8, self.Lang.ConnectingQuestion, Qt.ToolTipRole)  # 设置下拉内容提示
        self.TypeSelect.setCurrentIndex(0)  # 设置默认选项
        self.PageButtonLayout.addWidget(self.TypeSelect)  # 添加控件

        self.KnowledgeSelect = QComboBox()  # 设置下拉框
        self.KnowledgeSelect.adjustSize()  # 按内容自适应宽度
        self.KnowledgeSelect.setView(QListView())  # 设置内容控件
        self.KnowledgeSelect.setFixedHeight(30)  # 尺寸
        self.KnowledgeSelect.setStyleSheet(self.QuestionStyleSheet.SelectBox())  # 设置样式
        self.KnowledgeSelect.insertItem(0, self.Lang.KnowledgePoint)  # 设置下拉内容
        self.KnowledgeSelect.setItemData(0, self.Lang.KnowledgePoint, Qt.ToolTipRole)  # 设置下拉内容提示
        Knowledge = self.KnowledgeController.Knowledge()
        if len(Knowledge['Data']) > 0:
            KnowledgeData = Knowledge['Data']
            j = 1
            for i in range(len(KnowledgeData)):
                Data = KnowledgeData[i]
                self.KnowledgeSelect.insertItem(j, Data['KnowledgeName'])  # 设置下拉内容
                self.KnowledgeSelect.setItemData(j, Data['KnowledgeName'], Qt.ToolTipRole)  # 设置下拉内容提示
                self.KnowledgeSelect.setItemData(j, Data['ID'])
                j += 1
        self.KnowledgeSelect.setCurrentIndex(0)  # 设置默认选项
        self.PageButtonLayout.addWidget(self.KnowledgeSelect)  # 添加控件

        # 确认按钮
        self.ConfirmButton = QPushButton(self.Lang.Confirm)
        self.ConfirmButton.setStyleSheet(self.QuestionStyleSheet.Button())  # 设置样式
        self.ConfirmButton.setFixedHeight(30)  # 尺寸
        self.ConfirmButton.clicked.connect(lambda: self.TreeDataInit())  # 连接槽函数
        self.PageButtonLayout.addWidget(self.ConfirmButton)  # 添加控件

        # =====================================================================================================================================================================

        # 页码按钮布局
        self.PNButtonLayout = QHBoxLayout()  # 设置按钮布局

        # 上一页
        self.PreviousPageButton = QPushButton(self.Lang.PreviousPage)
        self.PreviousPageButton.setStyleSheet(self.QuestionStyleSheet.Button())  # 设置样式
        self.PreviousPageButton.setFixedHeight(30)  # 尺寸
        self.PreviousPageButton.clicked.connect(lambda: self.SetPreviousPage())  # 连接槽函数
        self.PNButtonLayout.addWidget(self.PreviousPageButton)  # 添加控件

        # 下一页
        self.NextPageButton = QPushButton(self.Lang.NextPage)
        self.NextPageButton.setStyleSheet(self.QuestionStyleSheet.Button())  # 设置样式
        self.NextPageButton.setFixedHeight(30)  # 尺寸
        self.NextPageButton.clicked.connect(lambda: self.SetNextPage())  # 连接槽函数
        self.PNButtonLayout.addWidget(self.NextPageButton)  # 添加控件

        # =====================================================================================================================================================================

        self.ButtonLayout = QHBoxLayout()  # 设置按钮布局

        # 新建
        self.NewQuestionButton = QPushButton(self.Lang.NewQuestion)
        self.NewQuestionButton.setStyleSheet(self.QuestionStyleSheet.Button())  # 设置样式
        self.NewQuestionButton.setFixedHeight(30)  # 尺寸
        self.NewQuestionButton.clicked.connect(lambda: self.NewQuestionWindow())  # 连接槽函数
        self.ButtonLayout.addWidget(self.NewQuestionButton)  # 添加控件

        # 刷新
        self.RefreshButton = QPushButton(self.Lang.Refresh)
        self.RefreshButton.setStyleSheet(self.QuestionStyleSheet.Button())  # 设置样式
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
        Type = self.TypeSelect.currentIndex()
        State = self.StateSelect.currentIndex()
        KnowledgeID = self.KnowledgeSelect.currentData()
        Result = self.QuestionController.QuestionList(Page, PageSize, Stext, Type, State, KnowledgeID)
        self.TotalPageNo = Result['TotalPage']
        self.TotalPage.setText(self.Lang.TotalPages + ' ' + str(self.TotalPageNo))

        if Result['State'] != True:
            self.MSGBOX.ERROR(Result['Memo'])
        else:
            Data = Result['Data']

            # 树状列表
            self.QuestionTree = BaseTreeWidget()
            self.QuestionTree.SetSelectionMode(2)  # 设置选择模式
            self.QuestionTree.setStyleSheet(self.QuestionStyleSheet.TreeWidget())  # 设置样式
            self.QuestionTree.setColumnCount(14)  # 设置列数
            self.QuestionTree.hideColumn(5)  # 隐藏列
            self.QuestionTree.hideColumn(6)  # 隐藏列
            self.QuestionTree.hideColumn(7)  # 隐藏列
            self.QuestionTree.hideColumn(8)  # 隐藏列
            self.QuestionTree.hideColumn(9)  # 隐藏列
            self.QuestionTree.hideColumn(10)  # 隐藏列
            self.QuestionTree.hideColumn(11)  # 隐藏列
            self.QuestionTree.hideColumn(12)  # 隐藏列
            self.QuestionTree.hideColumn(13)  # 隐藏列
            self.QuestionTree.setHeaderLabels([
                'ID',
                self.Lang.QuestionType,
                self.Lang.QuestionTitle,
                self.Lang.QuestionStatus,
                self.Lang.CreationTime,
                'UpdateTime',
                'Description',
                'QuestionCode',
                'KnowledgeID',
                'Attachment',
                'Language',
                'LanguageVersion',
                'Marking',
            ])  # 设置标题栏
            # self.QuestionTree.header().setSectionResizeMode(0, QHeaderView.ResizeToContents)  # 列宽自适应数据长度
            self.QuestionTree.Connect(self.RightContextMenuExec)  # 鼠标右键菜单 链接槽函数
            self.TreeLayout.addWidget(self.QuestionTree)  # 添加控件

            if len(Data) > 0:
                TreeItems = []
                for i in range(len(Data)):
                    item = QTreeWidgetItem()  # 设置item控件
                    # item.setIcon(0, QtGui.QIcon(os.getcwd() + '/avatar.png'))
                    item.setText(0, str(Data[i]['ID']))  # 设置内容
                    if Data[i]['QuestionType'] == 1:
                        item.setText(1, self.Lang.MultipleChoiceQuestions)  # 设置内容
                    elif Data[i]['QuestionType'] == 2:
                        item.setText(1, self.Lang.TrueOrFalse)  # 设置内容
                    elif Data[i]['QuestionType'] == 3:
                        item.setText(1, self.Lang.MultipleChoices)  # 设置内容
                    elif Data[i]['QuestionType'] == 4:
                        item.setText(1, self.Lang.FillInTheBlank)  # 设置内容
                    elif Data[i]['QuestionType'] == 5:
                        item.setText(1, self.Lang.QuestionsAndAnswers)  # 设置内容
                    elif Data[i]['QuestionType'] == 6:
                        item.setText(1, self.Lang.ProgrammingQuestions)  # 设置内容
                    elif Data[i]['QuestionType'] == 7:
                        item.setText(1, self.Lang.DragAndDrop)  # 设置内容
                    elif Data[i]['QuestionType'] == 8:
                        item.setText(1, self.Lang.ConnectingQuestion)  # 设置内容
                    else:
                        item.setText(1, '')  # 设置内容
                    item.setText(2, Data[i]['QuestionTitle'])  # 设置内容
                    if Data[i]['QuestionState'] == 1:
                        item.setText(3, self.Lang.Normal)  # 设置内容
                    else:
                        item.setText(3, self.Lang.Disabled)  # 设置内容
                    item.setText(4, self.Common.TimeToStr(Data[i]['CreateTime']))  # 设置内容
                    item.setText(5, str(Data[i]['UpdateTime']))  # 设置内容
                    item.setText(6, Data[i]['Description'])  # 设置内容
                    item.setText(7, Data[i]['QuestionCode'])  # 设置内容
                    item.setText(8, str(Data[i]['KnowledgeID']))  # 设置内容
                    item.setText(9, Data[i]['Attachment'])  # 设置内容
                    item.setText(10, Data[i]['Language'])  # 设置内容
                    item.setText(11, Data[i]['LanguageVersion'])  # 设置内容
                    item.setText(12, str(Data[i]['Marking']))  # 设置内容
                    item.setText(13, str(Data[i]['QuestionType']))
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
                    TreeItems.append(item)  # 添加到item list
                self.QuestionTree.insertTopLevelItems(0, TreeItems)  # 添加到列表

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
        self.TreeMenu.setStyleSheet(self.QuestionStyleSheet.TreeMenu())  # 设置样式
        Item = self.QuestionTree.currentItem()  # 获取被点击行控件
        ItemAt = self.QuestionTree.itemAt(pos)  # 获取点击焦点

        # 展示判断
        if type(Item) == QTreeWidgetItem and type(ItemAt) == QTreeWidgetItem:  # 焦点内
            self.TreeMenu.AddAction(self.Lang.QuestionDetails, lambda: self.InfoWindow(Item))
            self.TreeMenu.AddAction(self.Lang.UploadAttachment, lambda: self.UploadAttachment(Item))
            self.TreeMenu.AddAction(self.Lang.QuestionOptions, lambda: self.QuestionOptions(Item))
            self.TreeMenu.AddAction(self.Lang.Disable, lambda: self.DisableAction())
        else:  # 焦点外
            return

        self.TreeMenu.move(QCursor().pos())  # 移动到焦点
        self.TreeMenu.show()  # 展示

    # 节点数据详情
    def InfoWindow(self, Item):
        ID: int = int(Item.text(0))
        QuestionTitle: str = Item.text(2)
        QuestionType: int = int(Item.text(13))
        Description: str = Item.text(6)
        Language: str = Item.text(10)
        LanguageVersion: str = Item.text(11)
        Attachment: str = Item.text(9)
        UpdateTime: int = int(Item.text(5))
        KnowledgeID: int = int(Item.text(8))

        self.QuestionDetailsView = QDialog()
        self.QuestionDetailsView.setWindowTitle(TITLE)
        self.QuestionDetailsView.setWindowModality(Qt.ApplicationModal)  # 禁止其他所有窗口交互
        self.QuestionDetailsView.setStyleSheet(self.QuestionStyleSheet.Dialog())  # 设置样式
        self.QuestionDetailsView.setMinimumWidth(322)  # 尺寸

        VLayout = QVBoxLayout()

        TitleLayout = QHBoxLayout()

        self.TitleInput = QLineEdit()  # 输入
        self.TitleInput.setText(QuestionTitle)  # 设置内容
        self.TitleInput.setFixedHeight(30)  # 尺寸
        self.TitleInput.setAlignment(Qt.AlignVCenter | Qt.AlignHCenter)  # 内容居中
        self.TitleInput.setPlaceholderText(self.Lang.QuestionTitle)  # 设置空内容提示
        self.TitleInput.setStyleSheet(self.QuestionStyleSheet.InputBox())  # 设置样式
        self.TitleInput.setToolTip(self.Lang.QuestionTitle)  # 设置鼠标提示
        TitleLayout.addWidget(self.TitleInput)  # 添加控件

        VacancyButton = QPushButton(self.Lang.SetVacancy)  # 填空题设置空位按钮
        VacancyButton.setStyleSheet(self.QuestionStyleSheet.Button())  # 设置样式
        VacancyButton.setFixedHeight(30)  # 尺寸
        VacancyButton.setMinimumWidth(120)  # 尺寸
        VacancyButton.clicked.connect(lambda: self.SetVacancy2())
        TitleLayout.addWidget(VacancyButton)  # 添加控件

        if QuestionType == 4:
            VacancyButton.show()
        else:
            VacancyButton.hide()

        VLayout.addLayout(TitleLayout)

        DescriptionInput = QTextEdit()  # 输入
        DescriptionInput.setText(Description)  # 设置内容
        # DescriptionInput.setFixedHeight(30)  # 尺寸
        # DescriptionInput.setAlignment(Qt.AlignVCenter | Qt.AlignHCenter)  # 内容居中
        DescriptionInput.setPlaceholderText(self.Lang.Description)  # 设置空内容提示
        DescriptionInput.setStyleSheet(self.QuestionStyleSheet.TextEdit())  # 设置样式
        DescriptionInput.setToolTip(self.Lang.Description)  # 设置鼠标提示
        VLayout.addWidget(DescriptionInput)  # 添加控件

        if QuestionType == 6:
            LanguageInput = QComboBox()  # 设置下拉框
            LanguageInput.adjustSize()  # 按内容自适应宽度
            LanguageInput.setView(QListView())  # 设置内容控件
            LanguageInput.setFixedHeight(30)  # 尺寸
            LanguageInput.setStyleSheet(self.QuestionStyleSheet.SelectBox())  # 设置样式
            LanguageInput.insertItem(0, '')  # 设置下拉内容
            LanguageInput.insertItem(1, 'Java')  # 设置下拉内容
            LanguageInput.setItemData(1, 'Java', Qt.ToolTipRole)  # 设置下拉内容提示
            LanguageInput.insertItem(2, 'PHP')  # 设置下拉内容
            LanguageInput.setItemData(2, 'PHP', Qt.ToolTipRole)  # 设置下拉内容提示
            LanguageInput.insertItem(3, 'JavaScript')  # 设置下拉内容
            LanguageInput.setItemData(3, 'JavaScript', Qt.ToolTipRole)  # 设置下拉内容提示
            LanguageInput.insertItem(4, 'Python')  # 设置下拉内容
            LanguageInput.setItemData(4, 'Python', Qt.ToolTipRole)  # 设置下拉内容提示
            LanguageInput.insertItem(5, 'C')  # 设置下拉内容
            LanguageInput.setItemData(5, 'C', Qt.ToolTipRole)  # 设置下拉内容提示
            if Language.lower() == 'java':
                LanguageInput.setCurrentIndex(1)  # 设置默认选项
            elif Language.lower() == 'php':
                LanguageInput.setCurrentIndex(2)
            elif Language.lower() == 'javascript':
                LanguageInput.setCurrentIndex(3)
            elif Language.lower() == 'python':
                LanguageInput.setCurrentIndex(4)
            elif Language.lower() == 'c':
                LanguageInput.setCurrentIndex(5)
            else:
                LanguageInput.setCurrentIndex(0)  # 设置默认选项
            VLayout.addWidget(LanguageInput)  # 添加控件

            LanguageVersionInput = QLineEdit()
            LanguageVersionInput.setText(LanguageVersion)  # 设置内容
            LanguageVersionInput.setFixedHeight(30)  # 尺寸
            LanguageVersionInput.setAlignment(Qt.AlignVCenter | Qt.AlignHCenter)  # 内容居中
            LanguageVersionInput.setPlaceholderText(self.Lang.ComputerLanguageVersion)  # 设置空内容提示
            LanguageVersionInput.setStyleSheet(self.QuestionStyleSheet.InputBox())  # 设置样式
            LanguageVersionInput.setToolTip(self.Lang.ComputerLanguageVersion)  # 设置鼠标提示
            VLayout.addWidget(LanguageVersionInput)  # 添加控件

        KnowledgeInput = QLineEdit()
        KnowledgeInfo = self.KnowledgeController.KnowledgeInfo(KnowledgeID)
        if KnowledgeInfo['State'] == True:
            KnowledgeInput.setText(KnowledgeInfo['Data']['KnowledgeName'])  # 设置内容
        KnowledgeInput.setFixedHeight(30)  # 尺寸
        KnowledgeInput.setAlignment(Qt.AlignVCenter | Qt.AlignHCenter)  # 内容居中
        KnowledgeInput.setPlaceholderText(self.Lang.KnowledgePoint)  # 设置空内容提示
        KnowledgeInput.setStyleSheet(self.QuestionStyleSheet.InputBox())  # 设置样式
        KnowledgeInput.setToolTip(self.Lang.KnowledgePoint)  # 设置鼠标提示
        KnowledgeInput.setEnabled(False)  # 禁止输入
        VLayout.addWidget(KnowledgeInput)  # 添加控件

        UpdateTimeInput = QLineEdit()
        UpdateTimeInput.setText(self.Common.TimeToStr(UpdateTime))  # 设置内容
        UpdateTimeInput.setFixedHeight(30)  # 尺寸
        UpdateTimeInput.setAlignment(Qt.AlignVCenter | Qt.AlignHCenter)  # 内容居中
        UpdateTimeInput.setPlaceholderText(self.Lang.UpdateTime)  # 设置空内容提示
        UpdateTimeInput.setStyleSheet(self.QuestionStyleSheet.InputBox())  # 设置样式
        UpdateTimeInput.setToolTip(self.Lang.UpdateTime)  # 设置鼠标提示
        UpdateTimeInput.setEnabled(False)  # 禁止输入
        VLayout.addWidget(UpdateTimeInput)  # 添加控件

        ViewAttachmentsButton = QPushButton(self.Lang.ViewAttachments)  # 按钮
        ViewAttachmentsButton.setStyleSheet(self.QuestionStyleSheet.Button())  # 设置样式
        ViewAttachmentsButton.setFixedHeight(30)  # 尺寸
        ViewAttachmentsButton.clicked.connect(lambda: self.ViewAttachments(Attachment))
        self.ButtonLayout.addWidget(ViewAttachmentsButton)  # 添加控件
        VLayout.addWidget(ViewAttachmentsButton)

        UpdateButton = QPushButton(self.Lang.Confirm)  # 按钮
        UpdateButton.setStyleSheet(self.QuestionStyleSheet.Button())  # 设置样式
        UpdateButton.setFixedHeight(30)  # 尺寸
        if QuestionType == 6:
            UpdateButton.clicked.connect(lambda: self.InfoWindowAction(
                ID,
                self.TitleInput.text(),
                QuestionType,
                DescriptionInput.toPlainText(),
                LanguageInput.currentText(),
                LanguageVersionInput.text(),
            ))  # 连接槽函数
        else:
            UpdateButton.clicked.connect(lambda: self.InfoWindowAction(
                ID,
                self.TitleInput.text(),
                QuestionType,
                DescriptionInput.toPlainText(),
                '',
                '',
            ))  # 连接槽函数
        self.ButtonLayout.addWidget(UpdateButton)  # 添加控件
        VLayout.addWidget(UpdateButton)

        self.QuestionDetailsView.setLayout(VLayout)  # 添加布局
        self.QuestionDetailsView.show()

    # 更新信息
    def InfoWindowAction(self, ID: int, QuestionTitle: str, QuestionType: int, Description: str, Language: str, LanguageVersion: str):
        Result = self.QuestionController.UpdateQuestionInfo(ID, QuestionTitle, QuestionType, Description, Language, LanguageVersion)
        if Result['State'] != True:
            self.MSGBOX.ERROR(Result['Memo'])
        else:
            self.QuestionDetailsView.close()
            self.TreeDataInit()

    # 上传附件
    def UploadAttachment(self, Item):
        ID: int = int(Item.text(0))
        File, _ = QFileDialog.getOpenFileName(self, 'Select the file', self.FileHelper.BaseDir() + 'Tempo', '')
        FilePath = str(File)
        if FilePath != '':
            Result = self.QuestionController.QuestionAttachment(ID, FilePath)  # 导入
            if Result['State'] != True:
                self.MSGBOX.ERROR(Result['Memo'])
            else:
                self.TreeDataInit()

    # 查看附件
    def ViewAttachments(self, FilePath: str):
        Result = self.QuestionController.QuestionViewAttachments(FilePath)
        if Result['State'] == True:
            FileData: bytes = self.Common.Base64ToBytes(Result['Data'])
            DemoPath = self.FileHelper.BaseDir() + 'Tempo' + '/' + str(self.Common.TimeMS()) + '.' + Result['Memo']
            if self.FileHelper.WFileInByte(DemoPath, FileData) == False:
                self.MSGBOX.ERROR(self.Lang.OperationFailed)
            else:
                try:
                    self.FileHelper.OpenLocalDir(DemoPath)
                except OSError as e:
                    self.MSGBOX.ERROR(e)

    # 试题选项
    def QuestionOptions(self, Item):
        ID: int = int(Item.text(0))
        QuestionType: int = int(Item.text(13))
        if QuestionType <= 0:
            self.MSGBOX.ERROR(self.Lang.OperationFailed)
        else:
            self.OptionsWindow = OptionsWindow(ID, QuestionType)
            self.OptionsWindow.ActionSignal.connect(self.TreeDataInit)
            self.OptionsWindow.show()

    # 修改节点数据
    def DisableAction(self):
        Questions = self.QuestionTree.selectedItems()
        for i in range(len(Questions)):
            Item = Questions[i]
            ID: int = int(Item.text(0))
            Result = self.QuestionController.QuestionDisabled(ID)
            if Result['State'] != True:
                self.TreeDataInit()
                self.MSGBOX.ERROR('ID:' + str(ID) + ' ' + Item.text(2) + ' ' + Result['Memo'])
                break
            else:
                self.TreeDataInit()

    # 新建节点
    def NewQuestionWindow(self):
        self.NewQuestionView = QDialog()
        self.NewQuestionView.setWindowTitle(TITLE)
        self.NewQuestionView.setWindowModality(Qt.ApplicationModal)  # 禁止其他所有窗口交互
        self.NewQuestionView.setStyleSheet(self.QuestionStyleSheet.Dialog())  # 设置样式
        self.NewQuestionView.setMinimumSize(352, 450)  # 尺寸

        VLayout = QVBoxLayout()

        TitleLayout = QHBoxLayout()

        self.QuestionTitleInput = QLineEdit()  # 输入
        self.QuestionTitleInput.setFixedHeight(30)  # 尺寸
        self.QuestionTitleInput.setAlignment(Qt.AlignVCenter | Qt.AlignHCenter)  # 内容居中
        self.QuestionTitleInput.setPlaceholderText(self.Lang.QuestionTitle)  # 设置空内容提示
        self.QuestionTitleInput.setStyleSheet(self.QuestionStyleSheet.InputBox())  # 设置样式
        self.QuestionTitleInput.setToolTip(self.Lang.QuestionTitle)  # 设置鼠标提示
        TitleLayout.addWidget(self.QuestionTitleInput)  # 添加控件

        self.VacancyButton = QPushButton(self.Lang.SetVacancy)  # 填空题设置空位按钮
        self.VacancyButton.setStyleSheet(self.QuestionStyleSheet.Button())  # 设置样式
        self.VacancyButton.setFixedHeight(30)  # 尺寸
        self.VacancyButton.setMinimumWidth(120)  # 尺寸
        self.VacancyButton.clicked.connect(lambda: self.SetVacancy1())
        self.VacancyButton.hide()
        TitleLayout.addWidget(self.VacancyButton)  # 添加控件

        VLayout.addLayout(TitleLayout)  # 添加布局

        # 试题类型 1单选 2判断 3多选 4填空 5问答 6编程 7拖拽 8连线
        self.QuestionTypeInput = QComboBox()  # 设置下拉框
        self.QuestionTypeInput.adjustSize()  # 按内容自适应宽度
        self.QuestionTypeInput.setView(QListView())  # 设置内容控件
        self.QuestionTypeInput.setFixedHeight(30)  # 尺寸
        self.QuestionTypeInput.setStyleSheet(self.QuestionStyleSheet.SelectBox())  # 设置样式
        self.QuestionTypeInput.insertItem(0, self.Lang.QuestionType)  # 设置下拉内容
        self.QuestionTypeInput.setItemData(0, self.Lang.QuestionType, Qt.ToolTipRole)  # 设置下拉内容提示
        self.QuestionTypeInput.insertItem(1, self.Lang.MultipleChoiceQuestions)  # 设置下拉内容
        self.QuestionTypeInput.setItemData(1, self.Lang.MultipleChoiceQuestions, Qt.ToolTipRole)  # 设置下拉内容提示
        self.QuestionTypeInput.insertItem(2, self.Lang.TrueOrFalse)  # 设置下拉内容
        self.QuestionTypeInput.setItemData(2, self.Lang.TrueOrFalse, Qt.ToolTipRole)  # 设置下拉内容提示
        self.QuestionTypeInput.insertItem(3, self.Lang.MultipleChoices)  # 设置下拉内容
        self.QuestionTypeInput.setItemData(3, self.Lang.MultipleChoices, Qt.ToolTipRole)  # 设置下拉内容提示
        self.QuestionTypeInput.insertItem(4, self.Lang.FillInTheBlank)  # 设置下拉内容
        self.QuestionTypeInput.setItemData(4, self.Lang.FillInTheBlank, Qt.ToolTipRole)  # 设置下拉内容提示
        self.QuestionTypeInput.insertItem(5, self.Lang.QuestionsAndAnswers)  # 设置下拉内容
        self.QuestionTypeInput.setItemData(5, self.Lang.QuestionsAndAnswers, Qt.ToolTipRole)  # 设置下拉内容提示
        self.QuestionTypeInput.insertItem(6, self.Lang.ProgrammingQuestions)  # 设置下拉内容
        self.QuestionTypeInput.setItemData(6, self.Lang.ProgrammingQuestions, Qt.ToolTipRole)  # 设置下拉内容提示
        self.QuestionTypeInput.insertItem(7, self.Lang.DragAndDrop)  # 设置下拉内容
        self.QuestionTypeInput.setItemData(7, self.Lang.DragAndDrop, Qt.ToolTipRole)  # 设置下拉内容提示
        self.QuestionTypeInput.insertItem(8, self.Lang.ConnectingQuestion)  # 设置下拉内容
        self.QuestionTypeInput.setItemData(8, self.Lang.ConnectingQuestion, Qt.ToolTipRole)  # 设置下拉内容提示
        self.QuestionTypeInput.setCurrentIndex(0)  # 设置默认选项
        self.QuestionTypeInput.activated.connect(lambda: self.ShowLanguageInfo())
        VLayout.addWidget(self.QuestionTypeInput)  # 添加控件

        # 选择科目
        self.SubjectInput = QComboBox()  # 设置下拉框
        self.SubjectInput.adjustSize()  # 按内容自适应宽度
        self.SubjectInput.setView(QListView())  # 设置内容控件
        self.SubjectInput.setFixedHeight(30)  # 尺寸
        self.SubjectInput.setStyleSheet(self.QuestionStyleSheet.SelectBox())  # 设置样式
        self.SubjectInput.insertItem(0, self.Lang.Subject)  # 设置下拉内容
        self.SubjectInput.setItemData(0, self.Lang.Subject, Qt.ToolTipRole)  # 设置下拉内容提示
        Subjects = self.SubjectController.Subjects()
        if len(Subjects['Data']) > 0:
            SubjectsData = Subjects['Data']
            j = 1
            for i in range(len(SubjectsData)):
                Data = SubjectsData[i]
                self.SubjectInput.insertItem(j, Data['SubjectName'])  # 设置下拉内容
                self.SubjectInput.setItemData(j, Data['SubjectName'], Qt.ToolTipRole)  # 设置下拉内容提示
                self.SubjectInput.setItemData(j, Data['ID'])  # 设值
                j += 1
        self.SubjectInput.setCurrentIndex(0)  # 设置默认选项
        self.SubjectInput.activated.connect(lambda: self.CheckKnowledge())
        VLayout.addWidget(self.SubjectInput)  # 添加控件

        # 选择知识点
        self.KnowledgeInput = QComboBox()  # 设置下拉框
        self.KnowledgeInput.adjustSize()  # 按内容自适应宽度
        self.KnowledgeInput.setView(QListView())  # 设置内容控件
        self.KnowledgeInput.setFixedHeight(30)  # 尺寸
        self.KnowledgeInput.setStyleSheet(self.QuestionStyleSheet.SelectBox())  # 设置样式
        # self.KnowledgeInput.insertItem(0, self.Lang.KnowledgePoint)  # 设置下拉内容
        # self.KnowledgeInput.setItemData(0, self.Lang.KnowledgePoint, Qt.ToolTipRole)  # 设置下拉内容提示
        # self.KnowledgeInput.setCurrentIndex(0)  # 设置默认选项
        VLayout.addWidget(self.KnowledgeInput)  # 添加控件

        DescriptionInput = QTextEdit()  # 输入
        # DescriptionInput.setText()  # 设置内容
        # DescriptionInput.setFixedHeight(30)  # 尺寸
        # DescriptionInput.setAlignment(Qt.AlignVCenter | Qt.AlignHCenter)  # 内容居中
        DescriptionInput.setPlaceholderText(self.Lang.Description)  # 设置空内容提示
        DescriptionInput.setStyleSheet(self.QuestionStyleSheet.TextEdit())  # 设置样式
        DescriptionInput.setToolTip(self.Lang.Description)  # 设置鼠标提示
        VLayout.addWidget(DescriptionInput)  # 添加控件

        self.LanguageInput = QComboBox()  # 设置下拉框
        self.LanguageInput.adjustSize()  # 按内容自适应宽度
        self.LanguageInput.setView(QListView())  # 设置内容控件
        self.LanguageInput.setFixedHeight(30)  # 尺寸
        self.LanguageInput.setStyleSheet(self.QuestionStyleSheet.SelectBox())  # 设置样式
        self.LanguageInput.insertItem(0, '')  # 设置下拉内容
        self.LanguageInput.setItemData(0, self.Lang.ComputerLanguages, Qt.ToolTipRole)  # 设置下拉内容提示
        self.LanguageInput.insertItem(1, 'Java')  # 设置下拉内容
        self.LanguageInput.setItemData(1, 'Java', Qt.ToolTipRole)  # 设置下拉内容提示
        self.LanguageInput.insertItem(2, 'PHP')  # 设置下拉内容
        self.LanguageInput.setItemData(2, 'PHP', Qt.ToolTipRole)  # 设置下拉内容提示
        self.LanguageInput.insertItem(3, 'JavaScript')  # 设置下拉内容
        self.LanguageInput.setItemData(3, 'JavaScript', Qt.ToolTipRole)  # 设置下拉内容提示
        self.LanguageInput.insertItem(4, 'Python')  # 设置下拉内容
        self.LanguageInput.setItemData(4, 'Python', Qt.ToolTipRole)  # 设置下拉内容提示
        self.LanguageInput.insertItem(5, 'C')  # 设置下拉内容
        self.LanguageInput.setItemData(5, 'C', Qt.ToolTipRole)  # 设置下拉内容提示
        self.LanguageInput.hide()
        VLayout.addWidget(self.LanguageInput)  # 添加控件

        self.LanguageVersionInput = QLineEdit()
        self.LanguageVersionInput.setFixedHeight(30)  # 尺寸
        self.LanguageVersionInput.setAlignment(Qt.AlignVCenter | Qt.AlignHCenter)  # 内容居中
        self.LanguageVersionInput.setPlaceholderText(self.Lang.ComputerLanguageVersion)  # 设置空内容提示
        self.LanguageVersionInput.setStyleSheet(self.QuestionStyleSheet.InputBox())  # 设置样式
        self.LanguageVersionInput.setToolTip(self.Lang.ComputerLanguageVersion)  # 设置鼠标提示
        self.LanguageVersionInput.hide()
        VLayout.addWidget(self.LanguageVersionInput)  # 添加控件

        AddButton = QPushButton(self.Lang.Confirm)  # 按钮
        AddButton.setStyleSheet(self.QuestionStyleSheet.Button())  # 设置样式
        AddButton.setFixedHeight(30)  # 尺寸
        AddButton.clicked.connect(lambda: self.NewQuestionAction(
            self.QuestionTitleInput.text(),
            self.QuestionTypeInput.currentIndex(),
            self.KnowledgeInput.currentText(),
            DescriptionInput.toPlainText(),
            self.LanguageInput.currentText(),
            self.LanguageVersionInput.text(),
        ))  # 连接槽函数
        VLayout.addWidget(AddButton)

        self.NewQuestionView.setLayout(VLayout)  # 添加布局
        self.NewQuestionView.show()

    # 在指定位置设置填空题空位
    def SetVacancy1(self):
        self.QuestionTitleInput.insert('<->')

    # 在指定位置设置填空题空位
    def SetVacancy2(self):
        self.TitleInput.insert('<->')

    # 展示计算机语言项
    def ShowLanguageInfo(self):
        QuestionType: int = self.QuestionTypeInput.currentIndex()
        if QuestionType == 6:
            self.VacancyButton.hide()
            self.LanguageInput.show()
            self.LanguageVersionInput.show()
        elif QuestionType == 4:
            self.VacancyButton.show()
            self.LanguageInput.hide()
            self.LanguageVersionInput.hide()
        else:
            self.VacancyButton.hide()
            self.LanguageInput.hide()
            self.LanguageVersionInput.hide()

    # 选择知识点
    def CheckKnowledge(self):
        SubjectID: int = self.SubjectInput.currentData()
        if SubjectID is not None and SubjectID > 0:
            self.KnowledgeInput.clear()
            Knowledge = self.KnowledgeController.Knowledge(SubjectID)
            if len(Knowledge['Data']) > 0:
                KnowledgeData = Knowledge['Data']
                j = 1
                for i in range(len(KnowledgeData)):
                    Data = KnowledgeData[i]
                    self.KnowledgeInput.insertItem(j, 'ID:' + str(Data['ID']) + ' ' + Data['KnowledgeName'])  # 设置下拉内容
                    self.KnowledgeInput.setItemData(j, Data['KnowledgeName'], Qt.ToolTipRole)  # 设置下拉内容提示
                    self.KnowledgeInput.setItemData(j, Data['ID'])  # 设值
                    j += 1

    # 新建
    def NewQuestionAction(
        self,
        QuestionTitle: str,
        QuestionType: int,
        KnowledgeInputStr: str,
        Description: str,
        Language: str,
        LanguageVersion: str,
    ):
        KnowledgeID: int = 0
        if KnowledgeInputStr != '':
            KnowledgeID = int(KnowledgeInputStr.split(' ')[0].strip().split(':')[1])
        else:
            KnowledgeID = 0
        Result = self.QuestionController.NewQuestion(QuestionTitle, QuestionType, KnowledgeID, Description, Language, LanguageVersion)
        if Result['State'] != True:
            self.MSGBOX.ERROR(Result['Memo'])
        else:
            self.NewQuestionView.close()  # 关闭窗口
            self.TreeDataInit()  # 主控件写入数据


# 试题选项窗口
class OptionsWindow(BaseTemplate, QDialog):
    ActionSignal = Signal()  # 设置信号

    def __init__(self, QuestionID: int, QuestionType: int):
        super().__init__()
        self.QuestionID = QuestionID
        self.QuestionType = QuestionType
        self.Options = []
        self.QuestionSolutionController = QuestionSolutionController()
        self.QuestionStyleSheet = QuestionStyleSheet()
        self.setWindowTitle(TITLE)
        self.setMinimumSize(722, 350)  # 尺寸
        self.setWindowModality(Qt.ApplicationModal)  # 禁止其他所有窗口交互
        self.setStyleSheet(self.QuestionStyleSheet.Dialog())  # 设置样式
        self.VLayout = QVBoxLayout()
        self.TreeDataInit()
        self.setLayout(self.VLayout)

    def TreeDataInit(self, Position: int = 0):
        self.ClearLayout(self.VLayout)
        self.OptionsTree = BaseTreeWidget()
        self.OptionsTree.SetSelectionMode(2)  # 设置选择模式
        self.OptionsTree.setStyleSheet(self.QuestionStyleSheet.TreeWidget())  # 设置样式
        self.OptionsTree.setColumnCount(10)  # 设置列数
        self.OptionsTree.setHeaderLabels([
            'ID',
            self.Lang.QuestionOptions,
            self.Lang.ScoreProportion,
            self.Lang.CorrectAnswer,
            self.Lang.Position,
            self.Lang.CorrectItem,
            'QuestionID',
            'OptionAttachment',
            'UpdateTime',
            self.Lang.CreationTime,
        ])  # 设置标题栏
        self.OptionsTree.Connect(self.RightContextMenuExec)  # 鼠标右键菜单 链接槽函数
        self.VLayout.addWidget(self.OptionsTree)  # 添加控件

        ButtonLayout = QHBoxLayout()

        LeftButton = QPushButton(self.Lang.Left)  # 按钮
        LeftButton.setStyleSheet(self.QuestionStyleSheet.Button())  # 设置样式
        LeftButton.setFixedSize(120, 30)  # 尺寸
        LeftButton.clicked.connect(lambda: self.TreeDataInit(1))
        ButtonLayout.addWidget(LeftButton)

        RightButton = QPushButton(self.Lang.Right)  # 按钮
        RightButton.setStyleSheet(self.QuestionStyleSheet.Button())  # 设置样式
        RightButton.setFixedSize(120, 30)  # 尺寸
        RightButton.clicked.connect(lambda: self.TreeDataInit(2))
        ButtonLayout.addWidget(RightButton)

        AllButton = QPushButton(self.Lang.All)  # 按钮
        AllButton.setStyleSheet(self.QuestionStyleSheet.Button())  # 设置样式
        AllButton.setFixedSize(120, 30)  # 尺寸
        AllButton.clicked.connect(lambda: self.TreeDataInit(0))
        ButtonLayout.addWidget(AllButton)

        NewOptionButton = QPushButton(self.Lang.NewOption)
        NewOptionButton.setStyleSheet(self.QuestionStyleSheet.Button())  # 设置样式
        NewOptionButton.setFixedHeight(30)  # 尺寸
        NewOptionButton.clicked.connect(lambda: self.NewOption())  # 连接槽函数
        ButtonLayout.addWidget(NewOptionButton)  # 添加控件

        self.VLayout.addLayout(ButtonLayout)

        Result = self.QuestionSolutionController.QuestionSolutions(self.QuestionID, Position)
        if Result['State'] != True:
            self.MSGBOX.ERROR(Result['Memo'])
        else:
            self.Options = Result['Data']

        # 写入试题选项
        if len(self.Options) > 0:
            TreeItems = []
            for i in range(len(self.Options)):
                item = QTreeWidgetItem()  # 设置item控件
                Data = self.Options[i]
                # item.setIcon(0, QtGui.QIcon(os.getcwd() + '/avatar.png'))
                item.setText(0, str(Data['ID']))  # 设置内容
                item.setText(1, Data['Option'])  # 设置内容
                item.setText(2, str(Data['ScoreRatio']))  # 设置内容
                if Data['CorrectAnswer'] == 2:
                    item.setText(3, self.Lang.CorrectOption)  # 设置内容
                else:
                    item.setText(3, self.Lang.WrongOption)  # 设置内容
                if Data['Position'] == 1:
                    item.setText(4, self.Lang.Left)  # 设置内容
                else:
                    item.setText(4, self.Lang.Right)  # 设置内容
                item.setText(5, Data['CorrectItem'])  # 设置内容
                item.setText(6, str(Data['QuestionID']))  # 设置内容
                item.setText(7, Data['OptionAttachment'])  # 设置内容
                item.setText(8, str(Data['UpdateTime']))  # 设置内容
                item.setText(9, self.Common.TimeToStr(Data['CreateTime']))  # 设置内容
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
                TreeItems.append(item)  # 添加到item list
            self.OptionsTree.insertTopLevelItems(0, TreeItems)  # 添加到列表

        # 试题类型 1单选 2判断 3多选 4填空 5问答 6代码实训 7拖拽题 8连线题
        if self.QuestionType >= 1 and self.QuestionType <= 3:
            # self.OptionsTree.hideColumn(0)  # 隐藏列
            # self.OptionsTree.hideColumn(1)  # 隐藏列
            self.OptionsTree.hideColumn(2)  # 隐藏列
            # self.OptionsTree.hideColumn(3)  # 隐藏列
            self.OptionsTree.hideColumn(4)  # 隐藏列
            self.OptionsTree.hideColumn(5)  # 隐藏列
            self.OptionsTree.hideColumn(6)  # 隐藏列
            self.OptionsTree.hideColumn(7)  # 隐藏列
            self.OptionsTree.hideColumn(8)  # 隐藏列
            # self.OptionsTree.hideColumn(9)  # 隐藏列
        elif self.QuestionType >= 4 and self.QuestionType <= 5:
            # self.OptionsTree.hideColumn(0)  # 隐藏列
            self.OptionsTree.hideColumn(1)  # 隐藏列
            # self.OptionsTree.hideColumn(2)  # 隐藏列
            self.OptionsTree.hideColumn(3)  # 隐藏列
            self.OptionsTree.hideColumn(4)  # 隐藏列
            # self.OptionsTree.hideColumn(5)  # 隐藏列
            self.OptionsTree.hideColumn(6)  # 隐藏列
            self.OptionsTree.hideColumn(7)  # 隐藏列
            self.OptionsTree.hideColumn(8)  # 隐藏列
            # self.OptionsTree.hideColumn(9)  # 隐藏列
        elif self.QuestionType == 6:
            # self.OptionsTree.hideColumn(0)  # 隐藏列
            self.OptionsTree.hideColumn(1)  # 隐藏列
            self.OptionsTree.hideColumn(2)  # 隐藏列
            self.OptionsTree.hideColumn(3)  # 隐藏列
            self.OptionsTree.hideColumn(4)  # 隐藏列
            # self.OptionsTree.hideColumn(5)  # 隐藏列
            self.OptionsTree.hideColumn(6)  # 隐藏列
            self.OptionsTree.hideColumn(7)  # 隐藏列
            self.OptionsTree.hideColumn(8)  # 隐藏列
            # self.OptionsTree.hideColumn(9)  # 隐藏列
        elif self.QuestionType >= 7 and self.QuestionType <= 8:
            # self.OptionsTree.hideColumn(0)  # 隐藏列
            # self.OptionsTree.hideColumn(1)  # 隐藏列
            self.OptionsTree.hideColumn(2)  # 隐藏列
            # self.OptionsTree.hideColumn(3)  # 隐藏列
            # self.OptionsTree.hideColumn(4)  # 隐藏列
            # self.OptionsTree.hideColumn(5)  # 隐藏列
            self.OptionsTree.hideColumn(6)  # 隐藏列
            self.OptionsTree.hideColumn(7)  # 隐藏列
            self.OptionsTree.hideColumn(8)  # 隐藏列
            # self.OptionsTree.hideColumn(9)  # 隐藏列
        else:
            pass

    # 新建选项
    def NewOption(self):
        self.NewOptionView = QDialog()
        self.NewOptionView.setWindowTitle(TITLE)
        self.NewOptionView.setWindowModality(Qt.ApplicationModal)  # 禁止其他所有窗口交互
        self.NewOptionView.setStyleSheet(self.QuestionStyleSheet.Dialog())  # 设置样式
        self.NewOptionView.setMinimumSize(352, 350)  # 尺寸

        VLayout = QVBoxLayout()

        if self.QuestionType >= 1 and self.QuestionType <= 3:
            '''
            Option
            CorrectAnswer
            '''

            OptionInput = QTextEdit()  # 输入
            # OptionInput.setText()  # 设置内容
            # OptionInput.setFixedHeight(30)  # 尺寸
            # OptionInput.setAlignment(Qt.AlignVCenter | Qt.AlignHCenter)  # 内容居中
            OptionInput.setPlaceholderText(self.Lang.Content)  # 设置空内容提示
            OptionInput.setStyleSheet(self.QuestionStyleSheet.TextEdit())  # 设置样式
            OptionInput.setToolTip(self.Lang.Content)  # 设置鼠标提示
            VLayout.addWidget(OptionInput)  # 添加控件

            CorrectAnswerSelect = QComboBox()  # 设置下拉框
            CorrectAnswerSelect.adjustSize()  # 按内容自适应宽度
            CorrectAnswerSelect.setView(QListView())  # 设置内容控件
            CorrectAnswerSelect.setFixedHeight(30)  # 尺寸
            CorrectAnswerSelect.setStyleSheet(self.QuestionStyleSheet.SelectBox())  # 设置样式
            CorrectAnswerSelect.insertItem(0, self.Lang.CorrectItem)  # 设置下拉内容
            CorrectAnswerSelect.setItemData(0, self.Lang.CorrectItem, Qt.ToolTipRole)  # 设置下拉内容提示
            CorrectAnswerSelect.insertItem(1, self.Lang.WrongOption)  # 设置下拉内容
            CorrectAnswerSelect.setItemData(1, self.Lang.WrongOption, Qt.ToolTipRole)  # 设置下拉内容提示
            CorrectAnswerSelect.insertItem(2, self.Lang.CorrectOption)  # 设置下拉内容
            CorrectAnswerSelect.setItemData(2, self.Lang.CorrectOption, Qt.ToolTipRole)  # 设置下拉内容提示
            CorrectAnswerSelect.setCurrentIndex(0)  # 设置默认选项
            VLayout.addWidget(CorrectAnswerSelect)  # 添加控件

            AddButton = QPushButton(self.Lang.Confirm)  # 按钮
            AddButton.setStyleSheet(self.QuestionStyleSheet.Button())  # 设置样式
            AddButton.setFixedHeight(30)  # 尺寸
            AddButton.clicked.connect(lambda: self.NewOptionAction(
                self.QuestionID,
                OptionInput.toPlainText(),
                CorrectAnswerSelect.currentIndex(),
                '',
                0,
                0,
            ))  # 连接槽函数
            VLayout.addWidget(AddButton)
        elif self.QuestionType >= 4 and self.QuestionType <= 5:
            '''
            CorrectItem
            ScoreRatio
            '''

            CorrectItemInput = QTextEdit()  # 输入
            # CorrectItemInput.setText()  # 设置内容
            # CorrectItemInput.setFixedHeight(30)  # 尺寸
            # CorrectItemInput.setAlignment(Qt.AlignVCenter | Qt.AlignHCenter)  # 内容居中
            CorrectItemInput.setPlaceholderText(self.Lang.Content)  # 设置空内容提示
            CorrectItemInput.setStyleSheet(self.QuestionStyleSheet.TextEdit())  # 设置样式
            CorrectItemInput.setToolTip(self.Lang.Content)  # 设置鼠标提示
            VLayout.addWidget(CorrectItemInput)  # 添加控件

            ScoreRatioInput = QLineEdit()  # 输入
            ScoreRatioInput.setFixedHeight(30)  # 尺寸
            ScoreRatioInput.setAlignment(Qt.AlignVCenter | Qt.AlignHCenter)  # 内容居中
            ScoreRatioInput.setPlaceholderText(self.Lang.ScoreProportion)  # 设置空内容提示
            ScoreRatioInput.setStyleSheet(self.QuestionStyleSheet.InputBox())  # 设置样式
            ScoreRatioInput.setToolTip(self.Lang.ScoreProportion)  # 设置鼠标提示
            VLayout.addWidget(ScoreRatioInput)  # 添加控件

            AddButton = QPushButton(self.Lang.Confirm)  # 按钮
            AddButton.setStyleSheet(self.QuestionStyleSheet.Button())  # 设置样式
            AddButton.setFixedHeight(30)  # 尺寸
            AddButton.clicked.connect(lambda: self.NewOptionAction(
                self.QuestionID,
                '',
                0,
                CorrectItemInput.toPlainText(),
                ScoreRatioInput.text(),
                0,
            ))  # 连接槽函数
            VLayout.addWidget(AddButton)
        elif self.QuestionType == 6:
            '''
            CorrectItem
            '''

            CorrectItemInput = QTextEdit()  # 输入
            # CorrectItemInput.setText()  # 设置内容
            # CorrectItemInput.setFixedHeight(30)  # 尺寸
            # CorrectItemInput.setAlignment(Qt.AlignVCenter | Qt.AlignHCenter)  # 内容居中
            CorrectItemInput.setPlaceholderText(self.Lang.Content)  # 设置空内容提示
            CorrectItemInput.setStyleSheet(self.QuestionStyleSheet.TextEdit())  # 设置样式
            CorrectItemInput.setToolTip(self.Lang.Content)  # 设置鼠标提示
            VLayout.addWidget(CorrectItemInput)  # 添加控件

            AddButton = QPushButton(self.Lang.Confirm)  # 按钮
            AddButton.setStyleSheet(self.QuestionStyleSheet.Button())  # 设置样式
            AddButton.setFixedHeight(30)  # 尺寸
            AddButton.clicked.connect(lambda: self.NewOptionAction(
                self.QuestionID,
                '',
                0,
                CorrectItemInput.toPlainText(),
                0,
                0,
            ))  # 连接槽函数
            VLayout.addWidget(AddButton)
        elif self.QuestionType == 7 or self.QuestionType == 8:
            '''
            Option
            Position
            CorrectItem
            '''

            OptionInput = QTextEdit()  # 输入
            # OptionInput.setText()  # 设置内容
            # OptionInput.setFixedHeight(30)  # 尺寸
            # OptionInput.setAlignment(Qt.AlignVCenter | Qt.AlignHCenter)  # 内容居中
            OptionInput.setPlaceholderText(self.Lang.Content)  # 设置空内容提示
            OptionInput.setStyleSheet(self.QuestionStyleSheet.TextEdit())  # 设置样式
            OptionInput.setToolTip(self.Lang.Content)  # 设置鼠标提示
            VLayout.addWidget(OptionInput)  # 添加控件

            HLayout = QHBoxLayout()

            CorrectAnswerLabel = QLabel(self.Lang.CorrectAnswer)
            CorrectAnswerLabel.setFixedHeight(30)  # 尺寸
            CorrectAnswerLabel.setAlignment(Qt.AlignVCenter | Qt.AlignHCenter)  # 字体居中
            CorrectAnswerLabel.adjustSize()  # 根据内容自适应宽度
            CorrectAnswerLabel.setStyleSheet(self.QuestionStyleSheet.Label())  # 设置样式
            HLayout.addWidget(CorrectAnswerLabel)  # 添加控件

            CorrectItemInput = QLineEdit()  # 输入
            CorrectItemInput.setFixedHeight(30)  # 尺寸
            CorrectItemInput.setAlignment(Qt.AlignVCenter | Qt.AlignHCenter)  # 内容居中
            CorrectItemInput.setPlaceholderText(self.Lang.Left + self.Lang.QuestionTitle)  # 设置空内容提示
            CorrectItemInput.setStyleSheet(self.QuestionStyleSheet.InputBox())  # 设置样式
            CorrectItemInput.setToolTip(self.Lang.Left + self.Lang.QuestionTitle)  # 设置鼠标提示
            HLayout.addWidget(CorrectItemInput)  # 添加控件

            VLayout.addLayout(HLayout)

            PositionSelect = QComboBox()  # 设置下拉框
            PositionSelect.adjustSize()  # 按内容自适应宽度
            PositionSelect.setView(QListView())  # 设置内容控件
            PositionSelect.setFixedHeight(30)  # 尺寸
            PositionSelect.setStyleSheet(self.QuestionStyleSheet.SelectBox())  # 设置样式
            PositionSelect.insertItem(0, self.Lang.Position)  # 设置下拉内容
            PositionSelect.setItemData(0, self.Lang.Position, Qt.ToolTipRole)  # 设置下拉内容提示
            PositionSelect.insertItem(1, self.Lang.Left)  # 设置下拉内容
            PositionSelect.setItemData(1, self.Lang.Left, Qt.ToolTipRole)  # 设置下拉内容提示
            PositionSelect.insertItem(2, self.Lang.Right)  # 设置下拉内容
            PositionSelect.setItemData(2, self.Lang.Right, Qt.ToolTipRole)  # 设置下拉内容提示
            PositionSelect.setCurrentIndex(0)  # 设置默认选项
            VLayout.addWidget(PositionSelect)  # 添加控件

            AddButton = QPushButton(self.Lang.Confirm)  # 按钮
            AddButton.setStyleSheet(self.QuestionStyleSheet.Button())  # 设置样式
            AddButton.setFixedHeight(30)  # 尺寸
            AddButton.clicked.connect(lambda: self.NewOptionAction(
                self.QuestionID,
                OptionInput.toPlainText(),
                0,
                CorrectItemInput.text(),
                0,
                PositionSelect.currentIndex(),
            ))  # 连接槽函数
            VLayout.addWidget(AddButton)
        else:
            return

        self.NewOptionView.setLayout(VLayout)  # 添加布局
        self.NewOptionView.show()

    # 新建试题选项
    def NewOptionAction(
        self,
        QuestionID: int,
        Option: str,
        CorrectAnswer: int,
        CorrectItem: str,
        ScoreRatio: float,
        Position: int,
    ):
        if Position == 1 and CorrectItem != '':
            self.MSGBOX.ERROR(self.Lang.CannotBeSetOnTheLeft)
        else:
            Result = self.QuestionSolutionController.NewQuestionSolution(QuestionID, Option, CorrectAnswer, CorrectItem, ScoreRatio, Position)
            if Result['State'] != True:
                self.MSGBOX.ERROR(Result['Memo'])
            else:
                self.ActionSignal.emit()
                self.NewOptionView.close()  # 关闭窗口
                self.TreeDataInit()  # 主控件写入数据

    # 列表节点右键菜单
    def RightContextMenuExec(self, pos):
        self.TreeMenu = BaseMenu()
        self.TreeMenu.setStyleSheet(self.QuestionStyleSheet.TreeMenu())  # 设置样式
        Item = self.OptionsTree.currentItem()  # 获取被点击行控件
        ItemAt = self.OptionsTree.itemAt(pos)  # 获取点击焦点

        # 展示判断
        if type(Item) == QTreeWidgetItem and type(ItemAt) == QTreeWidgetItem:  # 焦点内
            self.TreeMenu.AddAction(self.Lang.UploadAttachment, lambda: self.UploadAttachment(Item))
            self.TreeMenu.AddAction(self.Lang.ViewAttachments, lambda: self.QuestionSolutionViewAttachments(Item))
            self.TreeMenu.AddAction(self.Lang.Delete, lambda: self.DeleteAction())
            if (self.QuestionType == 7 or self.QuestionType == 8) and Item.text(4) == self.Lang.Left:
                self.TreeMenu.AddAction(self.Lang.Copy + self.Lang.QuestionTitle, lambda: self.CopyQuestionTitleAction(Item))
        else:  # 焦点外
            return

        self.TreeMenu.move(QCursor().pos())  # 移动到焦点
        self.TreeMenu.show()  # 展示

    def UploadAttachment(self, Item):
        ID: int = int(Item.text(0))
        File, _ = QFileDialog.getOpenFileName(self, 'Select the file', self.FileHelper.BaseDir() + 'Tempo', '')
        FilePath = str(File)
        if FilePath != '':
            Result = self.QuestionSolutionController.QuestionSolutionAttachment(ID, FilePath)  # 导入
            if Result['State'] != True:
                self.MSGBOX.ERROR(Result['Memo'])
            else:
                self.TreeDataInit()

    def QuestionSolutionViewAttachments(self, Item):
        FilePath: str = Item.text(7)
        Result = self.QuestionSolutionController.QuestionSolutionViewAttachments(FilePath)
        if Result['State'] == True:
            FileData: bytes = self.Common.Base64ToBytes(Result['Data'])
            DemoPath = self.FileHelper.BaseDir() + 'Tempo' + '/' + str(self.Common.TimeMS()) + '.' + Result['Memo']
            if self.FileHelper.WFileInByte(DemoPath, FileData) == False:
                self.MSGBOX.ERROR(self.Lang.OperationFailed)
            else:
                try:
                    self.FileHelper.OpenLocalDir(DemoPath)
                except OSError as e:
                    self.MSGBOX.ERROR(e)

    def DeleteAction(self):
        Options = self.OptionsTree.selectedItems()
        for i in range(len(Options)):
            Item = Options[i]
            ID: int = int(Item.text(0))
            if ID > 1:
                Result = self.QuestionSolutionController.QuestionSolutionDelete(ID)
                if Result['State'] != True:
                    self.MSGBOX.ERROR(Result['Memo'])
                    break
                else:
                    self.ActionSignal.emit()
                    self.TreeDataInit()

    def CopyQuestionTitleAction(self, Item):
        Title: str = Item.text(1)
        clipboard = QApplication.clipboard()  # 创建剪切板对象
        clipboard.setText(Title)  # 用于向剪切板写入文本
        # print(clipboard.text())  # 用于从剪切板读出文本