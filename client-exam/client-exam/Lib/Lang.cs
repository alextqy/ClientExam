namespace client_exam.Lib
{
    public class Lang
    {
        public string Type { get; set; }

        public string IncorrectInput { get; set; }
        public string TheRequestFailed { get; set; }

        public Lang(string Type = "en")
        {
            this.Type = (Type ?? "").ToLower();
            if (!string.IsNullOrEmpty(this.Type))
            {
                if (this.Type == "en")
                {
                    this.IncorrectInput = "Incorrect input";
                    this.TheRequestFailed = "The request failed";
                }
                if (this.Type == "cn")
                {
                    this.IncorrectInput = "输入有误";
                    this.TheRequestFailed = "请求失败";
                }
            }
        }
    }
}
