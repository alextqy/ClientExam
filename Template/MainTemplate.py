# -*- coding:utf-8 -*-
from Template.BaseTemplate import *
from StyleSheet.MainViewStyleSheet import *


class MainView(BaseTemplate, QMainWindow):

    def __init__(self, Title=TITLE):
        super().__init__()
        self.MainViewStyleSheet = MainViewStyleSheet()
        self.setStyleSheet(self.MainViewStyleSheet.BaseStyleSheet())

        self.setWindowTitle(Title)  # 窗口标题
        self.setWindowIcon(QIcon(ICON))  # 设置ICON
        # self.setWindowFlags(Qt.FramelessWindowHint)  # 隐藏窗口标题栏
        # self.setWindowFlags(Qt.WindowMinMaxButtonsHint)  # 仅显示最小化和最大化按钮
        # self.setWindowFlags(Qt.WindowCloseButtonHint)  # 仅显示关闭按钮
        self.setWindowFlags(Qt.WindowStaysOnTopHint)  # 窗口置顶
        self.setFixedSize(500, 300)  # 设置窗口最最小值
        SelfSize = self.geometry()  # 获取本窗口大小
        self.move(int((self.SW - SelfSize.width()) / 2), int((self.SH - SelfSize.height()) / 2))  # 居中显示

        self.CenterWidget = QWidget()  # 设置窗口的中央部件
        self.CenterWidget.setContentsMargins(0, 0, 0, 0)  # 设置边距
        self.CenterLayout = QVBoxLayout()  # 设置主佈局
        self.CenterLayout.setAlignment(Qt.AlignHCenter | Qt.AlignVCenter)  # 居中
        self.CenterLayout.setContentsMargins(0, 0, 0, 0)  # 设置边距

        self.LoginButtonView()

        self.CenterWidget.setLayout(self.CenterLayout)
        self.setCentralWidget(self.CenterWidget)  # 添加中央控件

    # 登录按钮
    def LoginButtonView(self):
        self.ClearLayout(self.CenterLayout)
        self.CenterLayout.setSpacing(15)  # 设置行间距
        ButtonWidth: int = 300
        ButtonHeight: int = 50

        # 考生登录按钮
        self.ExamineeLoginButton = QPushButton(self.Lang.ExamineeLogin)
        self.ExamineeLoginButton.setAutoFillBackground(True)  # 允许修改背景颜色
        self.ExamineeLoginButton.adjustSize()  # 按内容自适应宽度
        self.ExamineeLoginButton.setFixedSize(ButtonWidth, ButtonHeight)  # 尺寸
        self.ExamineeLoginButton.setStyleSheet(self.MainViewStyleSheet.Button())  # 设置样式
        self.ExamineeLoginButton.clicked.connect(lambda: self.ExamineeLoginButtonView())  # 连接槽函数
        # self.ExamineeLoginButton.setIcon(QIcon(UPLOAD))
        self.CenterLayout.addWidget(self.ExamineeLoginButton)  # 加入到布局

        # 教师登录按钮
        self.TeacherLoginButton = QPushButton(self.Lang.TeacherLogin)  # 教师登录
        self.TeacherLoginButton.setAutoFillBackground(True)  # 允许修改背景颜色
        self.TeacherLoginButton.adjustSize()  # 按内容自适应宽度
        self.TeacherLoginButton.setFixedSize(ButtonWidth, ButtonHeight)  # 尺寸
        self.TeacherLoginButton.setStyleSheet(self.MainViewStyleSheet.Button())  # 设置样式
        # self.TeacherLoginButton.clicked.connect(lambda: self.UploadListWindowObject.show())  # 连接槽函数
        # self.TeacherLoginButton.setIcon(QIcon(UPLOAD))
        self.CenterLayout.addWidget(self.TeacherLoginButton)  # 加入到布局

        # 管理员登录按钮
        self.ManagerLoginButton = QPushButton(self.Lang.ManagerLogin)  # 管理员登录
        self.ManagerLoginButton.setAutoFillBackground(True)  # 允许修改背景颜色
        self.ManagerLoginButton.adjustSize()  # 按内容自适应宽度
        self.ManagerLoginButton.setFixedSize(ButtonWidth, ButtonHeight)  # 尺寸
        self.ManagerLoginButton.setStyleSheet(self.MainViewStyleSheet.Button())  # 设置样式
        # self.ManagerLoginButton.clicked.connect(lambda: self.UploadListWindowObject.show())  # 连接槽函数
        # self.ManagerLoginButton.setIcon(QIcon(UPLOAD))
        self.CenterLayout.addWidget(self.ManagerLoginButton)  # 加入到布局

    # 考生单独登录界面按钮
    def ExamineeLoginButtonView(self):
        self.ClearLayout(self.CenterLayout)
        self.CenterLayout.setSpacing(15)  # 设置行间距
        ButtonWidth: int = 300
        ButtonHeight: int = 50

        # 考试按钮
        self.ExamButton = QPushButton(self.Lang.Exam)
        self.ExamButton.setAutoFillBackground(True)  # 允许修改背景颜色
        self.ExamButton.adjustSize()  # 按内容自适应宽度
        self.ExamButton.setFixedSize(ButtonWidth, ButtonHeight)  # 尺寸
        self.ExamButton.setStyleSheet(self.MainViewStyleSheet.Button())  # 设置样式
        self.ExamButton.clicked.connect(lambda: self.ExamLoginButtonView())  # 连接槽函数
        # self.ExamButton.setIcon(QIcon(UPLOAD))
        self.CenterLayout.addWidget(self.ExamButton)  # 加入到布局

        # 刷题按钮
        self.PracticeButton = QPushButton(self.Lang.PracticeQuestions)
        self.PracticeButton.setAutoFillBackground(True)  # 允许修改背景颜色
        self.PracticeButton.adjustSize()  # 按内容自适应宽度
        self.PracticeButton.setFixedSize(ButtonWidth, ButtonHeight)  # 尺寸
        self.PracticeButton.setStyleSheet(self.MainViewStyleSheet.Button())  # 设置样式
        self.PracticeButton.clicked.connect(lambda: self.PracticeLoginView())  # 连接槽函数
        # self.PracticeButton.setIcon(QIcon(UPLOAD))
        self.CenterLayout.addWidget(self.PracticeButton)  # 加入到布局

        # 返回按钮
        # self.CenterLayout.addStretch()  # 占位
        self.BackButton = QPushButton(self.Lang.Back)
        self.BackButton.setAutoFillBackground(True)  # 允许修改背景颜色
        self.BackButton.adjustSize()  # 按内容自适应宽度
        self.BackButton.setFixedSize(ButtonWidth, ButtonHeight)  # 尺寸
        self.BackButton.setStyleSheet(self.MainViewStyleSheet.Button())  # 设置样式
        self.BackButton.clicked.connect(lambda: self.LoginButtonView())  # 连接槽函数
        # self.BackButton.setIcon(QIcon(UPLOAD))
        self.CenterLayout.addWidget(self.BackButton)

    # 考试 =====================================================================================================================================================================

    # 考试登录界面
    def ExamLoginButtonView(self):
        self.ClearLayout(self.CenterLayout)
        self.CenterLayout.setSpacing(15)  # 设置行间距
        ButtonWidth: int = 300
        ButtonHeight: int = 50

        # 学生证号登录按钮
        self.LoginStudentIDButton = QPushButton(self.Lang.LoginStudentID)
        self.LoginStudentIDButton.setAutoFillBackground(True)  # 允许修改背景颜色
        self.LoginStudentIDButton.adjustSize()  # 按内容自适应宽度
        self.LoginStudentIDButton.setFixedSize(ButtonWidth, ButtonHeight)  # 尺寸
        self.LoginStudentIDButton.setStyleSheet(self.MainViewStyleSheet.Button())  # 设置样式
        self.LoginStudentIDButton.clicked.connect(lambda: self.LoginStudentIDView())  # 连接槽函数
        # self.LoginStudentIDButton.setIcon(QIcon(UPLOAD))
        self.CenterLayout.addWidget(self.LoginStudentIDButton)  # 加入到布局

        # 准考证号登录按钮
        self.LoginWithAdmissionButton = QPushButton(self.Lang.LoginWithAdmission)
        self.LoginWithAdmissionButton.setAutoFillBackground(True)  # 允许修改背景颜色
        self.LoginWithAdmissionButton.adjustSize()  # 按内容自适应宽度
        self.LoginWithAdmissionButton.setFixedSize(ButtonWidth, ButtonHeight)  # 尺寸
        self.LoginWithAdmissionButton.setStyleSheet(self.MainViewStyleSheet.Button())  # 设置样式
        self.LoginWithAdmissionButton.clicked.connect(lambda: self.LoginWithAdmissionView())  # 连接槽函数
        # self.LoginWithAdmissionButton.setIcon(QIcon(UPLOAD))
        self.CenterLayout.addWidget(self.LoginWithAdmissionButton)  # 加入到布局

        # 返回按钮
        # self.CenterLayout.addStretch()  # 占位
        self.BackButton = QPushButton(self.Lang.Back)
        self.BackButton.setAutoFillBackground(True)  # 允许修改背景颜色
        self.BackButton.adjustSize()  # 按内容自适应宽度
        self.BackButton.setFixedSize(ButtonWidth, ButtonHeight)  # 尺寸
        self.BackButton.setStyleSheet(self.MainViewStyleSheet.Button())  # 设置样式
        self.BackButton.clicked.connect(lambda: self.ExamineeLoginButtonView())  # 连接槽函数
        # self.BackButton.setIcon(QIcon(UPLOAD))
        self.CenterLayout.addWidget(self.BackButton)

    # 学生证号登录界面
    def LoginStudentIDView(self):
        self.ClearLayout(self.CenterLayout)
        self.CenterLayout.setSpacing(10)  # 设置行间距
        ButtonWidth: int = 300
        ButtonHeight: int = 35

        self.AccountInput = QLineEdit()  # 账号输入
        self.AccountInput.setFixedSize(ButtonWidth, 50)  # 尺寸
        # self.AccountInput.setEnabled(False)  # 不允许编辑
        self.AccountInput.setAlignment(Qt.AlignCenter | Qt.AlignBottom | Qt.AlignHCenter)  # 内容居中
        self.AccountInput.setPlaceholderText(self.Lang.StudentIDNumber)  # 设置空内容提示
        self.AccountInput.setStyleSheet(self.MainViewStyleSheet.InputBox())  # 设置样式
        self.AccountInput.setToolTip(self.Lang.StudentIDNumber)  # 设置鼠标提示
        self.CenterLayout.addWidget(self.AccountInput)

        # 登录按钮
        self.LoginButton = QPushButton(self.Lang.Login)
        self.LoginButton.setAutoFillBackground(True)  # 允许修改背景颜色
        self.LoginButton.adjustSize()  # 按内容自适应宽度
        self.LoginButton.setFixedSize(ButtonWidth, ButtonHeight)  # 尺寸
        self.LoginButton.setStyleSheet(self.MainViewStyleSheet.Button())  # 设置样式
        self.LoginButton.clicked.connect(lambda: self.ExamInfoListView())  # 连接槽函数
        # self.LoginButton.setIcon(QIcon(UPLOAD))
        self.CenterLayout.addWidget(self.LoginButton)  # 加入到布局

        # 返回按钮
        # self.CenterLayout.addStretch()  # 占位
        self.BackButton = QPushButton(self.Lang.Back)
        self.BackButton.setAutoFillBackground(True)  # 允许修改背景颜色
        self.BackButton.adjustSize()  # 按内容自适应宽度
        self.BackButton.setFixedSize(ButtonWidth, ButtonHeight)  # 尺寸
        self.BackButton.setStyleSheet(self.MainViewStyleSheet.Button())  # 设置样式
        self.BackButton.clicked.connect(lambda: self.ExamLoginButtonView())  # 连接槽函数
        # self.BackButton.setIcon(QIcon(UPLOAD))
        self.CenterLayout.addWidget(self.BackButton)

    # 准考证号登录界面
    def LoginWithAdmissionView(self):
        self.ClearLayout(self.CenterLayout)
        self.CenterLayout.setSpacing(10)  # 设置行间距
        ButtonWidth: int = 300
        ButtonHeight: int = 35

        self.AccountInput = QLineEdit()  # 账号输入
        self.AccountInput.setFixedSize(ButtonWidth, 50)  # 尺寸
        # self.AccountInput.setEnabled(False)  # 不允许编辑
        self.AccountInput.setAlignment(Qt.AlignCenter | Qt.AlignBottom | Qt.AlignHCenter)  # 内容居中
        self.AccountInput.setPlaceholderText(self.Lang.AdmissionTicketNumber)  # 设置空内容提示
        self.AccountInput.setStyleSheet(self.MainViewStyleSheet.InputBox())  # 设置样式
        self.AccountInput.setToolTip(self.Lang.AdmissionTicketNumber)  # 设置鼠标提示
        self.CenterLayout.addWidget(self.AccountInput)

        # 登录按钮
        self.LoginButton = QPushButton(self.Lang.Login)
        self.LoginButton.setAutoFillBackground(True)  # 允许修改背景颜色
        self.LoginButton.adjustSize()  # 按内容自适应宽度
        self.LoginButton.setFixedSize(ButtonWidth, ButtonHeight)  # 尺寸
        self.LoginButton.setStyleSheet(self.MainViewStyleSheet.Button())  # 设置样式
        # self.LoginButton.clicked.connect(lambda: self.())  # 连接槽函数
        # self.LoginButton.setIcon(QIcon(UPLOAD))
        self.CenterLayout.addWidget(self.LoginButton)  # 加入到布局

        # 返回按钮
        # self.CenterLayout.addStretch()  # 占位
        self.BackButton = QPushButton(self.Lang.Back)
        self.BackButton.setAutoFillBackground(True)  # 允许修改背景颜色
        self.BackButton.adjustSize()  # 按内容自适应宽度
        self.BackButton.setFixedSize(ButtonWidth, ButtonHeight)  # 尺寸
        self.BackButton.setStyleSheet(self.MainViewStyleSheet.Button())  # 设置样式
        self.BackButton.clicked.connect(lambda: self.ExamLoginButtonView())  # 连接槽函数
        # self.BackButton.setIcon(QIcon(UPLOAD))
        self.CenterLayout.addWidget(self.BackButton)

    # 报名列表
    def ExamInfoListView(self):
        self.ClearLayout(self.CenterLayout)
        self.CenterLayout.setSpacing(15)  # 设置行间距
        ButtonWidth: int = 300
        ButtonHeight: int = 35

        self.ExamInfoSelect = QComboBox()  # 设置下拉框
        self.ExamInfoSelect.adjustSize()  # 按内容自适应宽度
        self.ExamInfoSelect.setView(QListView())  # 设置内容控件
        self.ExamInfoSelect.setFixedSize(ButtonWidth, ButtonHeight)
        self.ExamInfoSelect.setStyleSheet(self.MainViewStyleSheet.SelectBox())

        self.ExamInfoSelect.insertItem(0, self.Lang.ChooseExamSubjects)
        self.ExamInfoSelect.setItemData(0, self.Lang.ChooseExamSubjects, Qt.ToolTipRole)
        self.ExamInfoSelect.insertItem(1, '邓小平理论')
        self.ExamInfoSelect.setItemData(1, '邓小平理论', Qt.ToolTipRole)
        self.ExamInfoSelect.insertItem(2, '马克思主义基本原理')
        self.ExamInfoSelect.setItemData(2, '马克思主义基本原理', Qt.ToolTipRole)
        self.ExamInfoSelect.insertItem(3, '恩格斯经济学恩格斯经济学恩格斯经济学恩格斯经济学恩格斯经济学恩格斯经济学恩格斯经济学恩格斯经济学恩格斯经济学恩格斯经济学恩格斯经济学')
        self.ExamInfoSelect.setItemData(3, '恩格斯经济学恩格斯经济学恩格斯经济学恩格斯经济学恩格斯经济学恩格斯经济学恩格斯经济学恩格斯经济学恩格斯经济学恩格斯经济学恩格斯经济学', Qt.ToolTipRole)
        self.ExamInfoSelect.insertItem(4, '毛主席理论')
        self.ExamInfoSelect.setItemData(4, '毛主席理论', Qt.ToolTipRole)

        self.ExamInfoSelect.setCurrentIndex(0)  # 设置默认选项
        self.CenterLayout.addWidget(self.ExamInfoSelect)

        # 登录按钮
        self.StartButton = QPushButton(self.Lang.Start)
        self.StartButton.setAutoFillBackground(True)  # 允许修改背景颜色
        self.StartButton.adjustSize()  # 按内容自适应宽度
        self.StartButton.setFixedSize(ButtonWidth, ButtonHeight)  # 尺寸
        self.StartButton.setStyleSheet(self.MainViewStyleSheet.Button())  # 设置样式
        # self.StartButton.clicked.connect(lambda: self.())  # 连接槽函数
        # self.StartButton.setIcon(QIcon(UPLOAD))
        self.CenterLayout.addWidget(self.StartButton)  # 加入到布局

        # 返回按钮
        # self.CenterLayout.addStretch()  # 占位
        self.BackButton = QPushButton(self.Lang.Back)
        self.BackButton.setAutoFillBackground(True)  # 允许修改背景颜色
        self.BackButton.adjustSize()  # 按内容自适应宽度
        self.BackButton.setFixedSize(ButtonWidth, ButtonHeight)  # 尺寸
        self.BackButton.setStyleSheet(self.MainViewStyleSheet.Button())  # 设置样式
        self.BackButton.clicked.connect(lambda: self.LoginStudentIDView())  # 连接槽函数
        # self.BackButton.setIcon(QIcon(UPLOAD))
        self.CenterLayout.addWidget(self.BackButton)

    # 刷题 =====================================================================================================================================================================

    # 刷题登陆
    def PracticeLoginView(self):
        self.ClearLayout(self.CenterLayout)
        self.CenterLayout.setSpacing(10)  # 设置行间距
        ButtonWidth: int = 300
        ButtonHeight: int = 35

        self.AccountInput = QLineEdit()  # 账号输入
        self.AccountInput.setFixedSize(ButtonWidth, 50)  # 尺寸
        # self.AccountInput.setEnabled(False)  # 不允许编辑
        self.AccountInput.setAlignment(Qt.AlignCenter | Qt.AlignBottom | Qt.AlignHCenter)  # 内容居中
        self.AccountInput.setPlaceholderText(self.Lang.StudentIDNumber)  # 设置空内容提示
        self.AccountInput.setStyleSheet(self.MainViewStyleSheet.InputBox())  # 设置样式
        self.AccountInput.setToolTip(self.Lang.StudentIDNumber)  # 设置鼠标提示
        self.CenterLayout.addWidget(self.AccountInput)

        # 登录按钮
        self.StartButton = QPushButton(self.Lang.Start)
        self.StartButton.setAutoFillBackground(True)  # 允许修改背景颜色
        self.StartButton.adjustSize()  # 按内容自适应宽度
        self.StartButton.setFixedSize(ButtonWidth, ButtonHeight)  # 尺寸
        self.StartButton.setStyleSheet(self.MainViewStyleSheet.Button())  # 设置样式
        self.StartButton.clicked.connect(lambda: self.CheckQuestionTypeView())  # 连接槽函数
        # self.StartButton.setIcon(QIcon(UPLOAD))
        self.CenterLayout.addWidget(self.StartButton)  # 加入到布局

        # 返回按钮
        # self.CenterLayout.addStretch()  # 占位
        self.BackButton = QPushButton(self.Lang.Back)
        self.BackButton.setAutoFillBackground(True)  # 允许修改背景颜色
        self.BackButton.adjustSize()  # 按内容自适应宽度
        self.BackButton.setFixedSize(ButtonWidth, ButtonHeight)  # 尺寸
        self.BackButton.setStyleSheet(self.MainViewStyleSheet.Button())  # 设置样式
        self.BackButton.clicked.connect(lambda: self.ExamineeLoginButtonView())  # 连接槽函数
        # self.BackButton.setIcon(QIcon(UPLOAD))
        self.CenterLayout.addWidget(self.BackButton)

    # 刷题选择题型
    # 试题类型 1单选 2判断 3多选 4填空 5问答 6代码实训 7拖拽 8连线
    def CheckQuestionTypeView(self):
        self.ClearLayout(self.CenterLayout)
        self.CenterLayout.setSpacing(10)  # 设置行间距
        ButtonWidth: int = 300
        ButtonHeight: int = 35

        self.ExamInfoSelect = QComboBox()  # 设置下拉框
        self.ExamInfoSelect.adjustSize()  # 按内容自适应宽度
        self.ExamInfoSelect.setView(QListView())  # 设置内容控件
        self.ExamInfoSelect.setFixedSize(ButtonWidth, ButtonHeight)
        self.ExamInfoSelect.setStyleSheet(self.MainViewStyleSheet.SelectBox())

        self.ExamInfoSelect.insertItem(0, self.Lang.SelectTestQuestionType)
        self.ExamInfoSelect.setItemData(0, self.Lang.SelectTestQuestionType, Qt.ToolTipRole)
        self.ExamInfoSelect.insertItem(1, self.Lang.MultipleChoiceQuestions)
        self.ExamInfoSelect.setItemData(1, self.Lang.MultipleChoiceQuestions, Qt.ToolTipRole)
        self.ExamInfoSelect.insertItem(2, self.Lang.TrueOrFalse)
        self.ExamInfoSelect.setItemData(2, self.Lang.TrueOrFalse, Qt.ToolTipRole)
        self.ExamInfoSelect.insertItem(3, self.Lang.MultipleChoices)
        self.ExamInfoSelect.setItemData(3, self.Lang.MultipleChoices, Qt.ToolTipRole)
        self.ExamInfoSelect.insertItem(4, self.Lang.FillInTheBlank)
        self.ExamInfoSelect.setItemData(4, self.Lang.FillInTheBlank, Qt.ToolTipRole)
        self.ExamInfoSelect.insertItem(5, self.Lang.QuestionsAndAnswers)
        self.ExamInfoSelect.setItemData(5, self.Lang.QuestionsAndAnswers, Qt.ToolTipRole)
        self.ExamInfoSelect.insertItem(6, self.Lang.ProgrammingQuestions)
        self.ExamInfoSelect.setItemData(6, self.Lang.ProgrammingQuestions, Qt.ToolTipRole)
        self.ExamInfoSelect.insertItem(7, self.Lang.DragAndDrop)
        self.ExamInfoSelect.setItemData(7, self.Lang.DragAndDrop, Qt.ToolTipRole)
        self.ExamInfoSelect.insertItem(8, self.Lang.ConnectingQuestion)
        self.ExamInfoSelect.setItemData(8, self.Lang.ConnectingQuestion, Qt.ToolTipRole)

        self.ExamInfoSelect.setCurrentIndex(0)  # 设置默认选项
        self.CenterLayout.addWidget(self.ExamInfoSelect)

        # 返回按钮
        # self.CenterLayout.addStretch()  # 占位
        self.BackButton = QPushButton(self.Lang.Back)
        self.BackButton.setAutoFillBackground(True)  # 允许修改背景颜色
        self.BackButton.adjustSize()  # 按内容自适应宽度
        self.BackButton.setFixedSize(ButtonWidth, ButtonHeight)  # 尺寸
        self.BackButton.setStyleSheet(self.MainViewStyleSheet.Button())  # 设置样式
        self.BackButton.clicked.connect(lambda: self.PracticeLoginView())  # 连接槽函数
        # self.BackButton.setIcon(QIcon(UPLOAD))
        self.CenterLayout.addWidget(self.BackButton)

    # =====================================================================================================================================================================