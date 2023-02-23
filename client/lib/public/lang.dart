// ignore_for_file: unnecessary_this
class Lang {
  String type = 'en';

  String title = '';
  String confirm = '';
  String cancel = '';
  String administratorLoginEntry = '';
  String teacherLoginPortal = '';
  String login = '';
  String account = '';
  String password = '';
  String incorrectInput = '';
  String submit = '';
  String theRequestFailed = '';
  String loginTokenGenerationFailed = '';
  String getTokenException = '';
  String menu = '';
  String personalSettings = '';
  String managers = '';
  String teachers = '';
  String classes = '';
  String examinee = '';
  String examRegistrations = '';
  String oldExamRegistrations = '';
  String examSubjects = '';
  String knowledgePoints = '';
  String topTitle = '';
  String questions = '';
  String paper = '';
  String answerCards = '';
  String oldAnswerCards = '';
  String examLogs = '';
  String systemLogs = '';
  String exit = '';
  String longPressToExit = '';

  String name = '';
  String thisItemCannotBeModified = '';
  String createtime = '';
  String updateTime = '';
  String theOperationCompletes = '';

  String rowsPerPage = '';
  String all = '';
  String normal = '';
  String disable = '';
  String status = '';
  String search = '';
  String longPress = '';
  String loading = '';
  String previous = '';
  String next = '';
  String jumpTo = '';
  String setUp = '';

  String className = '';
  String classCode = '';
  String description = '';

  String examineeNo = '';
  String contact = '';
  String notSelected = '';

  String examNumber = '';
  String totalScore = '';
  String passingLine = '';
  String examDuration = '';
  String startTime = '';
  String endTime = '';
  String actualScore = '';
  String actualDuration = '';
  String examType = '';
  String examStatus = '';
  String passedOrNot = '';
  String suspendStatus = '';
  String startState = '';
  String yes = '';
  String no = '';
  String noAnswerCards = '';
  String notExamined = '';
  String examined = '';
  String examVoided = '';
  String dailyPractice = '';
  String officialExams = '';
  String started = '';
  String notStarted = '';
  String noData = '';
  String generateQuizPaperData = '';
  String clearData = '';
  String voidTheData = '';
  String generateTheEncoding = '';
  String grade = '';
  String sendToOldData = '';

  String subjectName = '';
  String subjectCode = '';

  String knowledgePointName = '';
  String knowledgePointcode = '';

  String headlines = '';
  String content = '';
  String contentCode = '';

  String bulkImport = '';
  String wrongFileType = '';
  String theFileIsTooLarge = '';

  String questionTitle = '';
  String questionCode = '';
  String language = '';
  String languageVersion = '';
  String attachmentFile = '';
  String questionType = '';
  String multipleChoiceQuestions = '';
  String judgmentQuestions = '';
  String multipleSelection = '';
  String fillInTheBlanks = '';
  String quizQuestions = '';
  String codeTesting = '';
  String drag = '';
  String connection = '';
  String view = '';
  String upload = '';
  String questionOptions = '';
  String check = '';

  Lang({type = 'en', title = 'Bit Exam'}) {
    if (this.type == 'cn') {
      this.title = title;
      this.confirm = '确认';
      this.cancel = '取消';
      this.administratorLoginEntry = '管理员登录入口';
      this.teacherLoginPortal = '教师登录入口';
      this.login = '登录';
      this.account = '账号';
      this.password = '密码';
      this.incorrectInput = '输入有误';
      this.submit = '提交';
      this.theRequestFailed = '请求失败';
      this.loginTokenGenerationFailed = '登录令牌生成失败';
      this.getTokenException = '获取令牌异常';
      this.menu = '菜单';
      this.personalSettings = '个人设置';
      this.managers = '管理员';
      this.teachers = '教师';
      this.classes = '班级';
      this.examinee = '考生';
      this.examRegistrations = '报名';
      this.oldExamRegistrations = '历史报名';
      this.examSubjects = '科目';
      this.knowledgePoints = '知识点';
      this.topTitle = '顶部标题';
      this.questions = '试题';
      this.paper = '试卷';
      this.answerCards = '答题卡';
      this.oldAnswerCards = '历史答题卡';
      this.examLogs = '考试日志';
      this.systemLogs = '系统日志';
      this.exit = '退出';
      this.longPressToExit = '长按退出';

      this.name = '称呼';
      this.thisItemCannotBeModified = '该项不能被修改';
      this.createtime = '创建时间';
      this.updateTime = '更新时间';
      this.theOperationCompletes = '操作完成';
      this.rowsPerPage = '每页数据量';
      this.all = '全部';
      this.normal = '正常';
      this.disable = '禁用';
      this.status = '状态';
      this.search = '搜索';
      this.longPress = '长按';
      this.loading = '加载中';
      this.previous = '上一页';
      this.next = '下一页';
      this.jumpTo = '跳转';
      this.setUp = '设置';

      this.className = '班级名称';
      this.classCode = '班级编码';
      this.description = '描述';

      this.examineeNo = '学生编号';
      this.contact = '联系方式';
      this.notSelected = '未选择';

      this.examNumber = '准考证号';
      this.totalScore = '总分';
      this.passingLine = '及格线';
      this.examDuration = '考试时长';
      this.startTime = '开始时间';
      this.endTime = '结束时间';
      this.actualScore = '实际得分';
      this.actualDuration = '实际时长';
      this.examType = '考试类型';
      this.examStatus = '考试状态';
      this.passedOrNot = '通过状态';
      this.suspendStatus = '暂停状态';
      this.startState = '开始状态';
      this.yes = '是';
      this.no = '否';
      this.noAnswerCards = '无答题卡';
      this.notExamined = '未考试';
      this.examined = '已考试';
      this.examVoided = '考试作废';
      this.dailyPractice = '日常练习';
      this.officialExams = '正式考试';
      this.started = '已开始';
      this.notStarted = '未开始';
      this.noData = '无数据';
      this.generateQuizPaperData = '生成试卷数据';
      this.clearData = '清除数据';
      this.voidTheData = '数据作废';
      this.generateTheEncoding = '生成编码';
      this.grade = '打分';
      this.sendToOldData = '设置为历史数据';

      this.subjectName = '科目名称';
      this.subjectCode = '科目代码';

      this.knowledgePointName = '知识点名称';
      this.knowledgePointcode = '知识点编码';

      this.headlines = '大标题';
      this.content = '内容';
      this.contentCode = '内容编码';

      this.bulkImport = '批量导入';
      this.wrongFileType = '文件类型错误';
      this.theFileIsTooLarge = '文件过大';

      this.questionTitle = '试题题目';
      this.questionCode = '试题编码';
      this.language = '语言';
      this.languageVersion = '语言版本';
      this.attachmentFile = '附件';
      this.questionType = '试题类型';
      this.multipleChoiceQuestions = '单选题';
      this.judgmentQuestions = '判断题';
      this.multipleSelection = '多选题';
      this.fillInTheBlanks = '填空题';
      this.quizQuestions = '问答题';
      this.codeTesting = '代码测试';
      this.drag = '拖拽';
      this.connection = '连线';
      this.view = '查看';
      this.upload = '上传';
      this.questionOptions = '试题选项';
      this.check = '详情';
    } else {
      this.title = title;
      this.confirm = 'Confirm';
      this.cancel = 'Cancel';
      this.administratorLoginEntry = 'Administrator Login Entry';
      this.teacherLoginPortal = 'Teacher Login Portal';
      this.login = 'Login';
      this.account = 'Account';
      this.password = 'Password';
      this.incorrectInput = 'Incorrect Input';
      this.submit = 'Submit';
      this.theRequestFailed = 'The Request Failed';
      this.loginTokenGenerationFailed = 'Login Token Generation Failed';
      this.getTokenException = 'Get Token Exception';
      this.menu = 'Menu';
      this.personalSettings = 'Personal Settings';
      this.managers = 'Manager';
      this.teachers = 'Teacher';
      this.classes = 'Classes';
      this.examinee = 'Examinee';
      this.examRegistrations = 'Exam Registrations';
      this.oldExamRegistrations = 'Old Exam Registrations';
      this.examSubjects = 'Exam Subjects';
      this.knowledgePoints = 'Knowledge Points';
      this.topTitle = 'Top Title';
      this.questions = 'Questions';
      this.paper = 'Paper';
      this.answerCards = 'Answer Cards';
      this.oldAnswerCards = 'Old Answer Cards';
      this.examLogs = 'Exam Logs';
      this.systemLogs = 'System Logs';
      this.exit = 'Exit';
      this.longPressToExit = 'Long Press To Exit';

      this.name = 'Name';
      this.thisItemCannotBeModified = 'This Item Cannot Be Modified';
      this.createtime = 'Createtime';
      this.updateTime = 'UpdateTime';
      this.theOperationCompletes = 'Completed';
      this.rowsPerPage = 'Rows Per Page';
      this.all = 'All';
      this.normal = 'normal';
      this.disable = 'disable';
      this.status = 'status';
      this.search = 'Search';
      this.longPress = 'Long Press';
      this.loading = 'Loading';
      this.previous = 'Previous';
      this.next = 'Next';
      this.jumpTo = 'Jump to';
      this.setUp = 'Set up';

      this.className = 'Class Name';
      this.classCode = 'Class Code';
      this.description = 'Description';

      this.examineeNo = 'Examinee No';
      this.contact = 'Contact';
      this.notSelected = 'Not Selected';

      this.examNumber = 'Exam Number';
      this.totalScore = 'Total Score';
      this.passingLine = 'Passing Line';
      this.examDuration = 'Exam Duration';
      this.startTime = 'Start Time';
      this.endTime = 'End Time';
      this.actualScore = 'Actual Score';
      this.actualDuration = 'Actual Duration';
      this.examType = 'Exam Type';
      this.examStatus = 'Exam Status';
      this.passedOrNot = 'Passed Or Not';
      this.suspendStatus = 'Suspend Status';
      this.startState = 'Start State';
      this.yes = 'Yes';
      this.no = 'No';
      this.noAnswerCards = 'No Answer Cards';
      this.notExamined = 'Not Examined';
      this.examined = 'Examined';
      this.examVoided = 'Exam Voided';
      this.dailyPractice = 'Daily Practice';
      this.officialExams = 'Official Exams';
      this.started = 'Started';
      this.notStarted = 'Not Started';
      this.noData = 'No Data';
      this.generateQuizPaperData = 'Generate Quiz Paper Data';
      this.clearData = 'Clear Data';
      this.voidTheData = 'Void The Data';
      this.generateTheEncoding = 'Generate The Encoding';
      this.grade = 'Grade';
      this.sendToOldData = 'Send To Old Data';

      this.subjectName = 'Subject Name';
      this.subjectCode = 'Subject Code';

      this.knowledgePointName = 'Knowledge Point Name';
      this.knowledgePointcode = 'Knowledge Point Code';

      this.headlines = 'Headlines';
      this.content = 'Content';
      this.contentCode = 'Content Code';

      this.bulkImport = 'Bulk Import';
      this.wrongFileType = 'Wrong File Type';
      this.theFileIsTooLarge = 'The File Is Too Large';

      this.questionTitle = 'Question Title';
      this.questionCode = 'Question Code';
      this.language = 'Language';
      this.languageVersion = 'Language Version';
      this.attachmentFile = 'Attachment File';
      this.questionType = 'Question Type';
      this.multipleChoiceQuestions = 'Multiple Choice Questions';
      this.judgmentQuestions = 'Judgment Questions';
      this.multipleSelection = 'Multiple Selection';
      this.fillInTheBlanks = 'Fill In The Blanks';
      this.quizQuestions = 'Quiz Questions';
      this.codeTesting = 'Code Testing';
      this.drag = 'Drag';
      this.connection = 'Connection';
      this.view = 'View';
      this.upload = 'Upload';
      this.questionOptions = 'Question Options';
      this.check = 'check';
    }
  }
}
