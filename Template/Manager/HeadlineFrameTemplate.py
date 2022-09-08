# -*- coding:utf-8 -*-
from Template.BaseTemplate import *
from StyleSheet.Manager.HeadlineStyleSheet import *


# 大标题管理界面
class HeadlineFrameTemplate(BaseTemplate, QFrame):

    def __init__(self):
        super().__init__()
        self.HeadlineStyleSheet = HeadlineStyleSheet()
        self.HeadlineController = HeadlineController()
        self.setStyleSheet(self.HeadlineStyleSheet.BaseStyleSheet())  # 设置样式

        self.CenterLayout = QVBoxLayout()  # 设置主布局

        # 标题栏
        self.Headline = QLabel(self.Lang.Headline)
        self.Headline.setAlignment(Qt.AlignVCenter | Qt.AlignHCenter)  # 字体居中
        self.Headline.adjustSize()  # 根据内容自适应宽度
        self.Headline.setFixedHeight(30)  # 尺寸
        self.Headline.setStyleSheet(self.HeadlineStyleSheet.Headline())  # 设置样式
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
        self.CurrentPage.setStyleSheet(self.HeadlineStyleSheet.CurrentPage())  # 设置样式
        self.PageButtonLayout.addWidget(self.CurrentPage)  # 添加控件

        # 总页码数
        self.TotalPage = QLabel(self.Lang.TotalPages + ' ' + str(self.TotalPageNo))
        self.TotalPage.setAlignment(Qt.AlignVCenter | Qt.AlignHCenter)  # 字体居中
        self.TotalPage.adjustSize()  # 根据内容自适应宽度
        self.TotalPage.setFixedSize(120, 30)  # 尺寸
        self.TotalPage.setStyleSheet(self.HeadlineStyleSheet.CurrentPage())  # 设置样式
        self.PageButtonLayout.addWidget(self.TotalPage)  # 添加控件

        # 输入页码
        self.PageInput = QLineEdit()
        self.PageInput.setValidator(self.QIntValidator)  # 输入为整数类型
        self.PageInput.setFixedSize(170, 30)  # 尺寸
        self.PageInput.setAlignment(Qt.AlignVCenter | Qt.AlignHCenter)  # 内容居中
        self.PageInput.setPlaceholderText(self.Lang.EnterPageNumber)  # 设置空内容提示
        self.PageInput.setStyleSheet(self.HeadlineStyleSheet.InputBox())  # 设置样式
        self.PageInput.setToolTip(self.Lang.EnterPageNumber)  # 设置鼠标提示
        self.PageButtonLayout.addWidget(self.PageInput)  # 添加控件

        # 每一页展示行数
        self.RowsInput = QLineEdit()
        self.RowsInput.setValidator(self.QIntValidator)  # 输入为整数类型
        self.RowsInput.setFixedSize(170, 30)  # 尺寸
        self.RowsInput.setAlignment(Qt.AlignVCenter | Qt.AlignHCenter)  # 内容居中
        self.RowsInput.setPlaceholderText(self.Lang.EnterTheNumberOfLines)  # 设置空内容提示
        self.RowsInput.setStyleSheet(self.HeadlineStyleSheet.InputBox())  # 设置样式
        self.RowsInput.setToolTip(self.Lang.EnterTheNumberOfLines)  # 设置鼠标提示
        self.PageButtonLayout.addWidget(self.RowsInput)  # 添加控件

        # 搜索
        self.SearchInput = QLineEdit()
        self.SearchInput.setFixedSize(170, 30)  # 尺寸
        self.SearchInput.setAlignment(Qt.AlignVCenter | Qt.AlignHCenter)  # 内容居中
        self.SearchInput.setPlaceholderText(self.Lang.Search)  # 设置空内容提示
        self.SearchInput.setStyleSheet(self.HeadlineStyleSheet.InputBox())  # 设置样式
        self.SearchInput.setToolTip(self.Lang.Search)  # 设置鼠标提示
        self.PageButtonLayout.addWidget(self.SearchInput)  # 添加控件

        # 确认按钮
        self.ConfirmButton = QPushButton(self.Lang.Confirm)
        self.ConfirmButton.setStyleSheet(self.HeadlineStyleSheet.Button())  # 设置样式
        self.ConfirmButton.setFixedHeight(30)  # 尺寸
        self.ConfirmButton.clicked.connect(lambda: self.TreeDataInit())  # 连接槽函数
        self.PageButtonLayout.addWidget(self.ConfirmButton)  # 添加控件

        # =====================================================================================================================================================================

        # 页码按钮布局
        self.PNButtonLayout = QHBoxLayout()  # 设置按钮布局

        # 上一页
        self.PreviousPageButton = QPushButton(self.Lang.PreviousPage)
        self.PreviousPageButton.setStyleSheet(self.HeadlineStyleSheet.Button())  # 设置样式
        self.PreviousPageButton.setFixedHeight(30)  # 尺寸
        self.PreviousPageButton.clicked.connect(lambda: self.SetPreviousPage())  # 连接槽函数
        self.PNButtonLayout.addWidget(self.PreviousPageButton)  # 添加控件

        # 下一页
        self.NextPageButton = QPushButton(self.Lang.NextPage)
        self.NextPageButton.setStyleSheet(self.HeadlineStyleSheet.Button())  # 设置样式
        self.NextPageButton.setFixedHeight(30)  # 尺寸
        self.NextPageButton.clicked.connect(lambda: self.SetNextPage())  # 连接槽函数
        self.PNButtonLayout.addWidget(self.NextPageButton)  # 添加控件

        # =====================================================================================================================================================================

        self.ButtonLayout = QHBoxLayout()  # 设置按钮布局

        # 新建
        self.NewHeadlineButton = QPushButton(self.Lang.NewHeadline)
        self.NewHeadlineButton.setStyleSheet(self.HeadlineStyleSheet.Button())  # 设置样式
        self.NewHeadlineButton.setFixedHeight(30)  # 尺寸
        self.NewHeadlineButton.clicked.connect(lambda: self.NewHeadlineWindow())  # 连接槽函数
        self.ButtonLayout.addWidget(self.NewHeadlineButton)  # 添加控件

        # 刷新
        self.RefreshButton = QPushButton(self.Lang.Refresh)
        self.RefreshButton.setStyleSheet(self.HeadlineStyleSheet.Button())  # 设置样式
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
        Result = self.HeadlineController.HeadlineList(Page, PageSize, Stext)
        self.TotalPageNo = Result['TotalPage']
        self.TotalPage.setText(self.Lang.TotalPages + ' ' + str(self.TotalPageNo))

        if Result['State'] != True:
            self.MSGBOX.ERROR(Result['Memo'])
        else:
            Data = Result['Data']

            # 树状列表
            self.HeadlineTree = BaseTreeWidget()
            self.HeadlineTree.SetSelectionMode(2)  # 设置选择模式
            self.HeadlineTree.setStyleSheet(self.HeadlineStyleSheet.TreeWidget())  # 设置样式
            self.HeadlineTree.setColumnCount(5)  # 设置列数
            self.HeadlineTree.hideColumn(3)  # 隐藏列
            self.HeadlineTree.hideColumn(4)  # 隐藏列
            self.HeadlineTree.setHeaderLabels(['ID', self.Lang.Content, self.Lang.CreationTime, 'UpdateTime', 'ContentCode'])  # 设置标题栏
            # self.HeadlineTree.header().setSectionResizeMode(0, QHeaderView.ResizeToContents)  # 列宽自适应数据长度
            self.HeadlineTree.Connect(self.RightContextMenuExec)  # 鼠标右键菜单 链接槽函数
            self.TreeLayout.addWidget(self.HeadlineTree)  # 添加控件

            if len(Data) > 0:
                TreeItems = []
                for i in range(len(Data)):
                    item = QTreeWidgetItem()  # 设置item控件
                    # item.setIcon(0, QtGui.QIcon(os.getcwd() + '/avatar.png'))
                    item.setText(0, str(Data[i]['ID']))  # 设置内容
                    item.setText(1, Data[i]['Content'])  # 设置内容
                    item.setText(2, self.Common.TimeToStr(Data[i]['CreateTime']))  # 设置内容
                    item.setText(3, str(Data[i]['UpdateTime']))  # 设置内容
                    item.setText(4, Data[i]['ContentCode'])  # 设置内容
                    item.setTextAlignment(0, Qt.AlignHCenter | Qt.AlignVCenter)  # 设置item字体居中
                    item.setTextAlignment(1, Qt.AlignHCenter | Qt.AlignVCenter)  # 设置item字体居中
                    item.setTextAlignment(2, Qt.AlignHCenter | Qt.AlignVCenter)  # 设置item字体居中
                    item.setTextAlignment(3, Qt.AlignHCenter | Qt.AlignVCenter)  # 设置item字体居中
                    item.setTextAlignment(4, Qt.AlignHCenter | Qt.AlignVCenter)  # 设置item字体居中
                    TreeItems.append(item)  # 添加到item list
                self.HeadlineTree.insertTopLevelItems(0, TreeItems)  # 添加到列表

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
        self.TreeMenu.setStyleSheet(self.HeadlineStyleSheet.TreeMenu())  # 设置样式
        Item = self.HeadlineTree.currentItem()  # 获取被点击行控件
        ItemAt = self.HeadlineTree.itemAt(pos)  # 获取点击焦点

        # 展示判断
        if type(Item) == QTreeWidgetItem and type(ItemAt) == QTreeWidgetItem:  # 焦点内
            self.TreeMenu.AddAction(self.Lang.HeadlineDetails, lambda: self.InfoWindow(Item))
        else:  # 焦点外
            return

        self.TreeMenu.move(QCursor().pos())  # 移动到焦点
        self.TreeMenu.show()  # 展示

    # 节点数据详情
    def InfoWindow(self, Item):
        ID: int = int(Item.text(0))
        Content: str = Item.text(1)
        UpdateTime: int = Item.text(3)
        ContentCode: int = Item.text(4)

        self.HeadlineDetailsView = QDialog()
        self.HeadlineDetailsView.setWindowTitle(TITLE)
        self.HeadlineDetailsView.setWindowModality(Qt.ApplicationModal)  # 禁止其他所有窗口交互
        self.HeadlineDetailsView.setStyleSheet(self.HeadlineStyleSheet.Dialog())  # 设置样式
        self.HeadlineDetailsView.setMinimumWidth(322)  # 尺寸

        VLayout = QVBoxLayout()

        ContentInput = QTextEdit()  # 输入
        ContentInput.setText(Content)  # 设置内容
        # ContentInput.setFixedHeight(30)  # 尺寸
        # ContentInput.setAlignment(Qt.AlignVCenter | Qt.AlignHCenter)  # 内容居中
        ContentInput.setPlaceholderText(self.Lang.Content)  # 设置空内容提示
        ContentInput.setStyleSheet(self.HeadlineStyleSheet.TextEdit())  # 设置样式
        ContentInput.setToolTip(self.Lang.Content)  # 设置鼠标提示
        VLayout.addWidget(ContentInput)  # 添加控件

        ContentCodeInput = QLineEdit()
        ContentCodeInput.setText(ContentCode)  # 设置内容
        ContentCodeInput.setFixedHeight(30)  # 尺寸
        ContentCodeInput.setAlignment(Qt.AlignVCenter | Qt.AlignHCenter)  # 内容居中
        ContentCodeInput.setPlaceholderText(self.Lang.ContentCode)  # 设置空内容提示
        ContentCodeInput.setStyleSheet(self.HeadlineStyleSheet.InputBox())  # 设置样式
        ContentCodeInput.setToolTip(self.Lang.ContentCode)  # 设置鼠标提示
        ContentCodeInput.setEnabled(False)  # 禁止输入
        VLayout.addWidget(ContentCodeInput)  # 添加控件

        UpdateTimeInput = QLineEdit()
        UpdateTimeInput.setText(self.Common.TimeToStr(UpdateTime))  # 设置内容
        UpdateTimeInput.setFixedHeight(30)  # 尺寸
        UpdateTimeInput.setAlignment(Qt.AlignVCenter | Qt.AlignHCenter)  # 内容居中
        UpdateTimeInput.setPlaceholderText(self.Lang.UpdateTime)  # 设置空内容提示
        UpdateTimeInput.setStyleSheet(self.HeadlineStyleSheet.InputBox())  # 设置样式
        UpdateTimeInput.setToolTip(self.Lang.UpdateTime)  # 设置鼠标提示
        UpdateTimeInput.setEnabled(False)  # 禁止输入
        VLayout.addWidget(UpdateTimeInput)  # 添加控件

        UpdateButton = QPushButton(self.Lang.Confirm)  # 按钮
        UpdateButton.setStyleSheet(self.HeadlineStyleSheet.Button())  # 设置样式
        UpdateButton.setFixedHeight(30)  # 尺寸
        UpdateButton.clicked.connect(lambda: self.InfoWindowAction(ID, ContentInput.toPlainText(), Content))  # 连接槽函数
        self.ButtonLayout.addWidget(UpdateButton)  # 添加控件
        VLayout.addWidget(UpdateButton)

        self.HeadlineDetailsView.setLayout(VLayout)  # 添加布局
        self.HeadlineDetailsView.show()

    # 更新信息
    def InfoWindowAction(self, ID: int, Content: str, OldContent: str):
        if Content != OldContent:
            Result = self.HeadlineController.UpdateHeadlineInfo(ID, Content)
            if Result['State'] != True:
                self.MSGBOX.ERROR(Result['Memo'])
            else:
                self.HeadlineDetailsView.close()
                self.TreeDataInit()

    # 新建节点
    def NewHeadlineWindow(self):
        self.NewHeadlineView = QDialog()
        self.NewHeadlineView.setWindowTitle(TITLE)
        self.NewHeadlineView.setWindowModality(Qt.ApplicationModal)  # 禁止其他所有窗口交互
        self.NewHeadlineView.setStyleSheet(self.HeadlineStyleSheet.Dialog())  # 设置样式
        self.NewHeadlineView.setMinimumWidth(322)  # 尺寸

        VLayout = QVBoxLayout()

        ContentInput = QTextEdit()  # 输入
        # ContentInput.setFixedHeight(30)  # 尺寸
        # ContentInput.setAlignment(Qt.AlignVCenter | Qt.AlignHCenter)  # 内容居中
        ContentInput.setPlaceholderText(self.Lang.Content)  # 设置空内容提示
        ContentInput.setStyleSheet(self.HeadlineStyleSheet.TextEdit())  # 设置样式
        ContentInput.setToolTip(self.Lang.Content)  # 设置鼠标提示
        VLayout.addWidget(ContentInput)  # 添加控件

        AddButton = QPushButton(self.Lang.Confirm)  # 按钮
        AddButton.setStyleSheet(self.HeadlineStyleSheet.Button())  # 设置样式
        AddButton.setFixedHeight(30)  # 尺寸
        AddButton.clicked.connect(lambda: self.NewHeadlineAction(ContentInput.toPlainText()))  # 连接槽函数
        VLayout.addWidget(AddButton)

        self.NewHeadlineView.setLayout(VLayout)  # 添加布局
        self.NewHeadlineView.show()

    # 新建
    def NewHeadlineAction(self, Content: str):
        if Content != '':
            Result = self.HeadlineController.NewHeadline(Content)
            if Result['State'] != True:
                self.MSGBOX.ERROR(Result['Memo'])
            else:
                self.NewHeadlineView.close()  # 关闭窗口
                self.TreeDataInit()  # 主控件写入数据