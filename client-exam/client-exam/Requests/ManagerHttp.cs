using client_exam.Lib;
using Microsoft.Maui.Controls.PlatformConfiguration;
using Microsoft.VisualBasic;
using System.Collections.Generic;
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

        public ResultEntity ManagerSignIn(
            string Account,
            string Password
        )
        {
            MultipartFormDataContent FormDataContent = new()
            {
                { new StringContent(Account), "Account" },
                { new StringContent(Password), "Password" }
            };
            return JsonSerializer.Deserialize<ResultEntity>(this.Post("/Manager/Sign/In", FormDataContent));
        }

        public ResultEntity ManagerSignOut(string Token)
        {
            MultipartFormDataContent FormDataContent = new()
            {
                { new StringContent(Token), "Token" }
            };
            return JsonSerializer.Deserialize<ResultEntity>(this.Post("/Manager/Sign/Out", FormDataContent));
        }

        public ResultEntity NewManager(
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
            return JsonSerializer.Deserialize<ResultEntity>(this.Post("/New/Manager", FormDataContent));
        }

        public ResultEntity ManagerDisabled(
            string Token,
            string ID
        )
        {
            MultipartFormDataContent FormDataContent = new()
            {
                { new StringContent(Token), "Token" },
                { new StringContent(ID), "ID" }
            };
            return JsonSerializer.Deserialize<ResultEntity>(this.Post("/Manager/Disabled", FormDataContent));
        }

        public ResultEntity ManagerChangePassword(
            string Token,
            string NewPassword,
            string ID
        )
        {
            MultipartFormDataContent FormDataContent = new()
            {
                { new StringContent(Token), "Token" },
                { new StringContent(NewPassword), "NewPassword" },
                { new StringContent(ID), "ID" }
            };
            return JsonSerializer.Deserialize<ResultEntity>(this.Post("/Manager/Change/Password", FormDataContent));
        }

        public ResultEntity UpdateManagerInfo(
            string Token,
            string Name,
            string ID,
            string Permission = "0"
        )
        {
            MultipartFormDataContent FormDataContent = new()
            {
                { new StringContent(Token), "Token" },
                { new StringContent(Name), "Name" },
                { new StringContent(Permission), "Permission" },
                { new StringContent(ID), "ID" }
            };
            return JsonSerializer.Deserialize<ResultEntity>(this.Post("/Update/Manager/Info", FormDataContent));
        }

        public ResultListEntity ManagerList(
            string Token,
            string Page = "1",
            string PageSize = "10",
            string Stext = "",
            string State = "0",
            string Permission = "0"
        )
        {
            MultipartFormDataContent FormDataContent = new()
            {
                { new StringContent(Token), "Token" },
                { new StringContent(Page), "Page" },
                { new StringContent(PageSize), "PageSize" },
                { new StringContent(Stext), "Stext" },
                { new StringContent(State), "State" },
                { new StringContent(Permission), "Permission" },
            };
            return JsonSerializer.Deserialize<ResultListEntity>(this.Post("/Manager/List", FormDataContent));
        }

        public ResultEntity ManagerInfo(
            string Token,
            string ID
        )
        {
            MultipartFormDataContent FormDataContent = new()
            {
                { new StringContent(Token), "Token" },
                { new StringContent(ID), "ID" },
            };
            return JsonSerializer.Deserialize<ResultEntity>(this.Post("/Manager/Info", FormDataContent));
        }
    }
}
