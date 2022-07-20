from StyleSheet.BaseStyleSheet import *


class ManagerFrameStyleSheet(BaseStyleSheet):

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
            background-color: #666666;
            font-size: 15px;
            color: white;
            border: 2px solid white;
            border-radius: 5px;
        }
        QPushButton:hover {
            color: white;
            background-color: #3399CC;
        }
        QPushButton:pressed {
            color: black;
            background-color: #3399CC;
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
