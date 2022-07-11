# -*- coding:utf-8 -*-
from Public.Common import *
from Template.MainTemplate import *

if __name__ == '__main__':
    App = QApplication(argv)
    MainObject = MainTemplate()
    MainObject.show()
    exit(App.exec())
