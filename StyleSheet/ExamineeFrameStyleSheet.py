# -*- coding:utf-8 -*-
from StyleSheet.BaseStyleSheet import *


class ExamineeFrameStyleSheet(BaseStyleSheet):

    def __init__(self):
        super().__init__()

    def BaseStyleSheet(self) -> str:
        return '''
        QFrame{
            font-family: ''' + self.FontFamily + ''';
            background-color: ''' + self.CommonColor + ''';
            border: 0px;
        }
        '''

    def Headline(self) -> str:
        return '''
        QLabel{
            font-family: ''' + self.FontFamily + ''';
            background-color: ''' + self.CommonColor + ''';
            font-size: 15px;
            color: black;
            border: 2px solid white;
        }
        '''

    def TreeWidget(self) -> str:
        return '''
        QTreeWidget {
            font-family: ''' + self.FontFamily + ''';
            background-color: ''' + self.CommonColor + ''';
            border: 0px;
            color: black;
            font-size: 15px;
        }
        QTreeWidget::item {
            font-family: ''' + self.FontFamily + ''';
            background-color: white;
            border: 2px solid #b2b5ba;
            color: black;
            height: 30px;
            margin-top: 3px;
        }
        QTreeWidget::item:hover {
            font-family: ''' + self.FontFamily + ''';
            background-color: #e2e4db;
            border: 2px solid #b2b5ba;
            color: black;
        }
        QTreeWidget::item:selected {
            font-family: ''' + self.FontFamily + ''';
            background-color: #b2b5ba;
            border: 2px solid #e2e4db;
            color: white;
        }
        '''

    def Button(self) -> str:
        return '''
        QPushButton{
            font-family: ''' + self.FontFamily + ''';
            background-color: ''' + self.CommonColor + ''';
            font-size: 15px;
            color: black;
            border: 2px solid white;
            border-radius: 5px;
            outline: none;
        }
        QPushButton:hover {
            color: white;
            background-color: #b2b5ba;
        }
        QPushButton:pressed {
            color: black;
            background-color: #b2b5ba;
            padding-left: 3px;
            padding-top: 3px;
        }
        '''

    def CurrentPage(self) -> str:
        return '''
        QLabel{
            font-family: ''' + self.FontFamily + ''';
            background-color: ''' + self.CommonColor + ''';
            font-size: 15px;
            color: black;
            border: 2px solid white;
        }
        '''

    def InputBox(self) -> str:
        return '''
        QLineEdit{
            font-family: ''' + self.FontFamily + ''';
            color: black;
            border-radius: 5px;
            background-color: ''' + self.CommonColor + ''';
            font-size: 15px;
            border: 2px solid white;
        }
        '''

    def SelectBox(self) -> str:
        return '''
        QComboBox{
            font-family: ''' + self.FontFamily + ''';
            color: black;
            border-radius: 5px;
            background-color: ''' + self.CommonColor + ''';
            font-size: 15px;
            border: 2px solid white;
            outline: none;
        }
        /* 去掉下拉右侧的箭头 */
        QComboBox::drop-down {
            border: 0px;
        }
        QListView::item:selected{
            color: white;
            background: ''' + self.BackgroundColor + ''';
            font-size: 15px;
            outline: none;
            border: 2px solid white;
        }
        QComboBox QAbstractItemView {
            color: black;
            background: ''' + self.CommonColor + ''';
            font-size: 15px;
            outline: none;
            border: 2px solid white;
        }
        '''

    def TreeMenu(self) -> str:
        return '''
        QMenu {
            font-family: ''' + self.FontFamily + ''';
            background-color: #e2e4db;
            padding: 0px;
            border: 2px solid white;
        }

        QMenu::item {
            color: black;
            background-color: ''' + self.CommonColor + ''';
            /*设置菜单项文字上下和左右的内边距，效果就是菜单中的条目左右上下有了间隔*/
            padding: 5px 15px;
            /*设置菜单项的外边距*/
            /* margin: 1px 0px; */
            /* width: 100px; */
            border-width: 0px;
        }

        QMenu::item:selected {
            background-color: #b2b5ba;
            color: white;
            border-width: 0px;
        }

        QMenu::item:pressed {
            background-color: #b2b5ba;
            color: black;
            border-width: 0px;
        }
        '''

    def Dialog(self) -> str:
        return '''
        QDialog{
            font-family: ''' + self.FontFamily + ''';
            background-color: ''' + self.CommonColor + ''';
        }
        '''