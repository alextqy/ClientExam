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

  String personalSettings = '';
  String menu = '';
  String managers = '';
  String teachers = '';

  // String theRequestFailed = '';
  // String loginTokenGenerationFailed = '';
  // String classes = '';
  // String examinee = '';
  // String examRegistrations = '';
  // String oldExamRegistrations = '';
  // String examSubjects = '';
  // String knowledgePoints = '';
  // String headTopics = '';
  // String questions = '';
  // String papers = '';
  // String answerCards = '';
  // String oldAnswerCards = '';
  // String systemLogs = '';
  // String examLogs = '';
  // String exit = '';
  // String systemFunctions = '';
  // String addData = '';
  // String name = '';
  // String creationTime = '';
  // String details = '';
  // String previousPage = '';
  // String nextPage = '';
  // String numberOfItems = '';

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

      this.personalSettings = '个人设置';
      this.menu = '菜单';
      this.managers = '管理员';
      this.teachers = '教师';
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

      this.personalSettings = 'Personal Settings';
      this.menu = 'Menu';
      this.managers = 'Manager';
      this.teachers = 'Teacher';
    }
  }
}
