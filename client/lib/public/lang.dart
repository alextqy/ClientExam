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

  String className = '';
  String classCode = '';
  String description = '';

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

      this.className = '班级名称';
      this.classCode = '班级编码';
      this.description = '描述';
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

      this.className = 'Class Name';
      this.classCode = 'Class Code';
      this.description = 'description';
    }
  }
}
