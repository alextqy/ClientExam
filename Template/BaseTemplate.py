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