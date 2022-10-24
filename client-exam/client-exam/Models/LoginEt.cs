namespace client_exam.Models
{
    public class LoginEt
    {
        public string Account { get; set; }

        public string Password { get; set; }

        public LoginEt()
        {
            this.Account = "";
            this.Password = "";
        }
    }
}
