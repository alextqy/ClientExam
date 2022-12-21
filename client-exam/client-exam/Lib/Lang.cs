namespace client_exam.Lib
{
    public class Lang
    {
        public string Type { get; set; }

        public string PersonalSettings { get; set; }
        public string Manager { get; set; }
        public string Teacher { get; set; }
        public string Error { get; set; }
        public string Close { get; set; }
        public string IncorrectInput { get; set; }
        public string TheRequestFailed { get; set; }
        public string LoginTokenGenerationFailed { get; set; }
        public string Menu { get; set; }
        public string Class { get; set; }
        public string Examinee { get; set; }
        public string ExamRegistration { get; set; }
        public string OldExamRegistration { get; set; }
        public string ExamSubjects { get; set; }
        public string KnowledgePoints { get; set; }
        public string HeadTopics { get; set; }
        public string Questions { get; set; }
        public string Paper { get; set; }
        public string AnswerCards { get; set; }
        public string OldAnswerCards { get; set; }
        public string SystemLogs { get; set; }
        public string ExamLogs { get; set; }
        public string Exit { get; set; }
        public string SystemFunctions { get; set; }
        public string AddData { get; set; }
        public string Account { get; set; }
        public string Name { get; set; }
        public string CreationTime { get; set; }

        public Lang(string Type = "en")
        {
            this.Type = (Type ?? "").ToLower();
            if (!string.IsNullOrEmpty(this.Type))
            {
                if (this.Type == "en")
                {
                    this.PersonalSettings = "Personal Settings";
                    this.Manager = "Manager";
                    this.Teacher = "Teacher";
                    this.Error = "Error";
                    this.Close = "Close";
                    this.IncorrectInput = "Incorrect input";
                    this.TheRequestFailed = "The request failed";
                    this.LoginTokenGenerationFailed = "Login token generation failed";
                    this.Menu = "Menu";
                    this.Class = "Class";
                    this.Examinee = "Examinee";
                    this.ExamRegistration = "Exam Registration";
                    this.OldExamRegistration = "Old Exam Registration";
                    this.ExamSubjects = "Exam Subjects";
                    this.KnowledgePoints = "Knowledge Points";
                    this.HeadTopics = "Head Topics";
                    this.Questions = "Questions";
                    this.Paper = "Paper";
                    this.AnswerCards = "Answer Cards";
                    this.OldAnswerCards = "Old Answer Cards";
                    this.SystemLogs = "System Logs";
                    this.ExamLogs = "Exam Logs";
                    this.Exit = "Exit";
                    this.SystemFunctions = "System Functions";
                    this.AddData = "Add Data";
                    this.Account = "Account";
                    this.Name = "Name";
                    this.CreationTime = "Creation Time";
                }
                if (this.Type == "cn")
                {
                    this.PersonalSettings = "个人设置";
                    this.Manager = "管理员";
                    this.Teacher = "教师";
                    this.Error = "错误";
                    this.Close = "关闭";
                    this.IncorrectInput = "输入有误";
                    this.TheRequestFailed = "请求失败";
                    this.LoginTokenGenerationFailed = "登录令牌生成失败";
                    this.Menu = "菜单";
                    this.Class = "班级";
                    this.Examinee = "考生";
                    this.ExamRegistration = "报名";
                    this.OldExamRegistration = "历史报名";
                    this.ExamSubjects = "考试科目";
                    this.KnowledgePoints = "知识点";
                    this.HeadTopics = "头部主题";
                    this.Questions = "试题";
                    this.Paper = "试卷";
                    this.AnswerCards = "答题卡";
                    this.OldAnswerCards = "历史答题卡";
                    this.SystemLogs = "系统日志";
                    this.ExamLogs = "考试日志";
                    this.Exit = "退出";
                    this.SystemFunctions = "系统功能";
                    this.AddData = "添加数据";
                    this.Account = "账号";
                    this.Name = "名称";
                    this.CreationTime = "创建时间";
                }
            }
        }
    }
}
