from StyleSheet.BaseStyleSheet import *


class ManagerMainStyleSheet(BaseStyleSheet):

    def __init__(self):
        super().__init__()

    def BaseStyleSheet(self) -> str:
        return '''
        QDialog{
            font-family: ''' + self.FontFamily + ''';
            background-color: ''' + self.CommonColor + ''';
        }
        '''

    def MenuFrame(self) -> str:
        return '''
        QFrame{
            font-family: ''' + self.FontFamily + ''';
            background-color: ''' + self.CommonColor + ''';
            border: 2px solid white;
            padding-top: 10px;
        }
        '''

    def DataFrame(self) -> str:
        return '''
        QFrame{
            font-family: ''' + self.FontFamily + ''';
            background-color: ''' + self.CommonColor + ''';
            border: 0px;
        }
        '''

    def Frame(self) -> str:
        return '''
        QFrame{
            font-family: ''' + self.FontFamily + ''';
            background-color: ''' + self.CommonColor + ''';
            border: 2px solid white;
        }
        '''

    def Label(self) -> str:
        return '''
        QLabel{
            font-family: ''' + self.FontFamily + ''';
            background-color: ''' + self.CommonColor + ''';
            border: 2px solid white;
            font-size: 15px;
            color: white;
        }
        '''

    def InitLabel(self) -> str:
        return '''
        QLabel{
            font-family: ''' + self.FontFamily + ''';
            background-color: ''' + self.BackgroundColor + ''';
            border: 0px;
        }
        '''

    def MenuButton1(self) -> str:
        return '''
        QPushButton{
            font-family: ''' + self.FontFamily + ''';
            background-color: #339933;
            font-size: 15px;
            color: white;
            border: 2px solid white;
            border-radius: 5px;
        }
        QPushButton:hover {
            color: white;
            background-color: #99CC00;
        }
        QPushButton:pressed {
            color: black;
            background-color: #99CC00;
            padding-left: 3px;
            padding-top: 3px;
        }
        '''

    def MenuButton2(self) -> str:
        return '''
        QPushButton{
            font-family: ''' + self.FontFamily + ''';
            background-color: #9933CC;
            font-size: 15px;
            color: white;
            border: 2px solid white;
            border-radius: 5px;
        }
        QPushButton:hover {
            color: white;
            background-color: #CC3399;
        }
        QPushButton:pressed {
            color: black;
            background-color: #CC3399;
            padding-left: 3px;
            padding-top: 3px;
        }
        '''

    def MenuButton3(self) -> str:
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