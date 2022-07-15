# -*- coding:utf-8 -*-
from Template.BaseTemplate import *
from Template.Manager.ManagerMainTemplate import *
from StyleSheet.MainStyleSheet import *


class MainTemplate(BaseTemplate, QMainWindow):

    def __init__(self, Title=TITLE):
        super().__init__()
        self.MainStyleSheet = MainStyleSheet()
        self.setStyleSheet(self.MainStyleSheet.BaseStyleSheet())
        self.setWindowTitle(Title)  # 窗口标题
        self.setWindowIcon(QIcon(ICON))  # 设置ICON
        # self.setWindowFlags(Qt.FramelessWindowHint)  # 隐藏窗口标题栏
        # self.setWindowFlags(Qt.WindowMinMaxButtonsHint | Qt.WindowCloseButtonHint)  # 显示 最小化 最大化 关闭 按钮
        self.setWindowFlags(Qt.WindowStaysOnTopHint)  # 窗口置顶
        self.setFixedSize(500, 300)  # 设置窗口最最小值
        # SelfSize = self.geometry()  # 获取本窗口大小
        # self.move(int((self.SW - SelfSize.width()) / 2), int((self.SH - SelfSize.height()) / 2))  # 居中显示

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
        ExamineeLoginButton = QPushButton(self.Lang.ExamineeLogin)
        ExamineeLoginButton.setAutoFillBackground(True)  # 允许修改背景颜色
        ExamineeLoginButton.adjustSize()  # 按内容自适应宽度
        ExamineeLoginButton.setFixedSize(ButtonWidth, ButtonHeight)  # 尺寸
        ExamineeLoginButton.setStyleSheet(self.MainStyleSheet.Button())  # 设置样式
        ExamineeLoginButton.clicked.connect(lambda: self.ExamineeLoginButtonView())  # 连接槽函数
        # ExamineeLoginButton.setIcon(QIcon(UPLOAD))
        self.CenterLayout.addWidget(ExamineeLoginButton)  # 加入到布局

        # 教师登录按钮
        TeacherLoginButton = QPushButton(self.Lang.TeacherLogin)  # 教师登录
        TeacherLoginButton.setAutoFillBackground(True)  # 允许修改背景颜色
        TeacherLoginButton.adjustSize()  # 按内容自适应宽度
        TeacherLoginButton.setFixedSize(ButtonWidth, ButtonHeight)  # 尺寸
        TeacherLoginButton.setStyleSheet(self.MainStyleSheet.Button())  # 设置样式
        # TeacherLoginButton.clicked.connect(lambda: self.UploadListWindowObject.show())  # 连接槽函数
        # TeacherLoginButton.setIcon(QIcon(UPLOAD))
        self.CenterLayout.addWidget(TeacherLoginButton)  # 加入到布局

        # 管理员登录按钮
        ManagerLoginButton = QPushButton(self.Lang.ManagerLogin)  # 管理员登录
        ManagerLoginButton.setAutoFillBackground(True)  # 允许修改背景颜色
        ManagerLoginButton.adjustSize()  # 按内容自适应宽度
        ManagerLoginButton.setFixedSize(ButtonWidth, ButtonHeight)  # 尺寸
        ManagerLoginButton.setStyleSheet(self.MainStyleSheet.Button())  # 设置样式
        ManagerLoginButton.clicked.connect(lambda: self.ManagerLoginView())  # 连接槽函数
        # ManagerLoginButton.setIcon(QIcon(UPLOAD))
        self.CenterLayout.addWidget(ManagerLoginButton)  # 加入到布局

    # 考生单独登录界面按钮
    def ExamineeLoginButtonView(self):
        self.ClearLayout(self.CenterLayout)
        self.CenterLayout.setSpacing(15)  # 设置行间距
        ButtonWidth: int = 300
        ButtonHeight: int = 50

        # 考试按钮
        ExamButton = QPushButton(self.Lang.Exam)
        ExamButton.setAutoFillBackground(True)  # 允许修改背景颜色
        ExamButton.adjustSize()  # 按内容自适应宽度
        ExamButton.setFixedSize(ButtonWidth, ButtonHeight)  # 尺寸
        ExamButton.setStyleSheet(self.MainStyleSheet.Button())  # 设置样式
        ExamButton.clicked.connect(lambda: self.ExamLoginButtonView())  # 连接槽函数
        # ExamButton.setIcon(QIcon(UPLOAD))
        self.CenterLayout.addWidget(ExamButton)  # 加入到布局

        # 刷题按钮
        PracticeButton = QPushButton(self.Lang.PracticeQuestions)
        PracticeButton.setAutoFillBackground(True)  # 允许修改背景颜色
        PracticeButton.adjustSize()  # 按内容自适应宽度
        PracticeButton.setFixedSize(ButtonWidth, ButtonHeight)  # 尺寸
        PracticeButton.setStyleSheet(self.MainStyleSheet.Button())  # 设置样式
        PracticeButton.clicked.connect(lambda: self.PracticeLoginView())  # 连接槽函数
        # PracticeButton.setIcon(QIcon(UPLOAD))
        self.CenterLayout.addWidget(PracticeButton)  # 加入到布局

        # 返回按钮
        # self.CenterLayout.addStretch()  # 占位
        BackButton = QPushButton(self.Lang.Back)
        BackButton.setAutoFillBackground(True)  # 允许修改背景颜色
        BackButton.adjustSize()  # 按内容自适应宽度
        BackButton.setFixedSize(ButtonWidth, ButtonHeight)  # 尺寸
        BackButton.setStyleSheet(self.MainStyleSheet.Button())  # 设置样式
        BackButton.clicked.connect(lambda: self.LoginButtonView())  # 连接槽函数
        # BackButton.setIcon(QIcon(UPLOAD))
        self.CenterLayout.addWidget(BackButton)

    # 考试 =====================================================================================================================================================================

    # 考试登录界面
    def ExamLoginButtonView(self):
        self.ClearLayout(self.CenterLayout)
        self.CenterLayout.setSpacing(15)  # 设置行间距
        ButtonWidth: int = 300
        ButtonHeight: int = 50

        # 学生证号登录按钮
        LoginStudentIDButton = QPushButton(self.Lang.LoginStudentID)
        LoginStudentIDButton.setAutoFillBackground(True)  # 允许修改背景颜色
        LoginStudentIDButton.adjustSize()  # 按内容自适应宽度
        LoginStudentIDButton.setFixedSize(ButtonWidth, ButtonHeight)  # 尺寸
        LoginStudentIDButton.setStyleSheet(self.MainStyleSheet.Button())  # 设置样式
        LoginStudentIDButton.clicked.connect(lambda: self.LoginStudentIDView())  # 连接槽函数
        # LoginStudentIDButton.setIcon(QIcon(UPLOAD))
        self.CenterLayout.addWidget(LoginStudentIDButton)  # 加入到布局

        # 准考证号登录按钮
        LoginWithAdmissionButton = QPushButton(self.Lang.LoginWithAdmission)
        LoginWithAdmissionButton.setAutoFillBackground(True)  # 允许修改背景颜色
        LoginWithAdmissionButton.adjustSize()  # 按内容自适应宽度
        LoginWithAdmissionButton.setFixedSize(ButtonWidth, ButtonHeight)  # 尺寸
        LoginWithAdmissionButton.setStyleSheet(self.MainStyleSheet.Button())  # 设置样式
        LoginWithAdmissionButton.clicked.connect(lambda: self.LoginWithAdmissionView())  # 连接槽函数
        # LoginWithAdmissionButton.setIcon(QIcon(UPLOAD))
        self.CenterLayout.addWidget(LoginWithAdmissionButton)  # 加入到布局

        # 返回按钮
        # self.CenterLayout.addStretch()  # 占位
        BackButton = QPushButton(self.Lang.Back)
        BackButton.setAutoFillBackground(True)  # 允许修改背景颜色
        BackButton.adjustSize()  # 按内容自适应宽度
        BackButton.setFixedSize(ButtonWidth, ButtonHeight)  # 尺寸
        BackButton.setStyleSheet(self.MainStyleSheet.Button())  # 设置样式
        BackButton.clicked.connect(lambda: self.ExamineeLoginButtonView())  # 连接槽函数
        # BackButton.setIcon(QIcon(UPLOAD))
        self.CenterLayout.addWidget(BackButton)

    # 学生证号登录界面
    def LoginStudentIDView(self):
        self.ClearLayout(self.CenterLayout)
        self.CenterLayout.setSpacing(10)  # 设置行间距
        ButtonWidth: int = 300
        ButtonHeight: int = 35

        AccountInput = QLineEdit()  # 账号输入
        AccountInput.setFixedSize(ButtonWidth, 50)  # 尺寸
        # AccountInput.setEnabled(False)  # 不允许编辑
        AccountInput.setAlignment(Qt.AlignCenter | Qt.AlignBottom | Qt.AlignHCenter)  # 内容居中
        AccountInput.setPlaceholderText(self.Lang.StudentIDNumber)  # 设置空内容提示
        AccountInput.setStyleSheet(self.MainStyleSheet.InputBox())  # 设置样式
        AccountInput.setToolTip(self.Lang.StudentIDNumber)  # 设置鼠标提示
        self.CenterLayout.addWidget(AccountInput)

        # 登录按钮
        LoginButton = QPushButton(self.Lang.Login)
        LoginButton.setAutoFillBackground(True)  # 允许修改背景颜色
        LoginButton.adjustSize()  # 按内容自适应宽度
        LoginButton.setFixedSize(ButtonWidth, ButtonHeight)  # 尺寸
        LoginButton.setStyleSheet(self.MainStyleSheet.Button())  # 设置样式
        LoginButton.clicked.connect(lambda: self.ExamInfoListView())  # 连接槽函数
        # LoginButton.setIcon(QIcon(UPLOAD))
        self.CenterLayout.addWidget(LoginButton)  # 加入到布局

        # 返回按钮
        # self.CenterLayout.addStretch()  # 占位
        BackButton = QPushButton(self.Lang.Back)
        BackButton.setAutoFillBackground(True)  # 允许修改背景颜色
        BackButton.adjustSize()  # 按内容自适应宽度
        BackButton.setFixedSize(ButtonWidth, ButtonHeight)  # 尺寸
        BackButton.setStyleSheet(self.MainStyleSheet.Button())  # 设置样式
        BackButton.clicked.connect(lambda: self.ExamLoginButtonView())  # 连接槽函数
        # BackButton.setIcon(QIcon(UPLOAD))
        self.CenterLayout.addWidget(BackButton)

    # 准考证号登录界面
    def LoginWithAdmissionView(self):
        self.ClearLayout(self.CenterLayout)
        self.CenterLayout.setSpacing(10)  # 设置行间距
        ButtonWidth: int = 300
        ButtonHeight: int = 35

        AccountInput = QLineEdit()  # 账号输入
        AccountInput.setFixedSize(ButtonWidth, 50)  # 尺寸
        # AccountInput.setEnabled(False)  # 不允许编辑
        AccountInput.setAlignment(Qt.AlignCenter | Qt.AlignBottom | Qt.AlignHCenter)  # 内容居中
        AccountInput.setPlaceholderText(self.Lang.AdmissionTicketNumber)  # 设置空内容提示
        AccountInput.setStyleSheet(self.MainStyleSheet.InputBox())  # 设置样式
        AccountInput.setToolTip(self.Lang.AdmissionTicketNumber)  # 设置鼠标提示
        self.CenterLayout.addWidget(AccountInput)

        # 登录按钮
        LoginButton = QPushButton(self.Lang.Login)
        LoginButton.setAutoFillBackground(True)  # 允许修改背景颜色
        LoginButton.adjustSize()  # 按内容自适应宽度
        LoginButton.setFixedSize(ButtonWidth, ButtonHeight)  # 尺寸
        LoginButton.setStyleSheet(self.MainStyleSheet.Button())  # 设置样式
        # LoginButton.clicked.connect(lambda: self.())  # 连接槽函数
        # LoginButton.setIcon(QIcon(UPLOAD))
        self.CenterLayout.addWidget(LoginButton)  # 加入到布局

        # 返回按钮
        # self.CenterLayout.addStretch()  # 占位
        BackButton = QPushButton(self.Lang.Back)
        BackButton.setAutoFillBackground(True)  # 允许修改背景颜色
        BackButton.adjustSize()  # 按内容自适应宽度
        BackButton.setFixedSize(ButtonWidth, ButtonHeight)  # 尺寸
        BackButton.setStyleSheet(self.MainStyleSheet.Button())  # 设置样式
        BackButton.clicked.connect(lambda: self.ExamLoginButtonView())  # 连接槽函数
        # BackButton.setIcon(QIcon(UPLOAD))
        self.CenterLayout.addWidget(BackButton)

    # 报名列表
    def ExamInfoListView(self):
        self.ClearLayout(self.CenterLayout)
        self.CenterLayout.setSpacing(15)  # 设置行间距
        ButtonWidth: int = 300
        ButtonHeight: int = 35

        ExamInfoSelect = QComboBox()  # 设置下拉框
        ExamInfoSelect.adjustSize()  # 按内容自适应宽度
        ExamInfoSelect.setView(QListView())  # 设置内容控件
        ExamInfoSelect.setFixedSize(ButtonWidth, ButtonHeight)
        ExamInfoSelect.setStyleSheet(self.MainStyleSheet.SelectBox())

        ExamInfoSelect.insertItem(0, self.Lang.ChooseExamSubjects)
        ExamInfoSelect.setItemData(0, self.Lang.ChooseExamSubjects, Qt.ToolTipRole)
        ExamInfoSelect.insertItem(1, '邓小平理论')
        ExamInfoSelect.setItemData(1, '邓小平理论', Qt.ToolTipRole)
        ExamInfoSelect.insertItem(2, '马克思主义基本原理')
        ExamInfoSelect.setItemData(2, '马克思主义基本原理', Qt.ToolTipRole)
        ExamInfoSelect.insertItem(3, '恩格斯经济学恩格斯经济学恩格斯经济学恩格斯经济学恩格斯经济学恩格斯经济学恩格斯经济学恩格斯经济学恩格斯经济学恩格斯经济学恩格斯经济学')
        ExamInfoSelect.setItemData(3, '恩格斯经济学恩格斯经济学恩格斯经济学恩格斯经济学恩格斯经济学恩格斯经济学恩格斯经济学恩格斯经济学恩格斯经济学恩格斯经济学恩格斯经济学', Qt.ToolTipRole)
        ExamInfoSelect.insertItem(4, '毛主席理论')
        ExamInfoSelect.setItemData(4, '毛主席理论', Qt.ToolTipRole)

        ExamInfoSelect.setCurrentIndex(0)  # 设置默认选项
        self.CenterLayout.addWidget(ExamInfoSelect)

        # 登录按钮
        StartButton = QPushButton(self.Lang.Start)
        StartButton.setAutoFillBackground(True)  # 允许修改背景颜色
        StartButton.adjustSize()  # 按内容自适应宽度
        StartButton.setFixedSize(ButtonWidth, ButtonHeight)  # 尺寸
        StartButton.setStyleSheet(self.MainStyleSheet.Button())  # 设置样式
        # StartButton.clicked.connect(lambda: self.())  # 连接槽函数
        # StartButton.setIcon(QIcon(UPLOAD))
        self.CenterLayout.addWidget(StartButton)  # 加入到布局

        # 返回按钮
        # self.CenterLayout.addStretch()  # 占位
        BackButton = QPushButton(self.Lang.Back)
        BackButton.setAutoFillBackground(True)  # 允许修改背景颜色
        BackButton.adjustSize()  # 按内容自适应宽度
        BackButton.setFixedSize(ButtonWidth, ButtonHeight)  # 尺寸
        BackButton.setStyleSheet(self.MainStyleSheet.Button())  # 设置样式
        BackButton.clicked.connect(lambda: self.LoginStudentIDView())  # 连接槽函数
        # BackButton.setIcon(QIcon(UPLOAD))
        self.CenterLayout.addWidget(BackButton)

    # 刷题 =====================================================================================================================================================================

    # 刷题登陆
    def PracticeLoginView(self):
        self.ClearLayout(self.CenterLayout)
        self.CenterLayout.setSpacing(10)  # 设置行间距
        ButtonWidth: int = 300
        ButtonHeight: int = 35

        AccountInput = QLineEdit()  # 账号输入
        AccountInput.setFixedSize(ButtonWidth, 50)  # 尺寸
        # AccountInput.setEnabled(False)  # 不允许编辑
        AccountInput.setAlignment(Qt.AlignCenter | Qt.AlignBottom | Qt.AlignHCenter)  # 内容居中
        AccountInput.setPlaceholderText(self.Lang.StudentIDNumber)  # 设置空内容提示
        AccountInput.setStyleSheet(self.MainStyleSheet.InputBox())  # 设置样式
        AccountInput.setToolTip(self.Lang.StudentIDNumber)  # 设置鼠标提示
        self.CenterLayout.addWidget(AccountInput)

        # 登录按钮
        StartButton = QPushButton(self.Lang.Start)
        StartButton.setAutoFillBackground(True)  # 允许修改背景颜色
        StartButton.adjustSize()  # 按内容自适应宽度
        StartButton.setFixedSize(ButtonWidth, ButtonHeight)  # 尺寸
        StartButton.setStyleSheet(self.MainStyleSheet.Button())  # 设置样式
        StartButton.clicked.connect(lambda: self.CheckQuestionTypeView())  # 连接槽函数
        # StartButton.setIcon(QIcon(UPLOAD))
        self.CenterLayout.addWidget(StartButton)  # 加入到布局

        # 返回按钮
        # self.CenterLayout.addStretch()  # 占位
        BackButton = QPushButton(self.Lang.Back)
        BackButton.setAutoFillBackground(True)  # 允许修改背景颜色
        BackButton.adjustSize()  # 按内容自适应宽度
        BackButton.setFixedSize(ButtonWidth, ButtonHeight)  # 尺寸
        BackButton.setStyleSheet(self.MainStyleSheet.Button())  # 设置样式
        BackButton.clicked.connect(lambda: self.ExamineeLoginButtonView())  # 连接槽函数
        # BackButton.setIcon(QIcon(UPLOAD))
        self.CenterLayout.addWidget(BackButton)

    # 刷题选择题型
    # 试题类型 1单选 2判断 3多选 4填空 5问答 6编程 7拖拽 8连线
    def CheckQuestionTypeView(self):
        self.ClearLayout(self.CenterLayout)
        self.CenterLayout.setSpacing(10)  # 设置行间距
        ButtonWidth: int = 300
        ButtonHeight: int = 35

        ExamInfoSelect = QComboBox()  # 设置下拉框
        ExamInfoSelect.adjustSize()  # 按内容自适应宽度
        ExamInfoSelect.setView(QListView())  # 设置内容控件
        ExamInfoSelect.setFixedSize(ButtonWidth, ButtonHeight)
        ExamInfoSelect.setStyleSheet(self.MainStyleSheet.SelectBox())

        ExamInfoSelect.insertItem(0, self.Lang.SelectTestQuestionType)
        ExamInfoSelect.setItemData(0, self.Lang.SelectTestQuestionType, Qt.ToolTipRole)
        ExamInfoSelect.insertItem(1, self.Lang.MultipleChoiceQuestions)
        ExamInfoSelect.setItemData(1, self.Lang.MultipleChoiceQuestions, Qt.ToolTipRole)
        ExamInfoSelect.insertItem(2, self.Lang.TrueOrFalse)
        ExamInfoSelect.setItemData(2, self.Lang.TrueOrFalse, Qt.ToolTipRole)
        ExamInfoSelect.insertItem(3, self.Lang.MultipleChoices)
        ExamInfoSelect.setItemData(3, self.Lang.MultipleChoices, Qt.ToolTipRole)
        ExamInfoSelect.insertItem(4, self.Lang.FillInTheBlank)
        ExamInfoSelect.setItemData(4, self.Lang.FillInTheBlank, Qt.ToolTipRole)
        ExamInfoSelect.insertItem(5, self.Lang.QuestionsAndAnswers)
        ExamInfoSelect.setItemData(5, self.Lang.QuestionsAndAnswers, Qt.ToolTipRole)
        ExamInfoSelect.insertItem(6, self.Lang.ProgrammingQuestions)
        ExamInfoSelect.setItemData(6, self.Lang.ProgrammingQuestions, Qt.ToolTipRole)
        ExamInfoSelect.insertItem(7, self.Lang.DragAndDrop)
        ExamInfoSelect.setItemData(7, self.Lang.DragAndDrop, Qt.ToolTipRole)
        ExamInfoSelect.insertItem(8, self.Lang.ConnectingQuestion)
        ExamInfoSelect.setItemData(8, self.Lang.ConnectingQuestion, Qt.ToolTipRole)

        ExamInfoSelect.setCurrentIndex(0)  # 设置默认选项
        self.CenterLayout.addWidget(ExamInfoSelect)

        # 登录按钮
        StartButton = QPushButton(self.Lang.Start)
        StartButton.setAutoFillBackground(True)  # 允许修改背景颜色
        StartButton.adjustSize()  # 按内容自适应宽度
        StartButton.setFixedSize(ButtonWidth, ButtonHeight)  # 尺寸
        StartButton.setStyleSheet(self.MainStyleSheet.Button())  # 设置样式
        # StartButton.clicked.connect(lambda: self.())  # 连接槽函数
        # StartButton.setIcon(QIcon(UPLOAD))
        self.CenterLayout.addWidget(StartButton)  # 加入到布局

        # 返回按钮
        # self.CenterLayout.addStretch()  # 占位
        BackButton = QPushButton(self.Lang.Back)
        BackButton.setAutoFillBackground(True)  # 允许修改背景颜色
        BackButton.adjustSize()  # 按内容自适应宽度
        BackButton.setFixedSize(ButtonWidth, ButtonHeight)  # 尺寸
        BackButton.setStyleSheet(self.MainStyleSheet.Button())  # 设置样式
        BackButton.clicked.connect(lambda: self.PracticeLoginView())  # 连接槽函数
        # BackButton.setIcon(QIcon(UPLOAD))
        self.CenterLayout.addWidget(BackButton)

    # 管理员 =====================================================================================================================================================================

    # 管理员首页
    def ManagerLoginView(self):
        self.ClearLayout(self.CenterLayout)
        self.CenterLayout.setSpacing(10)  # 设置行间距
        ButtonWidth: int = 300
        ButtonHeight: int = 35

        AccountInput = QLineEdit()  # 账号输入
        AccountInput.setFixedSize(ButtonWidth, 50)  # 尺寸
        # AccountInput.setEnabled(False)  # 不允许编辑
        AccountInput.setAlignment(Qt.AlignCenter | Qt.AlignBottom | Qt.AlignHCenter)  # 内容居中
        AccountInput.setPlaceholderText(self.Lang.AdministratorAccount)  # 设置空内容提示
        AccountInput.setStyleSheet(self.MainStyleSheet.InputBox())  # 设置样式
        AccountInput.setToolTip(self.Lang.AdministratorAccount)  # 设置鼠标提示
        self.CenterLayout.addWidget(AccountInput)

        PasswordInput = QLineEdit()  # 密码输入
        PasswordInput.setFixedSize(ButtonWidth, 50)  # 尺寸
        # PasswordInput.setEnabled(False)  # 不允许编辑
        PasswordInput.setAlignment(Qt.AlignCenter | Qt.AlignBottom | Qt.AlignHCenter)  # 内容居中
        PasswordInput.setPlaceholderText(self.Lang.Password)  # 设置空内容提示
        PasswordInput.setStyleSheet(self.MainStyleSheet.InputBox())  # 设置样式
        PasswordInput.setToolTip(self.Lang.Password)  # 设置鼠标提示
        self.CenterLayout.addWidget(PasswordInput)

        # 登录按钮
        LoginButton = QPushButton(self.Lang.Login)
        LoginButton.setAutoFillBackground(True)  # 允许修改背景颜色
        LoginButton.adjustSize()  # 按内容自适应宽度
        LoginButton.setFixedSize(ButtonWidth, ButtonHeight)  # 尺寸
        LoginButton.setStyleSheet(self.MainStyleSheet.Button())  # 设置样式
        LoginButton.clicked.connect(lambda: self.ManagerMainView())  # 连接槽函数
        # LoginButton.setIcon(QIcon(UPLOAD))
        self.CenterLayout.addWidget(LoginButton)  # 加入到布局

        # 返回按钮
        # self.CenterLayout.addStretch()  # 占位
        BackButton = QPushButton(self.Lang.Back)
        BackButton.setAutoFillBackground(True)  # 允许修改背景颜色
        BackButton.adjustSize()  # 按内容自适应宽度
        BackButton.setFixedSize(ButtonWidth, ButtonHeight)  # 尺寸
        BackButton.setStyleSheet(self.MainStyleSheet.Button())  # 设置样式
        BackButton.clicked.connect(lambda: self.LoginButtonView())  # 连接槽函数
        # BackButton.setIcon(QIcon(UPLOAD))
        self.CenterLayout.addWidget(BackButton)

    def ShowMain(self):
        self.show()

    # 管理员主界面
    def ManagerMainView(self):
        self.hide()
        self.managerMainTemplate = ManagerMainTemplate()
        self.managerMainTemplate.show()