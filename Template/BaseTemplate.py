# -*- coding:utf-8 -*-
from Public.Cache import *
from Public.Common import *
from Public.FileHelper import *
from Public.Lang import *
from Public.UDPTool import *

from Controller.ClassController import *
from Controller.ExamineeController import *
from Controller.ExamineeTokenController import *
from Controller.ExamInfoController import *
from Controller.ExamInfoHistoryController import *
from Controller.ExamLogController import *
from Controller.HeadlineController import *
from Controller.KnowledgeController import *
from Controller.ManagerController import *
from Controller.PaperController import *
from Controller.PaperRuleController import *
from Controller.PracticeController import *
from Controller.QuestionController import *
from Controller.QuestionSolutionController import *
from Controller.ScantronController import *
from Controller.ScantronHistoryController import *
from Controller.ScantronSolutionController import *
from Controller.ScantronSolutionHistoryController import *
from Controller.SubjectController import *
from Controller.SysConfController import *
from Controller.SysLogController import *
from Controller.TeacherClassController import *
from Controller.TeacherController import *

TITLE = 'BIT EXAM'
ICON = ''


class BaseTemplate():

    def __init__(self):
        super().__init__()

        self.Cache = Cache()
        self.Common = Common()
        self.FileHelper = FileHelper()
        self.Lang = Lang()
        self.UDPTool = UDPTool()
        self.MSGBOX = MSGBOX()

        # self.ClassController = ClassController()
        # self.ExamineeController = ExamineeController()
        # self.ExamineeTokenController = ExamineeTokenController()
        # self.ExamInfoController = ExamInfoController()
        # self.ExamInfoHistoryController = ExamInfoHistoryController()
        # self.ExamLogController = ExamLogController()
        # self.HeadlineController = HeadlineController()
        # self.KnowledgeController = KnowledgeController()
        # self.ManagerController = ManagerController()
        # self.PaperController = PaperController()
        # self.PaperRuleController = PaperRuleController()
        # self.PracticeController = PracticeController()
        # self.QuestionController = QuestionController()
        # self.QuestionSolutionController = QuestionSolutionController()
        # self.ScantronController = ScantronController()
        # self.ScantronHistoryController = ScantronHistoryController()
        # self.ScantronSolutionController = ScantronSolutionController()
        # self.ScantronSolutionHistoryController = ScantronSolutionHistoryController()
        # self.SubjectController = SubjectController()
        # self.SysConfController = SysConfController()
        # self.SysLogController = SysLogController()
        # self.TeacherClassController = TeacherClassController()
        # self.TeacherController = TeacherController()

        self.SW, self.SH = Tk().maxsize()  # 获取显示器宽高

        self.QIntValidator = QIntValidator()  # QLineEdit 输入限制为整数
        self.QDoubleValidator = QDoubleValidator()  # QLineEdit 输入限制为浮点数

    # 获取控件坐标
    def CheckWidgetPos(self, WidgetObject) -> list:
        PosList = []
        PosList.append(WidgetObject.geometry().x())
        PosList.append(WidgetObject.geometry().y())
        return PosList

    # 清理布局中的控件(顺序删除)
    def ClearLayout(self, Layout) -> None:
        if Layout is not None:
            while Layout.count():
                Item = Layout.takeAt(0)
                widget = Item.widget()
                if widget is not None:
                    widget.deleteLater()
                else:
                    Layout.removeItem(Item)
                    self.ClearLayout(Item.layout())

    # 倒序清空布局
    # def ClearLayout(self, Layout) -> None:
    #     ItemList = list(range(Layout.count()))
    #     ItemList.reverse()  # 倒序删除 避免影响布局顺序
    #     for i in ItemList:
    #         Item = Layout.itemAt(i)
    #         if Item.widget() is not None:
    #             Item.widget().deleteLater()
    #         Layout.removeItem(Item)

    # 退出线程
    def KillThread(self, ThreadObject):
        ThreadObject.quit()
        ThreadObject.wait()

    # 退出系统
    def SysExit(self) -> None:
        os._exit(0)


# 多线程基础对象
class BaseWorker(QObject):
    FinishSignal = Signal()

    def __init__(self):
        super().__init__()


# 基础树形控件
class BaseTreeWidget(QTreeWidget):

    def __init__(self):
        super().__init__()
        self.setRootIsDecorated(False)  # 隐藏左侧展开标志

        # 标题栏宽度均分
        # self.header().setSectionResizeMode(QHeaderView.Stretch)

        # 开启槽函数
        # 必须将ContextMenuPolicy设置为Qt.CustomContextMenu
        # 否则无法使用customContextMenuRequested信号
        self.setContextMenuPolicy(Qt.CustomContextMenu)

    def SetSelectionMode(self, No=0):  # 设置多选模式
        if No == 1:  # 多选(不需按ctrl)
            self.setSelectionMode(QAbstractItemView.MultiSelection)
        elif No == 2:  # 按住ctrl一次选一项或者按住shift可多选
            self.setSelectionMode(QAbstractItemView.ExtendedSelection)
        elif No == 3:  # 一次选择多项
            self.setSelectionMode(QAbstractItemView.ContiguousSelection)
        elif No == 4:  # 无法选择
            self.setSelectionMode(QAbstractItemView.NoSelection)
        else:  # 单选
            self.setSelectionMode(QAbstractItemView.SingleSelection)

    def Connect(self, Func):  # 链接槽函数
        self.customContextMenuRequested.connect(Func)

    def RemoveTopItem(self, Item):  # 删除根节点
        self.takeTopLevelItem(self.indexOfTopLevelItem(Item))

    def RemoveSubItem(self, Item):  # 删除子节点
        ParentNode = Item.parent()  # 获取父级item
        ParentNode.removeChild(Item)  # 删除下级

    def RemoveItems(self, Item):  # 删除节点
        if type(Item.parent()) == QTreeWidgetItem:  # 如果为子节点
            self.RemoveSubItem(Item)
        else:
            self.RemoveTopItem(Item)

    def SelectItems(self):  # 获取所有item
        ItemsObj = QTreeWidgetItemIterator(self)
        List = []
        i = 0
        while ItemsObj.value():  # 遍历出item对象
            List.append(i)
            List[i] = ItemsObj.value()
            ItemsObj.__iadd__(1)
            i = i + 1
        return List

    def HideHScroll(self):  # 隐藏横向滚动条
        self.setHorizontalScrollBarPolicy(Qt.ScrollBarAlwaysOff)

    def HideVScroll(self):  # 隐藏纵向滚动条
        self.setVerticalScrollBarPolicy(Qt.ScrollBarAlwaysOff)


# 基础菜单控件
class BaseMenu(QMenu):

    def __init__(self):
        super().__init__()

    def AddAction(self, Title: str, Func: any):
        self.addAction(Title).triggered.connect(Func)


# 自定义问询窗口
class MSGBOX(QMessageBox):

    def __init__(self):
        super().__init__()
        self.Cache = Cache()  # 设置缓存
        self.Title = ''
        if self.Cache.Get('Title') != '':
            self.Title = self.Cache.Get('Title')  # 设置标题
        self.setWindowIcon(QIcon(ICON))  # 设置ICON
        self.setMinimumWidth(230)

    def ERROR(self, Content: str):
        self.setStyleSheet('''
        QDialog {
            font-family: Microsoft Yahei;
            background-color: #e2e4db;
        }
        QPushButton {
            font-family: Microsoft Yahei;
            color: white;
            border-radius: 5px;
            background-color: #ef5f5d;
            height: 25px;
            width: 50px;
        }
        QPushButton:hover {
            color: black;
            background-color: #ef5f5d;
        }
        QPushButton:pressed {
            color: black;
            background-color: #ef5f5d;
            padding-left: 3px;
            padding-top: 3px;
        }
        ''')
        return self.critical(self, self.Title, Content)

    def WARNING(self, Content: str):
        self.setStyleSheet('''
        QDialog {
            font-family: Microsoft Yahei;
            background-color: #e2e4db;
        }
        QPushButton {
            font-family: Microsoft Yahei;
            color: white;
            border-radius: 5px;
            background-color: #f6ca0d;
            height: 25px;
            width: 50px;
        }
        QPushButton:hover {
            color: black;
            background-color: #f6ca0d;
        }
        QPushButton:pressed {
            color: black;
            background-color: #f6ca0d;
            padding-left: 3px;
            padding-top: 3px;
        }
        ''')
        return self.warning(self, self.Title, Content)

    def COMPLETE(self, Content: str):
        self.setStyleSheet('''
        QDialog {
            font-family: Microsoft Yahei;
            background-color: #e2e4db;
        }
        QPushButton {
            font-family: Microsoft Yahei;
            color: white;
            border-radius: 5px;
            background-color: #9eca75;
            height: 25px;
            width: 50px;
        }
        QPushButton:hover {
            color: black;
            background-color: #9eca75;
        }
        QPushButton:pressed {
            color: black;
            background-color: #9eca75;
            padding-left: 3px;
            padding-top: 3px;
        }
        ''')
        return self.about(self, self.Title, Content)

    def CUE(self, Content: str):
        self.setStyleSheet('''
        QDialog {
            font-family: Microsoft Yahei;
            background-color: #e2e4db;
        }
        QPushButton {
            font-family: Microsoft Yahei;
            color: white;
            border-radius: 5px;
            background-color: #3f83ab;
            height: 25px;
            width: 50px;
        }
        QPushButton:hover {
            color: black;
            background-color: #2787cc;
        }
        QPushButton:pressed {
            color: black;
            background-color: #faffbd;
            padding-left: 3px;
            padding-top: 3px;
        }
        ''')
        return self.information(self, self.Title, Content)

    def ASK(self, Content: str):
        self.setStyleSheet('''
        QDialog {
            font-family: Microsoft Yahei;
            background-color: #e2e4db;
        }
        QPushButton {
            font-family: Microsoft Yahei;
            color: white;
            border-radius: 5px;
            background-color: #3f83ab;
            height: 25px;
            width: 50px;
        }
        QPushButton:hover {
            color: black;
            background-color: #2787cc;
        }
        QPushButton:pressed {
            color: black;
            background-color: #faffbd;
            padding-left: 3px;
            padding-top: 3px;
        }
        ''')
        return self.question(self, self.Title, Content)


# 带搜索功能的下拉框
class ExtendedComboBox(QComboBox):

    def __init__(self, Parent=None):
        super(ExtendedComboBox, self).__init__(Parent)
        self.setFocusPolicy(Qt.StrongFocus)
        self.setEditable(True)

        # 添加筛选器模型来筛选匹配项
        self.pFilterModel = QSortFilterProxyModel(self)
        self.pFilterModel.setFilterCaseSensitivity(Qt.CaseInsensitive)  # 大小写不敏感
        self.pFilterModel.setSourceModel(self.model())

        # 添加一个使用筛选器模型的QCompleter
        self.completer = QCompleter(self.pFilterModel, self)
        self.completer.setCompletionMode(QCompleter.UnfilteredPopupCompletion)  # 始终显示所有过滤后的补全结果
        self.completer.setCaseSensitivity(Qt.CaseInsensitive)  # 不区分大小写
        self.setCompleter(self.completer)

        # Qcombobox编辑栏文本变化时对应的槽函数
        self.lineEdit().textEdited.connect(self.pFilterModel.setFilterFixedString)
        self.completer.activated.connect(self.OnCompleterActivated)

    # 当在Qcompleter列表选中候选下拉框项目时 列表选择相应的子项目
    def OnCompleterActivated(self, text):
        if text:
            index = self.findText(text)
            self.setCurrentIndex(index)
            # self.activated[str].emit(self.itemText(index))
            # self.activated.emit(print(self.itemText(index)))

    # 在模型更改时 更新过滤器和补全器的模型
    def setModel(self, model):
        super(ExtendedComboBox, self).setModel(model)
        self.pFilterModel.setSourceModel(model)
        self.completer.setModel(self.pFilterModel)

    # 在模型列表更改时 更新过滤器和补全器的模型列表
    def setModelColumn(self, column):
        self.completer.setCompletionColumn(column)
        self.pFilterModel.setFilterKeyColumn(column)
        super(ExtendedComboBox, self).setModelColumn(column)

    # 回应回车按钮事件
    def keyPressEvent(self, e):
        if e.key() == Qt.Key_Enter & e.key() == Qt.Key_Return:
            text = self.currentText()
            index = self.findText(text, Qt.MatchExactly | Qt.MatchCaseSensitive)
            self.setCurrentIndex(index)
            self.hidePopup()
            super(ExtendedComboBox, self).keyPressEvent(e)
        else:
            super(ExtendedComboBox, self).keyPressEvent(e)