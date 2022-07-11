from StyleSheet.BaseStyleSheet import *


class ManagerMainStyleSheet(BaseStyleSheet):

    def __init__(self):
        super().__init__()

    def BaseStyleSheet(self) -> str:
        return '''
        QMainWindow{
            font-family: ''' + self.FontFamily + ''';
            background-color: ''' + self.BackgroundColor + ''';
        }
        '''