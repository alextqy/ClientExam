# -*- coding:utf-8 -*-
from Template.BaseTemplate import *
from StyleSheet.Manager.QuestionStyleSheet import *


# 管理员管理界面
class QuestionFrameTemplate(BaseTemplate, QFrame):

    def __init__(self):
        super().__init__()
        self.QuestionStyleSheet = QuestionStyleSheet()
        self.QuestionController = QuestionController()
        self.KnowledgeController = KnowledgeController()
        self.setStyleSheet(self.QuestionStyleSheet.BaseStyleSheet())  # 设置样式

        self.CenterLayout = QVBoxLayout()  # 设置主布局
        self.CenterLayout.setContentsMargins(0, 0, 0, 0)  # 设置边距

        # 标题栏
        self.Headline = QLabel(self.Lang.Question)
        self.Headline.setAlignment(Qt.AlignVCenter | Qt.AlignHCenter)  # 字体居中
        self.Headline.adjustSize()  # 根据内容自适应宽度
        self.Headline.setFixedHeight(30)  # 尺寸
        self.Headline.setContentsMargins(0, 0, 0, 0)  # 设置边距
        self.Headline.setStyleSheet(self.QuestionStyleSheet.Headline())  # 设置样式
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
        self.CurrentPage.setStyleSheet(self.QuestionStyleSheet.CurrentPage())  # 设置样式
        self.PageButtonLayout.addWidget(self.CurrentPage)  # 添加控件

        # 总页码数
        self.TotalPage = QLabel(self.Lang.TotalPages + ' ' + str(self.TotalPageNo))
        self.TotalPage.setAlignment(Qt.AlignVCenter | Qt.AlignHCenter)  # 字体居中
        self.TotalPage.adjustSize()  # 根据内容自适应宽度
        self.TotalPage.setFixedSize(120, 30)  # 尺寸
        self.TotalPage.setContentsMargins(0, 0, 0, 0)  # 设置边距
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
        self.StateSelect.setMinimumWidth(100)  # 尺寸
        self.StateSelect.setStyleSheet(self.QuestionStyleSheet.SelectBox())  # 设置样式
        self.StateSelect.insertItem(0, ' ' + self.Lang.QuestionStatus)  # 设置下拉内容
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
        self.TypeSelect.setMinimumWidth(100)  # 尺寸
        self.TypeSelect.setStyleSheet(self.QuestionStyleSheet.SelectBox())  # 设置样式
        self.TypeSelect.insertItem(0, ' ' + self.Lang.QuestionType)  # 设置下拉内容
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
        self.KnowledgeSelect.setMinimumWidth(100)  # 尺寸
        self.KnowledgeSelect.setStyleSheet(self.QuestionStyleSheet.SelectBox())  # 设置样式
        self.KnowledgeSelect.insertItem(0, ' ' + self.Lang.KnowledgePoint)  # 设置下拉内容
        self.KnowledgeSelect.setItemData(0, self.Lang.KnowledgePoint, Qt.ToolTipRole)  # 设置下拉内容提示
        Knowledge = self.KnowledgeController.Knowledge()
        if len(Knowledge['Data']) > 0:
            self.Classes = Knowledge['Data']
            j = 1
            for i in range(len(self.Classes)):
                Data = self.Classes[i]
                self.KnowledgeSelect.insertItem(j, Data['KnowledgeName'])  # 设置下拉内容
                self.KnowledgeSelect.setItemData(j, Data['KnowledgeName'], Qt.ToolTipRole)  # 设置下拉内容提示
                self.KnowledgeSelect.setWhatsThis(str(Data['ID']))
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
        self.PNButtonLayout.setContentsMargins(0, 0, 0, 0)  # 设置边距

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
        self.ButtonLayout.setContentsMargins(0, 0, 0, 0)  # 设置边距

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
        KnowledgeID = self.KnowledgeSelect.currentIndex()
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
            self.QuestionTree.hideColumn(14)  # 隐藏列
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
            self.QuestionTree.setContentsMargins(0, 0, 0, 0)  # 设置边距
            self.QuestionTree.Connect(self.RightContextMenuExec)  # 鼠标右键菜单 链接槽函数
            self.TreeLayout.addWidget(self.QuestionTree)  # 添加控件

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
        UpdateTime: int = int(Item.text(5))

        self.QuestionDetailsView = QDialog()
        self.QuestionDetailsView.setWindowTitle(TITLE)
        self.QuestionDetailsView.setWindowModality(Qt.ApplicationModal)  # 禁止其他所有窗口交互
        self.QuestionDetailsView.setStyleSheet(self.QuestionStyleSheet.Dialog())  # 设置样式
        self.QuestionDetailsView.setMinimumWidth(322)  # 尺寸

        VLayout = QVBoxLayout()

        TitleInput = QLineEdit()  # 输入
        TitleInput.setText(QuestionTitle)  # 设置内容
        TitleInput.setFixedHeight(30)  # 尺寸
        TitleInput.setAlignment(Qt.AlignVCenter | Qt.AlignHCenter)  # 内容居中
        TitleInput.setPlaceholderText(self.Lang.QuestionTitle)  # 设置空内容提示
        TitleInput.setStyleSheet(self.QuestionStyleSheet.InputBox())  # 设置样式
        TitleInput.setToolTip(self.Lang.QuestionTitle)  # 设置鼠标提示
        VLayout.addWidget(TitleInput)  # 添加控件

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
            LanguageInput.setMinimumWidth(100)  # 尺寸
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

        UpdateTimeInput = QLineEdit()
        UpdateTimeInput.setText(self.Common.TimeToStr(UpdateTime))  # 设置内容
        UpdateTimeInput.setFixedHeight(30)  # 尺寸
        UpdateTimeInput.setAlignment(Qt.AlignVCenter | Qt.AlignHCenter)  # 内容居中
        UpdateTimeInput.setPlaceholderText(self.Lang.UpdateTime)  # 设置空内容提示
        UpdateTimeInput.setStyleSheet(self.QuestionStyleSheet.InputBox())  # 设置样式
        UpdateTimeInput.setToolTip(self.Lang.UpdateTime)  # 设置鼠标提示
        UpdateTimeInput.setEnabled(False)  # 禁止输入
        VLayout.addWidget(UpdateTimeInput)  # 添加控件

        UpdateButton = QPushButton(self.Lang.Confirm)  # 按钮
        UpdateButton.setStyleSheet(self.QuestionStyleSheet.Button())  # 设置样式
        UpdateButton.setFixedHeight(30)  # 尺寸

        if QuestionType == 6:
            UpdateButton.clicked.connect(lambda: self.InfoWindowAction(
                ID,
                TitleInput.text(),
                QuestionType,
                DescriptionInput.toPlainText(),
                LanguageInput.currentText(),
                LanguageVersionInput.text(),
            ))  # 连接槽函数
        else:
            UpdateButton.clicked.connect(lambda: self.InfoWindowAction(
                ID,
                TitleInput.text(),
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

    # 试题选项
    def QuestionOptions(self, Item):
        ID: int = int(Item.text(0))

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
        pass

    # 新建
    def NewQuestionAction(self):
        pass