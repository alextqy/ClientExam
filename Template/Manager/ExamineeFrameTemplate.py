# -*- coding:utf-8 -*-
from Template.BaseTemplate import *
from StyleSheet.Manager.ExamineeStyleSheet import *


# 考生管理界面
class ExamineeFrameTemplate(BaseTemplate, QFrame):

    def __init__(self):
        super().__init__()
        self.ExamineeStyleSheet = ExamineeStyleSheet()
        self.ExamineeController = ExamineeController()
        self.ClassController = ClassController()
        self.Classes: list = []
        self.setStyleSheet(self.ExamineeStyleSheet.BaseStyleSheet())  # 设置样式

        self.CenterLayout = QVBoxLayout()  # 设置主布局

        # 标题栏
        self.Headline = QLabel(self.Lang.Examinee)
        self.Headline.setAlignment(Qt.AlignVCenter | Qt.AlignHCenter)  # 字体居中
        self.Headline.adjustSize()  # 根据内容自适应宽度
        self.Headline.setFixedHeight(30)  # 尺寸
        self.Headline.setStyleSheet(self.ExamineeStyleSheet.Headline())  # 设置样式
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
        self.CurrentPage.setStyleSheet(self.ExamineeStyleSheet.CurrentPage())  # 设置样式
        self.PageButtonLayout.addWidget(self.CurrentPage)  # 添加控件

        # 总页码数
        self.TotalPage = QLabel(self.Lang.TotalPages + ' ' + str(self.TotalPageNo))
        self.TotalPage.setAlignment(Qt.AlignVCenter | Qt.AlignHCenter)  # 字体居中
        self.TotalPage.adjustSize()  # 根据内容自适应宽度
        self.TotalPage.setFixedSize(120, 30)  # 尺寸
        self.TotalPage.setStyleSheet(self.ExamineeStyleSheet.CurrentPage())  # 设置样式
        self.PageButtonLayout.addWidget(self.TotalPage)  # 添加控件

        # 输入页码
        self.PageInput = QLineEdit()
        self.PageInput.setValidator(self.QIntValidator)  # 输入为整数类型
        self.PageInput.setFixedSize(170, 30)  # 尺寸
        self.PageInput.setAlignment(Qt.AlignVCenter | Qt.AlignHCenter)  # 内容居中
        self.PageInput.setPlaceholderText(self.Lang.EnterPageNumber)  # 设置空内容提示
        self.PageInput.setStyleSheet(self.ExamineeStyleSheet.InputBox())  # 设置样式
        self.PageInput.setToolTip(self.Lang.EnterPageNumber)  # 设置鼠标提示
        self.PageButtonLayout.addWidget(self.PageInput)  # 添加控件

        # 每一页展示行数
        self.RowsInput = QLineEdit()
        self.RowsInput.setValidator(self.QIntValidator)  # 输入为整数类型
        self.RowsInput.setFixedSize(170, 30)  # 尺寸
        self.RowsInput.setAlignment(Qt.AlignVCenter | Qt.AlignHCenter)  # 内容居中
        self.RowsInput.setPlaceholderText(self.Lang.EnterTheNumberOfLines)  # 设置空内容提示
        self.RowsInput.setStyleSheet(self.ExamineeStyleSheet.InputBox())  # 设置样式
        self.RowsInput.setToolTip(self.Lang.EnterTheNumberOfLines)  # 设置鼠标提示
        self.PageButtonLayout.addWidget(self.RowsInput)  # 添加控件

        # 搜索
        self.SearchInput = QLineEdit()
        self.SearchInput.setFixedSize(170, 30)  # 尺寸
        self.SearchInput.setAlignment(Qt.AlignVCenter | Qt.AlignHCenter)  # 内容居中
        self.SearchInput.setPlaceholderText(self.Lang.Search)  # 设置空内容提示
        self.SearchInput.setStyleSheet(self.ExamineeStyleSheet.InputBox())  # 设置样式
        self.SearchInput.setToolTip(self.Lang.Search)  # 设置鼠标提示
        self.PageButtonLayout.addWidget(self.SearchInput)  # 添加控件

        # 班级
        self.ClassSelect = QComboBox()  # 设置下拉框
        self.ClassSelect.adjustSize()  # 按内容自适应宽度
        self.ClassSelect.setView(QListView())  # 设置内容控件
        self.ClassSelect.setFixedHeight(30)  # 尺寸
        self.ClassSelect.setMinimumWidth(110)  # 尺寸
        self.ClassSelect.setStyleSheet(self.ExamineeStyleSheet.SelectBox())  # 设置样式
        self.ClassSelect.insertItem(0, ' ' + self.Lang.Class)  # 设置下拉内容
        self.ClassSelect.setItemData(0, self.Lang.Class, Qt.ToolTipRole)  # 设置下拉内容提示
        CheckClasses = self.ClassController.Classes()
        if len(CheckClasses['Data']) > 0:
            self.Classes = CheckClasses['Data']
            j = 1
            for i in range(len(self.Classes)):
                Data = self.Classes[i]
                self.ClassSelect.insertItem(j, Data['ClassName'])  # 设置下拉内容
                self.ClassSelect.setItemData(j, Data['ClassName'], Qt.ToolTipRole)  # 设置下拉内容提示
                self.ClassSelect.setItemData(j, Data['ID'])
                j += 1
        self.ClassSelect.setCurrentIndex(0)  # 设置默认选项
        self.PageButtonLayout.addWidget(self.ClassSelect)  # 添加控件

        # 确认按钮
        self.ConfirmButton = QPushButton(self.Lang.Confirm)
        self.ConfirmButton.setStyleSheet(self.ExamineeStyleSheet.Button())  # 设置样式
        self.ConfirmButton.setFixedHeight(30)  # 尺寸
        self.ConfirmButton.clicked.connect(lambda: self.TreeDataInit())  # 连接槽函数
        self.PageButtonLayout.addWidget(self.ConfirmButton)  # 添加控件

        # =====================================================================================================================================================================

        # 页码按钮布局
        self.PNButtonLayout = QHBoxLayout()  # 设置按钮布局

        # 上一页
        self.PreviousPageButton = QPushButton(self.Lang.PreviousPage)
        self.PreviousPageButton.setStyleSheet(self.ExamineeStyleSheet.Button())  # 设置样式
        self.PreviousPageButton.setFixedHeight(30)  # 尺寸
        self.PreviousPageButton.clicked.connect(lambda: self.SetPreviousPage())  # 连接槽函数
        self.PNButtonLayout.addWidget(self.PreviousPageButton)  # 添加控件

        # 下一页
        self.NextPageButton = QPushButton(self.Lang.NextPage)
        self.NextPageButton.setStyleSheet(self.ExamineeStyleSheet.Button())  # 设置样式
        self.NextPageButton.setFixedHeight(30)  # 尺寸
        self.NextPageButton.clicked.connect(lambda: self.SetNextPage())  # 连接槽函数
        self.PNButtonLayout.addWidget(self.NextPageButton)  # 添加控件

        # =====================================================================================================================================================================

        self.ButtonLayout = QHBoxLayout()  # 设置按钮布局

        # 新建
        self.NewExamineeButton = QPushButton(self.Lang.NewExaminee)
        self.NewExamineeButton.setStyleSheet(self.ExamineeStyleSheet.Button())  # 设置样式
        self.NewExamineeButton.setFixedHeight(30)  # 尺寸
        self.NewExamineeButton.clicked.connect(lambda: self.NewExamineeWindow())  # 连接槽函数
        self.ButtonLayout.addWidget(self.NewExamineeButton)  # 添加控件

        # 刷新
        self.RefreshButton = QPushButton(self.Lang.Refresh)
        self.RefreshButton.setStyleSheet(self.ExamineeStyleSheet.Button())  # 设置样式
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
        ClassID = self.ClassSelect.currentIndex()
        Result = self.ExamineeController.ExamineeList(Page, PageSize, Stext, ClassID)
        self.TotalPageNo = Result['TotalPage']
        self.TotalPage.setText(self.Lang.TotalPages + ' ' + str(self.TotalPageNo))

        if Result['State'] != True:
            self.MSGBOX.ERROR(Result['Memo'])
        else:
            Data = Result['Data']

            # 树状列表
            self.ExamineeTree = BaseTreeWidget()
            self.ExamineeTree.SetSelectionMode(2)  # 设置选择模式
            self.ExamineeTree.setStyleSheet(self.ExamineeStyleSheet.TreeWidget())  # 设置样式
            self.ExamineeTree.setColumnCount(6)  # 设置列数
            self.ExamineeTree.hideColumn(3)  # 隐藏列
            self.ExamineeTree.hideColumn(4)  # 隐藏列
            self.ExamineeTree.hideColumn(5)  # 隐藏列
            self.ExamineeTree.setHeaderLabels(['ID', self.Lang.Name, self.Lang.CreationTime, self.Lang.Contact, 'ExamineeNo', 'ClassID'])  # 设置标题栏
            # self.ExamineeTree.header().setSectionResizeMode(0, QHeaderView.ResizeToContents)  # 列宽自适应数据长度
            self.ExamineeTree.Connect(self.RightContextMenuExec)  # 鼠标右键菜单 链接槽函数
            self.TreeLayout.addWidget(self.ExamineeTree)  # 添加控件

            if len(Data) > 0:
                TreeItems = []
                for i in range(len(Data)):
                    item = QTreeWidgetItem()  # 设置item控件
                    # item.setIcon(0, QtGui.QIcon(os.getcwd() + '/avatar.png'))
                    item.setText(0, str(Data[i]['ID']))  # 设置内容
                    item.setText(1, Data[i]['Name'])  # 设置内容
                    item.setText(2, self.Common.TimeToStr(Data[i]['CreateTime']))  # 设置内容
                    item.setText(3, Data[i]['Contact'])  # 设置内容
                    item.setText(4, Data[i]['ExamineeNo'])  # 设置内容
                    item.setText(5, str(Data[i]['ClassID']))  # 设置内容
                    item.setTextAlignment(0, Qt.AlignHCenter | Qt.AlignVCenter)  # 设置item字体居中
                    item.setTextAlignment(1, Qt.AlignHCenter | Qt.AlignVCenter)  # 设置item字体居中
                    item.setTextAlignment(2, Qt.AlignHCenter | Qt.AlignVCenter)  # 设置item字体居中
                    item.setTextAlignment(3, Qt.AlignHCenter | Qt.AlignVCenter)  # 设置item字体居中
                    item.setTextAlignment(4, Qt.AlignHCenter | Qt.AlignVCenter)  # 设置item字体居中
                    item.setTextAlignment(5, Qt.AlignHCenter | Qt.AlignVCenter)  # 设置item字体居中
                    TreeItems.append(item)  # 添加到item list
                self.ExamineeTree.insertTopLevelItems(0, TreeItems)  # 添加到列表

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
        self.TreeMenu.setStyleSheet(self.ExamineeStyleSheet.TreeMenu())  # 设置样式
        Item = self.ExamineeTree.currentItem()  # 获取被点击行控件
        ItemAt = self.ExamineeTree.itemAt(pos)  # 获取点击焦点

        # 展示判断
        if type(Item) == QTreeWidgetItem and type(ItemAt) == QTreeWidgetItem:  # 焦点内
            self.TreeMenu.AddAction(self.Lang.ExamineeDetails, lambda: self.InfoWindow(Item))
        else:  # 焦点外
            return

        self.TreeMenu.move(QCursor().pos())  # 移动到焦点
        self.TreeMenu.show()  # 展示

    # 节点数据详情
    def InfoWindow(self, Item):
        ID: int = int(Item.text(0))
        Name: str = Item.text(1)
        Contact: str = Item.text(3)
        ExamineeNo: str = Item.text(4)
        ClassID: int = int(Item.text(5))
        ClassName: str = ''

        Result = self.ClassController.ClassInfo(ClassID)
        if Result['State'] == True:
            ClassName = Result['Data']['ClassName']

        self.ExamineeDetailsView = QDialog()
        self.ExamineeDetailsView.setWindowTitle(TITLE)
        self.ExamineeDetailsView.setWindowModality(Qt.ApplicationModal)  # 禁止其他所有窗口交互
        self.ExamineeDetailsView.setStyleSheet(self.ExamineeStyleSheet.Dialog())  # 设置样式
        self.ExamineeDetailsView.setFixedSize(222, 196)  # 尺寸

        VLayout = QVBoxLayout()

        NameInput = QLineEdit()  # 输入
        NameInput.setText(Name)  # 设置内容
        NameInput.setFixedHeight(30)  # 尺寸
        NameInput.setAlignment(Qt.AlignVCenter | Qt.AlignHCenter)  # 内容居中
        NameInput.setPlaceholderText(self.Lang.Name)  # 设置空内容提示
        NameInput.setStyleSheet(self.ExamineeStyleSheet.InputBox())  # 设置样式
        NameInput.setToolTip(self.Lang.Name)  # 设置鼠标提示
        VLayout.addWidget(NameInput)  # 添加控件

        ContactInput = QLineEdit()  # 输入
        ContactInput.setText(Contact)  # 设置内容
        ContactInput.setFixedHeight(30)  # 尺寸
        ContactInput.setAlignment(Qt.AlignVCenter | Qt.AlignHCenter)  # 内容居中
        ContactInput.setPlaceholderText(self.Lang.Contact)  # 设置空内容提示
        ContactInput.setStyleSheet(self.ExamineeStyleSheet.InputBox())  # 设置样式
        ContactInput.setToolTip(self.Lang.Contact)  # 设置鼠标提示
        VLayout.addWidget(ContactInput)  # 添加控件

        ExamineeNoInput = QLineEdit()
        ExamineeNoInput.setText(ExamineeNo)
        ExamineeNoInput.setFixedHeight(30)  # 尺寸
        ExamineeNoInput.setAlignment(Qt.AlignVCenter | Qt.AlignHCenter)  # 内容居中
        ExamineeNoInput.setPlaceholderText(self.Lang.ExamineeNo)  # 设置空内容提示
        ExamineeNoInput.setStyleSheet(self.ExamineeStyleSheet.InputBox())  # 设置样式
        ExamineeNoInput.setToolTip(self.Lang.ExamineeNo)  # 设置鼠标提示
        ExamineeNoInput.setEnabled(False)  # 禁止输入
        VLayout.addWidget(ExamineeNoInput)  # 添加控件

        ClassInput = QLineEdit()
        ClassInput.setText(ClassName)
        ClassInput.setFixedHeight(30)  # 尺寸
        ClassInput.setAlignment(Qt.AlignVCenter | Qt.AlignHCenter)  # 内容居中
        ClassInput.setPlaceholderText(self.Lang.ClassName)  # 设置空内容提示
        ClassInput.setStyleSheet(self.ExamineeStyleSheet.InputBox())  # 设置样式
        ClassInput.setToolTip(self.Lang.ClassName)  # 设置鼠标提示
        ClassInput.setEnabled(False)  # 禁止输入
        VLayout.addWidget(ClassInput)  # 添加控件

        UpdateButton = QPushButton(self.Lang.Confirm)  # 按钮
        UpdateButton.setStyleSheet(self.ExamineeStyleSheet.Button())  # 设置样式
        UpdateButton.setFixedHeight(30)  # 尺寸
        UpdateButton.clicked.connect(lambda: self.InfoWindowAction(ID, NameInput.text(), ContactInput.text()))  # 连接槽函数
        self.ButtonLayout.addWidget(UpdateButton)  # 添加控件
        VLayout.addWidget(UpdateButton)

        self.ExamineeDetailsView.setLayout(VLayout)  # 添加布局
        self.ExamineeDetailsView.show()

    # 更新信息
    def InfoWindowAction(self, ID: int, Name: str, Contact: str):
        Result = self.ExamineeController.UpdateExaminee(ID, Name, Contact)
        if Result['State'] != True:
            self.MSGBOX.ERROR(Result['Memo'])
        else:
            self.ExamineeDetailsView.close()
            self.TreeDataInit()

    # 新建节点
    def NewExamineeWindow(self):
        self.NewExamineeView = QDialog()
        self.NewExamineeView.setWindowTitle(TITLE)
        self.NewExamineeView.setWindowModality(Qt.ApplicationModal)  # 禁止其他所有窗口交互
        self.NewExamineeView.setStyleSheet(self.ExamineeStyleSheet.Dialog())  # 设置样式
        self.NewExamineeView.setFixedSize(222, 196)  # 尺寸

        VLayout = QVBoxLayout()

        ExamineeNoInput = QLineEdit()  # 输入
        ExamineeNoInput.setFixedHeight(30)  # 尺寸
        ExamineeNoInput.setAlignment(Qt.AlignVCenter | Qt.AlignHCenter)  # 内容居中
        ExamineeNoInput.setPlaceholderText(self.Lang.ExamineeNo)  # 设置空内容提示
        ExamineeNoInput.setStyleSheet(self.ExamineeStyleSheet.InputBox())  # 设置样式
        ExamineeNoInput.setToolTip(self.Lang.ExamineeNo)  # 设置鼠标提示
        VLayout.addWidget(ExamineeNoInput)  # 添加控件

        NameInput = QLineEdit()  # 输入
        NameInput.setFixedHeight(30)  # 尺寸
        NameInput.setAlignment(Qt.AlignVCenter | Qt.AlignHCenter)  # 内容居中
        NameInput.setPlaceholderText(self.Lang.Name)  # 设置空内容提示
        NameInput.setStyleSheet(self.ExamineeStyleSheet.InputBox())  # 设置样式
        NameInput.setToolTip(self.Lang.Name)  # 设置鼠标提示
        VLayout.addWidget(NameInput)  # 添加控件

        ContactInput = QLineEdit()  # 输入
        ContactInput.setFixedHeight(30)  # 尺寸
        ContactInput.setAlignment(Qt.AlignVCenter | Qt.AlignHCenter)  # 内容居中
        ContactInput.setPlaceholderText(self.Lang.Contact)  # 设置空内容提示
        ContactInput.setStyleSheet(self.ExamineeStyleSheet.InputBox())  # 设置样式
        ContactInput.setToolTip(self.Lang.Contact)  # 设置鼠标提示
        VLayout.addWidget(ContactInput)  # 添加控件

        ClassInput = QComboBox()  # 设置下拉框
        ClassInput.adjustSize()  # 按内容自适应宽度
        ClassInput.setView(QListView())  # 设置内容控件
        ClassInput.setFixedHeight(30)  # 尺寸
        # ClassInput.setMinimumWidth(110)  # 尺寸
        ClassInput.setStyleSheet(self.ExamineeStyleSheet.SelectBox())  # 设置样式
        ClassInput.insertItem(0, ' ' + self.Lang.Class)  # 设置下拉内容
        ClassInput.setItemData(0, self.Lang.Class, Qt.ToolTipRole)  # 设置下拉内容提示
        CheckClasses = self.ClassController.Classes()
        if len(CheckClasses['Data']) > 0:
            self.Classes = CheckClasses['Data']
            j = 1
            for i in range(len(self.Classes)):
                Data = self.Classes[i]
                ClassInput.insertItem(j, Data['ClassName'])  # 设置下拉内容
                ClassInput.setItemData(j, Data['ClassName'], Qt.ToolTipRole)  # 设置下拉内容提示
                ClassInput.setItemData(j, Data['ID'])  # 设值
                j += 1
        ClassInput.setCurrentIndex(0)  # 设置默认选项
        VLayout.addWidget(ClassInput)  # 添加控件

        AddButton = QPushButton(self.Lang.Confirm)  # 按钮
        AddButton.setStyleSheet(self.ExamineeStyleSheet.Button())  # 设置样式
        AddButton.setFixedHeight(30)  # 尺寸
        AddButton.clicked.connect(lambda: self.NewExamineeAction(ExamineeNoInput.text(), NameInput.text(), ClassInput.currentData(), ContactInput.text()))  # 连接槽函数
        VLayout.addWidget(AddButton)

        self.NewExamineeView.setLayout(VLayout)  # 添加布局
        self.NewExamineeView.show()

    # 新建
    def NewExamineeAction(self, ExamineeNo: str, Name: str, ClassID: int, Contact: str):
        if ExamineeNo != '' and Name != '' and ClassID > 0 and Contact != '':
            Result = self.ExamineeController.NewExaminee(ExamineeNo, Name, ClassID, Contact)
            if Result['State'] != True:
                self.MSGBOX.ERROR(Result['Memo'])
            else:
                self.NewExamineeView.close()  # 关闭窗口
                self.TreeDataInit()  # 主控件写入数据