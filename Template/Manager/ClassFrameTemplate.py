# -*- coding:utf-8 -*-
from Template.BaseTemplate import *
from StyleSheet.Manager.ClassStyleSheet import *


# 班级管理界面
class ClassFrameTemplate(BaseTemplate, QFrame):

    def __init__(self):
        super().__init__()
        self.ClassStyleSheet = ClassStyleSheet()
        self.ClassController = ClassController()
        self.setStyleSheet(self.ClassStyleSheet.BaseStyleSheet())  # 设置样式

        self.CenterLayout = QVBoxLayout()  # 设置主布局
        self.CenterLayout.setContentsMargins(0, 0, 0, 0)  # 设置边距

        # 标题栏
        self.Headline = QLabel(self.Lang.Class)
        self.Headline.setAlignment(Qt.AlignVCenter | Qt.AlignHCenter)  # 字体居中
        self.Headline.adjustSize()  # 根据内容自适应宽度
        self.Headline.setFixedHeight(30)  # 尺寸
        self.Headline.setContentsMargins(0, 0, 0, 0)  # 设置边距
        self.Headline.setStyleSheet(self.ClassStyleSheet.Headline())  # 设置样式
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
        self.CurrentPage.setStyleSheet(self.ClassStyleSheet.CurrentPage())  # 设置样式
        self.PageButtonLayout.addWidget(self.CurrentPage)  # 添加控件

        # 总页码数
        self.TotalPage = QLabel(self.Lang.TotalPages + ' ' + str(self.TotalPageNo))
        self.TotalPage.setAlignment(Qt.AlignVCenter | Qt.AlignHCenter)  # 字体居中
        self.TotalPage.adjustSize()  # 根据内容自适应宽度
        self.TotalPage.setFixedSize(120, 30)  # 尺寸
        self.TotalPage.setContentsMargins(0, 0, 0, 0)  # 设置边距
        self.TotalPage.setStyleSheet(self.ClassStyleSheet.CurrentPage())  # 设置样式
        self.PageButtonLayout.addWidget(self.TotalPage)  # 添加控件

        # 输入页码
        self.PageInput = QLineEdit()
        self.PageInput.setValidator(self.QIntValidator)  # 输入为整数类型
        self.PageInput.setFixedSize(170, 30)  # 尺寸
        self.PageInput.setAlignment(Qt.AlignVCenter | Qt.AlignHCenter)  # 内容居中
        self.PageInput.setPlaceholderText(self.Lang.EnterPageNumber)  # 设置空内容提示
        self.PageInput.setStyleSheet(self.ClassStyleSheet.InputBox())  # 设置样式
        self.PageInput.setToolTip(self.Lang.EnterPageNumber)  # 设置鼠标提示
        self.PageButtonLayout.addWidget(self.PageInput)  # 添加控件

        # 每一页展示行数
        self.RowsInput = QLineEdit()
        self.RowsInput.setValidator(self.QIntValidator)  # 输入为整数类型
        self.RowsInput.setFixedSize(170, 30)  # 尺寸
        self.RowsInput.setAlignment(Qt.AlignVCenter | Qt.AlignHCenter)  # 内容居中
        self.RowsInput.setPlaceholderText(self.Lang.EnterTheNumberOfLines)  # 设置空内容提示
        self.RowsInput.setStyleSheet(self.ClassStyleSheet.InputBox())  # 设置样式
        self.RowsInput.setToolTip(self.Lang.EnterTheNumberOfLines)  # 设置鼠标提示
        self.PageButtonLayout.addWidget(self.RowsInput)  # 添加控件

        # 搜索
        self.SearchInput = QLineEdit()
        self.SearchInput.setFixedSize(170, 30)  # 尺寸
        self.SearchInput.setAlignment(Qt.AlignVCenter | Qt.AlignHCenter)  # 内容居中
        self.SearchInput.setPlaceholderText(self.Lang.Search)  # 设置空内容提示
        self.SearchInput.setStyleSheet(self.ClassStyleSheet.InputBox())  # 设置样式
        self.SearchInput.setToolTip(self.Lang.Search)  # 设置鼠标提示
        self.PageButtonLayout.addWidget(self.SearchInput)  # 添加控件

        # 确认按钮
        self.ConfirmButton = QPushButton(self.Lang.Confirm)
        self.ConfirmButton.setStyleSheet(self.ClassStyleSheet.Button())  # 设置样式
        self.ConfirmButton.setFixedHeight(30)  # 尺寸
        self.ConfirmButton.clicked.connect(lambda: self.TreeDataInit())  # 连接槽函数
        self.PageButtonLayout.addWidget(self.ConfirmButton)  # 添加控件

        # =====================================================================================================================================================================

        # 页码按钮布局
        self.PNButtonLayout = QHBoxLayout()  # 设置按钮布局
        self.PNButtonLayout.setContentsMargins(0, 0, 0, 0)  # 设置边距

        # 上一页
        self.PreviousPageButton = QPushButton(self.Lang.PreviousPage)
        self.PreviousPageButton.setStyleSheet(self.ClassStyleSheet.Button())  # 设置样式
        self.PreviousPageButton.setFixedHeight(30)  # 尺寸
        self.PreviousPageButton.clicked.connect(lambda: self.SetPreviousPage())  # 连接槽函数
        self.PNButtonLayout.addWidget(self.PreviousPageButton)  # 添加控件

        # 下一页
        self.NextPageButton = QPushButton(self.Lang.NextPage)
        self.NextPageButton.setStyleSheet(self.ClassStyleSheet.Button())  # 设置样式
        self.NextPageButton.setFixedHeight(30)  # 尺寸
        self.NextPageButton.clicked.connect(lambda: self.SetNextPage())  # 连接槽函数
        self.PNButtonLayout.addWidget(self.NextPageButton)  # 添加控件

        # =====================================================================================================================================================================

        self.ButtonLayout = QHBoxLayout()  # 设置按钮布局
        self.ButtonLayout.setContentsMargins(0, 0, 0, 0)  # 设置边距

        # 新建
        self.NewClassButton = QPushButton(self.Lang.NewClass)
        self.NewClassButton.setStyleSheet(self.ClassStyleSheet.Button())  # 设置样式
        self.NewClassButton.setFixedHeight(30)  # 尺寸
        self.NewClassButton.clicked.connect(lambda: self.NewClassWindow())  # 连接槽函数
        self.ButtonLayout.addWidget(self.NewClassButton)  # 添加控件

        # 刷新
        self.RefreshButton = QPushButton(self.Lang.Refresh)
        self.RefreshButton.setStyleSheet(self.ClassStyleSheet.Button())  # 设置样式
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
        Result = self.ClassController.ClassList(Page, PageSize, Stext)
        self.TotalPageNo = Result['TotalPage']
        self.TotalPage.setText(self.Lang.TotalPages + ' ' + str(self.TotalPageNo))

        if Result['State'] != True:
            self.MSGBOX.ERROR(Result['Memo'])
        else:
            Data = Result['Data']

            # 树状列表
            self.ClassTree = BaseTreeWidget()
            self.ClassTree.SetSelectionMode(2)  # 设置选择模式
            self.ClassTree.setStyleSheet(self.ClassStyleSheet.TreeWidget())  # 设置样式
            self.ClassTree.setColumnCount(5)  # 设置列数
            self.ClassTree.hideColumn(3)  # 隐藏列
            self.ClassTree.hideColumn(4)  # 隐藏列
            self.ClassTree.setHeaderLabels(['ID', self.Lang.ClassName, self.Lang.CreationTime, 'ClassCode', 'Description'])  # 设置标题栏
            self.ClassTree.setContentsMargins(0, 0, 0, 0)  # 设置边距
            self.ClassTree.Connect(self.RightContextMenuExec)  # 鼠标右键菜单 链接槽函数
            self.TreeLayout.addWidget(self.ClassTree)  # 添加控件

            if len(Data) > 0:
                TreeItems = []
                for i in range(len(Data)):
                    item = QTreeWidgetItem()  # 设置item控件
                    # item.setIcon(0, QtGui.QIcon(os.getcwd() + '/avatar.png'))
                    item.setText(0, str(Data[i]['ID']))  # 设置内容
                    item.setText(1, Data[i]['ClassName'])  # 设置内容
                    item.setText(2, self.Common.TimeToStr(Data[i]['CreateTime']))  # 设置内容
                    item.setText(3, Data[i]['ClassCode'])  # 设置内容
                    item.setText(4, Data[i]['Description'])  # 设置内容
                    item.setTextAlignment(0, Qt.AlignHCenter | Qt.AlignVCenter)  # 设置item字体居中
                    item.setTextAlignment(1, Qt.AlignHCenter | Qt.AlignVCenter)  # 设置item字体居中
                    item.setTextAlignment(2, Qt.AlignHCenter | Qt.AlignVCenter)  # 设置item字体居中
                    item.setTextAlignment(3, Qt.AlignHCenter | Qt.AlignVCenter)  # 设置item字体居中
                    item.setTextAlignment(4, Qt.AlignHCenter | Qt.AlignVCenter)  # 设置item字体居中
                    TreeItems.append(item)  # 添加到item list
                self.ClassTree.insertTopLevelItems(0, TreeItems)  # 添加到列表

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
        self.TreeMenu.setStyleSheet(self.ClassStyleSheet.TreeMenu())  # 设置样式
        Item = self.ClassTree.currentItem()  # 获取被点击行控件
        ItemAt = self.ClassTree.itemAt(pos)  # 获取点击焦点

        # 展示判断
        if type(Item) == QTreeWidgetItem and type(ItemAt) == QTreeWidgetItem:  # 焦点内
            self.TreeMenu.AddAction(self.Lang.ClassDetails, lambda: self.InfoWindow(Item))
        else:  # 焦点外
            return

        self.TreeMenu.move(QCursor().pos())  # 移动到焦点
        self.TreeMenu.show()  # 展示

    # 节点数据详情
    def InfoWindow(self, Item):
        ID: int = int(Item.text(0))
        Name: str = Item.text(1)
        ClassCode: str = Item.text(3)
        Description: str = Item.text(4)

        self.ClassDetailsView = QDialog()
        self.ClassDetailsView.setWindowTitle(TITLE)
        self.ClassDetailsView.setWindowModality(Qt.ApplicationModal)  # 禁止其他所有窗口交互
        self.ClassDetailsView.setStyleSheet(self.ClassStyleSheet.Dialog())  # 设置样式
        self.ClassDetailsView.setFixedSize(322, 160)  # 尺寸

        VLayout = QVBoxLayout()

        NameInput = QLineEdit()  # 输入
        NameInput.setText(Name)  # 设置内容
        NameInput.setFixedHeight(30)  # 尺寸
        NameInput.setAlignment(Qt.AlignVCenter | Qt.AlignHCenter)  # 内容居中
        NameInput.setPlaceholderText(self.Lang.ClassName)  # 设置空内容提示
        NameInput.setStyleSheet(self.ClassStyleSheet.InputBox())  # 设置样式
        NameInput.setToolTip(self.Lang.ClassName)  # 设置鼠标提示
        VLayout.addWidget(NameInput)  # 添加控件

        ClassCodeInput = QLineEdit()
        ClassCodeInput.setText(ClassCode)  # 设置内容
        ClassCodeInput.setFixedHeight(30)  # 尺寸
        ClassCodeInput.setAlignment(Qt.AlignVCenter | Qt.AlignHCenter)  # 内容居中
        ClassCodeInput.setPlaceholderText(self.Lang.ClassCode)  # 设置空内容提示
        ClassCodeInput.setStyleSheet(self.ClassStyleSheet.InputBox())  # 设置样式
        ClassCodeInput.setToolTip(self.Lang.ClassCode)  # 设置鼠标提示
        ClassCodeInput.setEnabled(False)  # 禁止输入
        VLayout.addWidget(ClassCodeInput)  # 添加控件

        DescriptionInput = QLineEdit()
        DescriptionInput.setText(Description)  # 设置内容
        DescriptionInput.setFixedHeight(30)  # 尺寸
        DescriptionInput.setAlignment(Qt.AlignVCenter | Qt.AlignHCenter)  # 内容居中
        DescriptionInput.setPlaceholderText(self.Lang.Description)  # 设置空内容提示
        DescriptionInput.setStyleSheet(self.ClassStyleSheet.InputBox())  # 设置样式
        DescriptionInput.setToolTip(self.Lang.Description)  # 设置鼠标提示
        VLayout.addWidget(DescriptionInput)  # 添加控件

        UpdateButton = QPushButton(self.Lang.Confirm)  # 按钮
        UpdateButton.setStyleSheet(self.ClassStyleSheet.Button())  # 设置样式
        UpdateButton.setFixedHeight(30)  # 尺寸
        UpdateButton.clicked.connect(lambda: self.InfoWindowAction(ID, NameInput.text(), DescriptionInput.text()))  # 连接槽函数
        self.ButtonLayout.addWidget(UpdateButton)  # 添加控件
        VLayout.addWidget(UpdateButton)

        self.ClassDetailsView.setLayout(VLayout)  # 添加布局
        self.ClassDetailsView.show()

    # 更新信息
    def InfoWindowAction(self, ID: int, Name: str, Description: str):
        Result = self.ClassController.UpdateClassInfo(ID, Name, Description)
        if Result['State'] != True:
            self.MSGBOX.ERROR(Result['Memo'])
        else:
            self.ClassDetailsView.close()
            self.TreeDataInit()

    # 新建节点
    def NewClassWindow(self):
        self.NewClassView = QDialog()
        self.NewClassView.setWindowTitle(TITLE)
        self.NewClassView.setWindowModality(Qt.ApplicationModal)  # 禁止其他所有窗口交互
        self.NewClassView.setStyleSheet(self.ClassStyleSheet.Dialog())  # 设置样式
        self.NewClassView.setFixedSize(222, 124)  # 尺寸

        VLayout = QVBoxLayout()

        NameInput = QLineEdit()  # 输入
        NameInput.setFixedHeight(30)  # 尺寸
        NameInput.setAlignment(Qt.AlignVCenter | Qt.AlignHCenter)  # 内容居中
        NameInput.setPlaceholderText(self.Lang.ClassName)  # 设置空内容提示
        NameInput.setStyleSheet(self.ClassStyleSheet.InputBox())  # 设置样式
        NameInput.setToolTip(self.Lang.ClassName)  # 设置鼠标提示
        VLayout.addWidget(NameInput)  # 添加控件

        DescriptionInput = QLineEdit()
        DescriptionInput.setFixedHeight(30)  # 尺寸
        DescriptionInput.setAlignment(Qt.AlignVCenter | Qt.AlignHCenter)  # 内容居中
        DescriptionInput.setPlaceholderText(self.Lang.Description)  # 设置空内容提示
        DescriptionInput.setStyleSheet(self.ClassStyleSheet.InputBox())  # 设置样式
        DescriptionInput.setToolTip(self.Lang.Description)  # 设置鼠标提示
        VLayout.addWidget(DescriptionInput)  # 添加控件

        AddButton = QPushButton(self.Lang.Confirm)  # 按钮
        AddButton.setStyleSheet(self.ClassStyleSheet.Button())  # 设置样式
        AddButton.setFixedHeight(30)  # 尺寸
        AddButton.clicked.connect(lambda: self.NewClassAction(NameInput.text(), DescriptionInput.text()))  # 连接槽函数
        VLayout.addWidget(AddButton)

        self.NewClassView.setLayout(VLayout)  # 添加布局
        self.NewClassView.show()

    # 新建
    def NewClassAction(self, Name: str, Description: str):
        if Name != '':
            Result = self.ClassController.NewClass(Name, Description)
            if Result['State'] != True:
                self.MSGBOX.ERROR(Result['Memo'])
            else:
                self.NewClassView.close()  # 关闭窗口
                self.TreeDataInit()  # 主控件写入数据
