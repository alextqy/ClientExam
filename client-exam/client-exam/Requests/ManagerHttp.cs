using client_exam.Lib;

namespace client_exam.Requests
{
    public class ManagerHttp : HttpHelper
    {
        public string Test()
        {
            Dictionary<string, string> Data = new()
            {
                ["Param1"] = "123",
                ["Param2"] = "456",
                ["Param3"] = "789"
            };
            return this.Get("/Test", Data);
        }

        public string ManagerSignIn(string Account, string Password)
        {
            MultipartFormDataContent FormDataContent = new()
            {
                { new StringContent(Account), "Account" },
                { new StringContent(Password), "Password" }
            };
            return this.Post("/Manager/Sign/In", FormDataContent);
        }

    }
}
