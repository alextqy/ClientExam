# -*- coding:utf-8 -*-
from Template.BaseTemplate import *
from StyleSheet.ManagerMainStyleSheet import *
from Template.Manager.ManagerFrameTemplate import *
from Template.Manager.TeacherFrameTemplate import *


class ManagerMainTemplate(BaseTemplate, QDialog):

    def __init__(self, Title=TITLE, Icon=ICON):
        super().__init__()
        self.ManagerMainStyleSheet = ManagerMainStyleSheet()  # 实例化样式
        self.setStyleSheet(self.ManagerMainStyleSheet.BaseStyleSheet())  # 设置样式
        self.setWindowFlags(Qt.WindowMinMaxButtonsHint | Qt.WindowCloseButtonHint)  # 显示 最小化 最大化 关闭 按钮
        self.setWindowTitle(Title)  # 窗口标题
        self.setWindowIcon(QIcon(Icon))  # 设置ICON
        self.setMinimumSize(1200, 800)  # 设置最小尺寸

        self.CenterLayout = QVBoxLayout()  # 设置主布局
        self.CenterLayout.setContentsMargins(5, 5, 5, 5)  # 设置边距

        self.CurrentTemplate = ''

        # 顶部 =====================================================================================================================================================================

        # self.TopLayout = QHBoxLayout()
        # self.TopLayout.setContentsMargins(0, 0, 0, 0)  # 设置边距
        # self.CenterLayout.addLayout(self.TopLayout)  # 加入布局

        # 主体 =====================================================================================================================================================================

        self.BodyLayout = QHBoxLayout()  # 主体布局
        self.BodyLayout.setContentsMargins(0, 0, 0, 0)  # 设置边距

        self.BodyLeftLayout = QVBoxLayout()  # 主体左侧布局
        self.BodyLeftLayout.setContentsMargins(0, 0, 0, 0)  # 设置边距
        self.BodyLayout.addLayout(self.BodyLeftLayout)  # 加入布局

        self.BodyRightLayout = QVBoxLayout()  # 主体右侧布局
        self.BodyRightLayout.setContentsMargins(0, 0, 0, 0)  # 设置边距
        self.BodyLayout.addLayout(self.BodyRightLayout)  # 加入布局

        self.CenterLayout.addLayout(self.BodyLayout)  # 加入布局

        # 底部 =====================================================================================================================================================================

        self.BottomLayout = QHBoxLayout()
        self.BottomLayout.setContentsMargins(0, 0, 0, 0)  # 设置边距
        self.CenterLayout.addLayout(self.BottomLayout)  # 加入布局

        # =====================================================================================================================================================================

        self.MainView()
        self.InitTemplateView()

        # =====================================================================================================================================================================

        self.setLayout(self.CenterLayout)  # 添加中央布局

    # 主页
    def MainView(self):
        # self.TopLabel = QLabel(TITLE)  # 顶部框架
        # self.TopLabel.setAlignment(Qt.AlignVCenter | Qt.AlignHCenter)
        # self.TopLabel.adjustSize()  # 根据内容自适应宽度
        # self.TopLabel.setContentsMargins(0, 0, 0, 0)  # 设置边距
        # self.TopLabel.setFixedHeight(30)  # 尺寸
        # self.TopLabel.setStyleSheet(self.ManagerMainStyleSheet.Label())  # 设置样式
        # self.TopLayout.addWidget(self.TopLabel)  # 添加控件

        self.MenuFrame = QFrame()  # 菜单
        self.MenuFrame.adjustSize()  # 根据内容自适应宽度
        self.MenuFrame.setContentsMargins(0, 0, 0, 0)  # 设置边距
        self.MenuFrame.setFixedWidth(200)  # 尺寸
        self.MenuFrame.setStyleSheet(self.ManagerMainStyleSheet.MenuFrame())  # 设置样式
        self.BodyLeftLayout.addWidget(self.MenuFrame)  # 添加控件

        self.MenuLayout = QVBoxLayout()  # 菜单按钮布局
        self.MenuLayout.setContentsMargins(0, 0, 0, 0)  # 设置边距
        self.MenuFrame.setLayout(self.MenuLayout)  # 添加布局

        self.InitMenu()

        self.DataFrame = QFrame()  # 主体框架
        self.DataFrame.adjustSize()  # 根据内容自适应宽度
        self.DataFrame.setContentsMargins(0, 0, 0, 0)  # 设置边距
        # self.DataFrame.setFixedHeight(30)  # 尺寸
        self.DataFrame.setStyleSheet(self.ManagerMainStyleSheet.DataFrame())  # 设置样式
        self.BodyRightLayout.addWidget(self.DataFrame)  # 添加控件

        self.DataLayout = QVBoxLayout()  # 主体数据布局
        self.DataLayout.setContentsMargins(0, 0, 0, 0)  # 设置边距
        self.InitLabel = QLabel()  # 开始界面
        self.InitLabel.setContentsMargins(0, 0, 0, 0)  # 设置边距
        self.InitLabel.setStyleSheet(self.ManagerMainStyleSheet.InitLabel())  # 设置样式
        self.DataLayout.addWidget(self.InitLabel)  # 添加控件
        self.DataFrame.setLayout(self.DataLayout)  # 添加布局

        self.BottomLabel = QLabel(TITLE)  # 底部框架
        self.BottomLabel.setAlignment(Qt.AlignVCenter | Qt.AlignHCenter)  # 字体居中
        self.BottomLabel.adjustSize()  # 根据内容自适应宽度
        self.BottomLabel.setContentsMargins(0, 0, 0, 0)  # 设置边距
        self.BottomLabel.setFixedHeight(30)  # 尺寸
        self.BottomLabel.setStyleSheet(self.ManagerMainStyleSheet.Label())  # 设置样式
        self.BottomLayout.addWidget(self.BottomLabel)  # 添加控件

    # 构建菜单
    def InitMenu(self):
        # 设置按钮尺寸
        ButtonWidth: int = 180
        ButtonHeight: int = 35

        # =====================================================================================================================================================================

        # 管理员
        self.ManagerButton = QPushButton(self.Lang.Manager)
        self.ManagerButton.setStyleSheet(self.ManagerMainStyleSheet.MenuButton1())  # 设置样式
        self.ManagerButton.setFixedSize(ButtonWidth, ButtonHeight)  # 尺寸
        self.ManagerButton.clicked.connect(lambda: self.TemplateView('ManagerFrameTemplate'))  # 连接槽函数
        self.MenuLayout.addWidget(self.ManagerButton, 0, Qt.AlignCenter | Qt.AlignTop)  # 添加控件 向上居中对齐

        # 教师
        self.TeacherButton = QPushButton(self.Lang.Teacher)
        self.TeacherButton.setStyleSheet(self.ManagerMainStyleSheet.MenuButton1())  # 设置样式
        self.TeacherButton.setFixedSize(ButtonWidth, ButtonHeight)  # 尺寸
        self.TeacherButton.clicked.connect(lambda: self.TemplateView('TeacherFrameTemplate'))  # 连接槽函数
        self.MenuLayout.addWidget(self.TeacherButton, 0, Qt.AlignCenter | Qt.AlignTop)  # 添加控件 向上居中对齐

        # 班级
        self.ClassButton = QPushButton(self.Lang.Class)
        self.ClassButton.setStyleSheet(self.ManagerMainStyleSheet.MenuButton1())  # 设置样式
        self.ClassButton.setFixedSize(ButtonWidth, ButtonHeight)  # 尺寸
        self.MenuLayout.addWidget(self.ClassButton, 0, Qt.AlignCenter | Qt.AlignTop)  # 添加控件 向上居中对齐

        # 考生
        self.ExamineeButton = QPushButton(self.Lang.Examinee)
        self.ExamineeButton.setStyleSheet(self.ManagerMainStyleSheet.MenuButton1())  # 设置样式
        self.ExamineeButton.setFixedSize(ButtonWidth, ButtonHeight)  # 尺寸
        self.MenuLayout.addWidget(self.ExamineeButton, 0, Qt.AlignCenter | Qt.AlignTop)  # 添加控件 向上居中对齐

        # 报名
        self.RegistrationDataButton = QPushButton(self.Lang.RegistrationData)
        self.RegistrationDataButton.setStyleSheet(self.ManagerMainStyleSheet.MenuButton1())  # 设置样式
        self.RegistrationDataButton.setFixedSize(ButtonWidth, ButtonHeight)  # 尺寸
        self.MenuLayout.addWidget(self.RegistrationDataButton, 0, Qt.AlignCenter | Qt.AlignTop)  # 添加控件 向上居中对齐

        # =====================================================================================================================================================================

        # 科目
        self.SubjectButton = QPushButton(self.Lang.Subject)
        self.SubjectButton.setStyleSheet(self.ManagerMainStyleSheet.MenuButton2())  # 设置样式
        self.SubjectButton.setFixedSize(ButtonWidth, ButtonHeight)  # 尺寸
        self.MenuLayout.addWidget(self.SubjectButton, 0, Qt.AlignCenter | Qt.AlignTop)  # 添加控件 向上居中对齐

        # 知识点
        self.KnowledgePointButton = QPushButton(self.Lang.KnowledgePoint)
        self.KnowledgePointButton.setStyleSheet(self.ManagerMainStyleSheet.MenuButton2())  # 设置样式
        self.KnowledgePointButton.setFixedSize(ButtonWidth, ButtonHeight)  # 尺寸
        self.MenuLayout.addWidget(self.KnowledgePointButton, 0, Qt.AlignCenter | Qt.AlignTop)  # 添加控件 向上居中对齐

        # 大标题
        self.HeadlineButton = QPushButton(self.Lang.Headline)
        self.HeadlineButton.setStyleSheet(self.ManagerMainStyleSheet.MenuButton2())  # 设置样式
        self.HeadlineButton.setFixedSize(ButtonWidth, ButtonHeight)  # 尺寸
        self.MenuLayout.addWidget(self.HeadlineButton, 0, Qt.AlignCenter | Qt.AlignTop)  # 添加控件 向上居中对齐

        # 试题
        self.TestQuestionButton = QPushButton(self.Lang.TestQuestion)
        self.TestQuestionButton.setStyleSheet(self.ManagerMainStyleSheet.MenuButton2())  # 设置样式
        self.TestQuestionButton.setFixedSize(ButtonWidth, ButtonHeight)  # 尺寸
        self.MenuLayout.addWidget(self.TestQuestionButton, 0, Qt.AlignCenter | Qt.AlignTop)  # 添加控件 向上居中对齐

        # 试卷
        self.TestPaperButton = QPushButton(self.Lang.TestPaper)
        self.TestPaperButton.setStyleSheet(self.ManagerMainStyleSheet.MenuButton2())  # 设置样式
        self.TestPaperButton.setFixedSize(ButtonWidth, ButtonHeight)  # 尺寸
        self.MenuLayout.addWidget(self.TestPaperButton, 0, Qt.AlignCenter | Qt.AlignTop)  # 添加控件 向上居中对齐

        # 试卷规则
        self.TestPaperRulesButton = QPushButton(self.Lang.TestPaperRules)
        self.TestPaperRulesButton.setStyleSheet(self.ManagerMainStyleSheet.MenuButton2())  # 设置样式
        self.TestPaperRulesButton.setFixedSize(ButtonWidth, ButtonHeight)  # 尺寸
        self.MenuLayout.addWidget(self.TestPaperRulesButton, 0, Qt.AlignCenter | Qt.AlignTop)  # 添加控件 向上居中对齐

        # 答题卡
        self.AnswerSheetButton = QPushButton(self.Lang.AnswerSheet)
        self.AnswerSheetButton.setStyleSheet(self.ManagerMainStyleSheet.MenuButton2())  # 设置样式
        self.AnswerSheetButton.setFixedSize(ButtonWidth, ButtonHeight)  # 尺寸
        self.MenuLayout.addWidget(self.AnswerSheetButton, 0, Qt.AlignCenter | Qt.AlignTop)  # 添加控件 向上居中对齐

        # =====================================================================================================================================================================

        # 系统日志
        self.SystemLogButton = QPushButton(self.Lang.SystemLog)
        self.SystemLogButton.setStyleSheet(self.ManagerMainStyleSheet.MenuButton3())  # 设置样式
        self.SystemLogButton.setFixedSize(ButtonWidth, ButtonHeight)  # 尺寸
        self.MenuLayout.addWidget(self.SystemLogButton, 0, Qt.AlignCenter | Qt.AlignTop)  # 添加控件 向上居中对齐

        # 考生日志
        self.ExamLogButton = QPushButton(self.Lang.ExamLog)
        self.ExamLogButton.setStyleSheet(self.ManagerMainStyleSheet.MenuButton3())  # 设置样式
        self.ExamLogButton.setFixedSize(ButtonWidth, ButtonHeight)  # 尺寸
        self.MenuLayout.addWidget(self.ExamLogButton, 0, Qt.AlignCenter | Qt.AlignTop)  # 添加控件 向上居中对齐

        # 退出
        self.ExitButton = QPushButton(self.Lang.Exit)
        self.ExitButton.setStyleSheet(self.ManagerMainStyleSheet.MenuButton3())  # 设置样式
        self.ExitButton.setFixedSize(ButtonWidth, ButtonHeight)  # 尺寸
        self.ExitButton.clicked.connect(lambda: os._exit(0))  # 连接槽函数
        self.MenuLayout.addWidget(self.ExitButton, 0, Qt.AlignCenter | Qt.AlignTop)  # 添加控件 向上居中对齐

        self.MenuLayout.addStretch()  # 占位

    # =====================================================================================================================================================================

    # 初始化所有模块
    def InitTemplateView(self):

        self.ManagerFrameTemplate = ManagerFrameTemplate()
        self.ManagerFrameTemplate.hide()
        self.DataLayout.addWidget(self.ManagerFrameTemplate)

        self.TeacherFrameTemplate = TeacherFrameTemplate()
        self.TeacherFrameTemplate.hide()
        self.DataLayout.addWidget(self.TeacherFrameTemplate)

    # 框架路由
    def TemplateView(self, TemplateName: str):

        if TemplateName == 'ManagerFrameTemplate':
            self.ManagerFrameTemplate.show()
            self.TeacherFrameTemplate.hide()

        if TemplateName == 'TeacherFrameTemplate':
            self.ManagerFrameTemplate.hide()
            self.TeacherFrameTemplate.show()
