using System.Net.Http.Headers;
using System.Text;

namespace client_exam.Lib
{
    public class HttpHelper
    {
        public int TimeOut = 10000;
        public string URL = "http://127.0.0.1:6001";

        public HttpHelper() { }

        public string Post(string DestURL, MultipartFormDataContent FormDataContent)
        {
            HttpClient Client = new(new HttpClientHandler());
            Client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("text/html"));
            Client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/xhtml+xml"));
            Client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/xml", 0.9));
            Client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("image/webp"));
            Client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("*/*", 0.8));

            FormDataContent.Headers.Add("ContentType", $"multipart/form-data, boundary={string.Format("--{0}", DateTime.Now.Ticks.ToString("x"))}");
            FormDataContent.Headers.Add("UserAgent", "Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/31.0.1650.57 Safari/537.36");
            FormDataContent.Headers.Add("Timeout", this.TimeOut.ToString());
            FormDataContent.Headers.Add("KeepAlive", "true");

            var CallBack = Client.PostAsync(this.URL + DestURL, FormDataContent);
            CallBack.Wait();
            return Encoding.UTF8.GetString(CallBack.Result.Content.ReadAsByteArrayAsync().Result);
        }

        public string Get(string DestURL, Dictionary<string, string> FormData)
        {
            HttpClient Client = new(new HttpClientHandler());
            var Data = Client.GetByteArrayAsync(this.URL + DestURL + "?" + this.GetQueryString(FormData));
            Data.Wait();
            return Encoding.UTF8.GetString(Data.Result);
        }

        /// <summary>
        /// 组装QueryString的方法 参数之间用&连接，首位没有符号，如：a=1&b=2&c=3
        /// </summary>
        /// <param name="FormData"></param>
        /// <returns></returns>
        public string GetQueryString(Dictionary<string, string> FormData)
        {
            if (FormData == null || FormData.Count == 0)
                return "";
            StringBuilder SB = new();
            var i = 0;
            foreach (var kv in FormData)
            {
                i++;
                SB.AppendFormat("{0}={1}", kv.Key, kv.Value);
                if (i < FormData.Count)
                    SB.Append("&");
            }
            return SB.ToString();
        }
    }
}
