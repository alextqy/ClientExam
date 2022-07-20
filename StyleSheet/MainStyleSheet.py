from StyleSheet.BaseStyleSheet import *


class MainStyleSheet(BaseStyleSheet):

    def __init__(self):
        super().__init__()

    def BaseStyleSheet(self) -> str:
        return '''
        QMainWindow{
            font-family: ''' + self.FontFamily + ''';
            background-color: ''' + self.BackgroundColor + ''';
        }
        '''

    def Button(self) -> str:
        return '''
        QPushButton {
            font-family: ''' + self.FontFamily + ''';
            color: black;
            border-radius: 5px;
            background-color: #56d365;
            border-width: 0px;
            font-size: 15px;
            outline: none;
            border: 2px solid white;
        }
        QPushButton:hover {
            color: black;
            background-color: #35c046;
        }
        QPushButton:pressed {
            color: white;
            background-color: #35c046;
            padding-left: 3px;
            padding-top: 3px;
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