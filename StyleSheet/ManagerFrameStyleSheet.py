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