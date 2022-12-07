namespace client_exam.Lib
{
    public class Lang
    {
        public string Type { get; set; }

        public string Error { get; set; }
        public string Close { get; set; }
        public string IncorrectInput { get; set; }
        public string TheRequestFailed { get; set; }
        public string LoginTokenGenerationFailed { get; set; }
        public string Menu { get; set; }

        public Lang(string Type = "en")
        {
            this.Type = (Type ?? "").ToLower();
            if (!string.IsNullOrEmpty(this.Type))
            {
                if (this.Type == "en")
                {
                    this.Error = "Error";
                    this.Close = "Close";
                    this.IncorrectInput = "Incorrect input";
                    this.TheRequestFailed = "The request failed";
                    this.LoginTokenGenerationFailed = "Login token generation failed";
                    this.Menu = "Menu";
                }
                if (this.Type == "cn")
                {
                    this.Error = "错误";
                    this.Close = "关闭";
                    this.IncorrectInput = "输入有误";
                    this.TheRequestFailed = "请求失败";
                    this.LoginTokenGenerationFailed = "登录令牌生成失败";
                    this.Menu = "菜单";
                }
            }
        }
    }
}
