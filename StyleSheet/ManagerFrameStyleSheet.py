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

    def HeadlineStyleSheet(self) -> str:
        return '''
        QLabel{
            font-family: ''' + self.FontFamily + ''';
            background-color: ''' + self.CommonColor + ''';
            font-size: 16px;
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
            font-size: 16px;
        }
        QTreeWidget::item {
            font-family: ''' + self.FontFamily + ''';
            background-color: white;
            border: 2px solid #b2b5ba;
            color: black;
            height: 30px;
            margin-top: 5px;
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