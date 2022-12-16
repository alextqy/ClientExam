using client_exam.Lib;
using System.Xml.Linq;

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

        public Result ManagerSignIn(
            string Account,
            string Password
        )
        {
            MultipartFormDataContent FormDataContent = new()
            {
                { new StringContent(Account), "Account" },
                { new StringContent(Password), "Password" }
            };
            return JsonSerializer.Deserialize<Result>(this.Post("/Manager/Sign/In", FormDataContent));
        }

        public Result ManagerSignOut(string Token)
        {
            MultipartFormDataContent FormDataContent = new()
            {
                { new StringContent(Token), "Token" }
            };
            return JsonSerializer.Deserialize<Result>(this.Post("/Manager/Sign/Out", FormDataContent));
        }

        public Result NewManager(
            string Token,
            string Account,
            string Password,
            string Name
        )
        {
            MultipartFormDataContent FormDataContent = new()
            {
                { new StringContent(Token), "Token" },
                { new StringContent(Account), "Account" },
                { new StringContent(Password), "Password" },
                { new StringContent(Name), "Name" }
            };
            return JsonSerializer.Deserialize<Result>(this.Post("/New/Manager", FormDataContent));
        }

        public Result ManagerDisabled(
            string Token,
            string ID
        )
        {
            MultipartFormDataContent FormDataContent = new()
            {
                { new StringContent(Token), "Token" },
                { new StringContent(ID), "ID" }
            };
            return JsonSerializer.Deserialize<Result>(this.Post("/Manager/Disabled", FormDataContent));
        }
    }
}
