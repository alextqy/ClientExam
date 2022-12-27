// ignore_for_file: unnecessary_this
class Lang {
  late String type = 'en';

  late String title;
  late String confirm;
  late String cancel;
  late String manager;
  late String teacher;

  Lang({type = 'en', title = 'Bit Exam'}) {
    if (this.type == 'cn') {
      this.title = title;
      this.confirm = '确认';
      this.cancel = '取消';
      this.manager = '管理员';
      this.teacher = '教师';
    } else {
      this.title = title;
      this.confirm = 'Confirm';
      this.cancel = 'Cancel';
      this.manager = 'Manager';
      this.teacher = 'Teacher';
    }
  }
}
