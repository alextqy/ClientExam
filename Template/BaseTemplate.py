# -*- coding:utf-8 -*-
from Public.Cache import *
from Public.Common import *
from Public.FileHelper import *
from Public.Lang import *
from Public.UDPTool import *

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

    # 退出系统
    def SysExit(self) -> None:
        os._exit(0)


# 多线程基础对象
class BaseWorker(QObject):
    FinishSignal = Signal()

    def __init__(self):
        super().__init__()