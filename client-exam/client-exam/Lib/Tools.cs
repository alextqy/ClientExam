using System.Collections;
using System.Diagnostics;
using System.IO.Compression;
using System.Net.Sockets;
using System.Net;
using System.Runtime.InteropServices;
using System.Security.Cryptography;
using System.Text.RegularExpressions;
using System.Text;
using SkiaSharp;
using System.Text.Json.Serialization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Http.Internal;

namespace client_exam.Lib
{
    public class Tools
    {
        /// <summary>
        /// 获取系统类型
        /// </summary>
        /// <returns></returns>
        public static string OSType()
        {
            var OSTypeData = "Unknown";
            if (RuntimeInformation.IsOSPlatform(OSPlatform.Linux))
            {
                OSTypeData = "Linux";
            }
            if (RuntimeInformation.IsOSPlatform(OSPlatform.OSX))
            {
                OSTypeData = "OSX";
            }
            if (RuntimeInformation.IsOSPlatform(OSPlatform.Windows))
            {
                OSTypeData = "Windows";
            }
            return OSTypeData;
        }

        /// <summary>
        /// 执行 1代码 2指令
        /// </summary>
        /// <param name="Command"></param>
        /// <param name="ActionType"></param>
        /// <param name="Args"></param>
        /// <returns></returns>
        public string ShellHelper(string Command, int ActionType, string Args = "")
        {
            if (!String.IsNullOrEmpty(Command) && ActionType == 1)
            {
                if (OSType() == "Windows")
                {
                    Command = Command.Trim().TrimStart('&') + "&exit";//&执行两条命令的标识，这里第二条命令的目的是当调用ReadToEnd()方法是，不会出现假死状态
                    string Output = "";
                    var pro = new Process();
                    pro.StartInfo.FileName = "cmd.exe"; // 调用cmd.exe
                    pro.StartInfo.UseShellExecute = false; // 是否启用shell启动进程
                    pro.StartInfo.RedirectStandardError = true;
                    pro.StartInfo.RedirectStandardInput = true;
                    pro.StartInfo.RedirectStandardOutput = true; // 重定向的设置
                    pro.StartInfo.CreateNoWindow = true; // 不创建窗口
                    pro.Start();
                    pro.StandardInput.WriteLine(Command); // 执行cmd语句
                    pro.StandardInput.AutoFlush = true;
                    Output += pro.StandardOutput.ReadToEnd(); //读取返回信息
                    //outputMsg=outputMsg.Substring(outputMsg.IndexOf(commandLine)+commandLine.Length);//返回发送命令之后的信息
                    pro.WaitForExit(); //等待程序执行完退出，不过感觉不用这条命令，也可以达到同样的效果
                    pro.Close();
                    return Output;
                }
                else if (OSType() == "Linux")
                {
                    var pro = new Process()
                    {
                        StartInfo = new ProcessStartInfo
                        {
                            FileName = Command,
                            Arguments = Args,
                            RedirectStandardOutput = true,
                            RedirectStandardError = true,
                            UseShellExecute = false,
                            CreateNoWindow = true,
                        }
                    };
                    pro.Start();
                    string Output = pro.StandardOutput.ReadToEnd();
                    string Error = pro.StandardError.ReadToEnd();
                    pro.WaitForExit();
                    if (String.IsNullOrEmpty(Error)) { return Output; }
                    else { return Error; }
                }
                else
                {
                    return "";
                }
            }
            else if (ActionType == 2)
            {
                return "";
            }
            else
            {
                return "";
            }
        }

        //获取UUID
        public string GetUUID()
        {
            string UUID = "";
            string file = "";
            string command = "";

            //win式
            if (RuntimeInformation.IsOSPlatform(OSPlatform.Windows))
            {
                file = "powershell";
                command = "(get-wmiobject Win32_ComputerSystemProduct).UUID";
            }

            //linux式
            if (RuntimeInformation.IsOSPlatform(OSPlatform.Linux))
            {
                file = "dmidecode";
                command = " -s system-uuid";
            }

            var psi = new ProcessStartInfo(file, command) { RedirectStandardOutput = true };
            //启动
            var proc = Process.Start(psi);

            if (proc == null)
            {
                Console.WriteLine("Can not exec.");
            }
            else
            {
                var s = "";
                using (var sr = proc.StandardOutput)
                {
                    while (!sr.EndOfStream)
                    {
                        s += sr.ReadLine();
                    }

                    if (!proc.HasExited)
                    {
                        proc.Kill();
                    }
                }
                UUID = s.Replace("-", "").Trim();
            }
            return UUID;
        }

        //获取CPUID
        public string GetCPUID()
        {
            string CPUID = "";
            //win式
            if (RuntimeInformation.IsOSPlatform(OSPlatform.Windows))
            {
                var psi = new ProcessStartInfo("powershell", "wmic cpu get processorid") { RedirectStandardOutput = true };
                //启动
                var proc = Process.Start(psi);
                if (proc == null)
                {
                    Console.WriteLine("Can not exec.");
                }
                else
                {
                    var s = "";
                    using (var sr = proc.StandardOutput)
                    {
                        while (!sr.EndOfStream)
                        {
                            s += sr.ReadLine();
                        }

                        if (!proc.HasExited)
                        {
                            proc.Kill();
                        }
                    }
                    CPUID = s.Replace("ProcessorId", "").Trim();
                }
            }

            //linux式
            if (RuntimeInformation.IsOSPlatform(OSPlatform.Linux))
            {
                string CPU_FILE_PATH = "/proc/cpuinfo";
                var s = File.ReadAllText(CPU_FILE_PATH);
                var lines = s.Split(new[] { '\n' });
                s = string.Empty;

                foreach (var item in lines)
                {
                    if (item.StartsWith("Serial"))
                    {
                        var temp = item.Split(new[] { ':' });
                        s = temp[1].Trim();
                        break;
                    }
                }
                CPUID = s.Trim();
            }
            return CPUID;
        }

        public string DesEncrypt(string input, string key)
        {
            byte[] inputArray = Encoding.UTF8.GetBytes(input);
            var tripleDES = TripleDES.Create();
            var byteKey = Encoding.UTF8.GetBytes(key);
            byte[] allKey = new byte[24];
            Buffer.BlockCopy(byteKey, 0, allKey, 0, 16);
            Buffer.BlockCopy(byteKey, 0, allKey, 16, 8);
            tripleDES.Key = allKey;
            tripleDES.Mode = CipherMode.ECB;
            tripleDES.Padding = PaddingMode.PKCS7;
            ICryptoTransform cTransform = tripleDES.CreateEncryptor();
            byte[] resultArray = cTransform.TransformFinalBlock(inputArray, 0, inputArray.Length);
            return Convert.ToBase64String(resultArray, 0, resultArray.Length);
        }

        public string DesDecrypt(string input, string key)
        {
            byte[] inputArray = Convert.FromBase64String(input);
            var tripleDES = TripleDES.Create();
            var byteKey = Encoding.UTF8.GetBytes(key);
            byte[] allKey = new byte[24];
            Buffer.BlockCopy(byteKey, 0, allKey, 0, 16);
            Buffer.BlockCopy(byteKey, 0, allKey, 16, 8);
            tripleDES.Key = byteKey;
            tripleDES.Mode = CipherMode.ECB;
            tripleDES.Padding = PaddingMode.PKCS7;
            ICryptoTransform cTransform = tripleDES.CreateDecryptor();
            byte[] resultArray = cTransform.TransformFinalBlock(inputArray, 0, inputArray.Length);
            return Encoding.UTF8.GetString(resultArray);
        }

        public string EncryptAES(string text, string key = "d89fb057f6d4f03g", string iv = "e9c8e878ee8e2658")
        {
            var sourceBytes = Encoding.UTF8.GetBytes(text);
            var aes = Aes.Create();
            aes.Mode = CipherMode.CBC;
            aes.Padding = PaddingMode.PKCS7;
            aes.Key = Encoding.UTF8.GetBytes(key);
            aes.IV = Encoding.UTF8.GetBytes(iv);
            var transform = aes.CreateEncryptor();
            return Convert.ToBase64String(transform.TransformFinalBlock(sourceBytes, 0, sourceBytes.Length));
        }

        public string DecryptAES(string text, string key = "d89fb057f6d4f03g", string iv = "e9c8e878ee8e2658")
        {
            var encryptBytes = Convert.FromBase64String(text);
            var aes = Aes.Create();
            aes.Mode = CipherMode.CBC;
            aes.Padding = PaddingMode.PKCS7;
            aes.Key = Encoding.UTF8.GetBytes(key);
            aes.IV = Encoding.UTF8.GetBytes(iv);
            var transform = aes.CreateDecryptor();
            return Encoding.UTF8.GetString(transform.TransformFinalBlock(encryptBytes, 0, encryptBytes.Length));
        }

        //时间戳转DateTime
        public DateTime TimeStampToDateTime(long ActTime)
        {
            DateTime dtStart = TimeZoneInfo.ConvertTimeFromUtc(new DateTime(1970, 1, 1, 0, 0, 0), TimeZoneInfo.Local);
            TimeSpan toNow = new(ActTime);
            DateTime targetDt = dtStart.Add(toNow);
            return targetDt;
        }

        public long DateTimeToTimeStamp(DateTime DT)
        {
            DateTime dt1970 = new(1970, 1, 1, 0, 0, 0, 0);
            return (DT.Ticks - dt1970.Ticks) / 10000000;
        }

        //获取时间戳
        public string GetTimeStampStr()
        {
            TimeSpan ts = DateTime.UtcNow - new DateTime(1970, 1, 1, 0, 0, 0, 0);
            return Convert.ToInt64(ts.TotalSeconds).ToString();
        }

        //获取时间戳
        public long GetTimeStamp()
        {
            TimeSpan ts = DateTime.UtcNow - new DateTime(1970, 1, 1, 0, 0, 0, 0);
            return Convert.ToInt64(ts.TotalSeconds);
        }

        //获取N年后的时间戳
        public long GetTimeStampYear(string ActTime, int Year)
        {
            var Time = Convert.ToDateTime(ActTime).AddYears(Year);
            //var Time = DateTime.Now.AddYears(Year);
            return StrToTimeStamp(Time.ToString("yyyy-MM-dd HH:mm:ss"));
        }

        //获取N天后的时间戳
        public long GetTimeStampDay(string ActTime, int Day)
        {
            var Time = Convert.ToDateTime(ActTime).AddDays(Day);
            //var Time = DateTime.Now.AddYears(Year);
            return StrToTimeStamp(Time.ToString("yyyy-MM-dd HH:mm:ss"));
        }

        //时间戳转日期
        public string FormatTime(long time)
        {
            //long unixTimeStamp = Convert.ToInt64(time) * 1000;
            long unixTimeStamp = time * 1000;
            DateTime start = new(1970, 1, 1, 0, 0, 0, DateTimeKind.Utc);
            DateTime date = start.AddMilliseconds(unixTimeStamp).ToLocalTime();
            return date.ToString("yyyy-MM-dd HH:mm:ss");
        }

        //字符串转时间戳
        public long StrToTimeStamp(string Dtime)
        {
            if (!string.IsNullOrEmpty(Dtime))
            {
                DateTime DTime = DateTime.Parse(Dtime.Trim());
                DateTimeOffset dto = new(DTime);
                return dto.ToUnixTimeSeconds();
            }
            else
            {
                return 0;
            }
        }

        /// <summary>
        /// 获取当前年份
        /// </summary>
        /// <returns></returns>
        public string NowYear()
        {
            return DateTime.Now.Year.ToString();
        }

        /// <summary>
        /// 获取当前月份
        /// </summary>
        /// <returns></returns>
        public string NowMonth()
        {
            return DateTime.Now.Month.ToString().PadLeft(2, '0');
        }

        /// <summary>
        /// 获取当前日期
        /// </summary>
        /// <returns></returns>
        public string NowDay()
        {
            return DateTime.Now.Day.ToString().PadLeft(2, '0');
        }

        //是否是日期
        public bool IsDate(string TestStr)
        {
            try
            {
                DateTime.Parse(TestStr);
                return true;
            }
            catch
            {
                return false;
            }
        }

        //是否是英文字符串
        public bool IsStr(string TestStr)
        {
            Match mInfo = Regex.Match(TestStr, @"^[A-Za-z]+$");
            if (mInfo.Success)
            {
                return true;
            }
            else
            {
                return false;
            }
        }

        //是否是字符串
        public bool IsChar(string TestStr)
        {
            Match mInfo = Regex.Match(TestStr, @"^[a-zA-Z0-9]+$");
            if (mInfo.Success)
            {
                return true;
            }
            else
            {
                return false;
            }
        }

        //是否是数字 
        public bool IsNum(string TestStr)
        {
            Match mInfo = Regex.Match(TestStr, @"^[0-9]+$");
            if (mInfo.Success)
            {
                return true;
            }
            else
            {
                return false;
            }
        }

        //密码强度判定
        public bool ChkPassWord(string TestStr)
        {
            bool result = false;
            int score = 0;

            Regex rex1 = new(@"^[A-Z]{1}");
            Regex rex2 = new(@"[a-z]{1}");
            Regex rex3 = new(@"[0-9]{2}");

            if (rex3.IsMatch(TestStr))
            {
                score += 1;
            }

            if (rex2.IsMatch(TestStr))
            {
                score += 1;
            }

            if (rex1.IsMatch(TestStr))
            {
                score += 1;
            }

            if (score >= 2)
            {
                result = true;
            }

            return result;
        }

        //邮箱检测
        public bool ChkMail(string mail)
        {
            bool result = false;
            Regex r = new("^\\s*([A-Za-z0-9_-]+(\\.\\w+)*@(\\w+\\.)+\\w{2,5})\\s*$");

            if (r.IsMatch(mail))
            {
                result = true;
            }

            return result;
        }

        ///<summary>
        ///生成随机字符串 
        ///</summary>
        ///<param name="length">目标字符串的长度</param>
        ///<param name="useNum">是否包含数字，1=包含，默认为包含</param>
        ///<param name="useLow">是否包含小写字母，1=包含，默认为包含</param>
        ///<param name="useUpp">是否包含大写字母，1=包含，默认为包含</param>
        ///<param name="useSpe">是否包含特殊字符，1=包含，默认为不包含</param>
        ///<param name="custom">要包含的自定义字符，直接输入要包含的字符列表</param>
        ///<returns>指定长度的随机字符串</returns>
        public string RandomString(int length, bool useNum = true, bool useLow = true, bool useUpp = false, bool useSpe = false, string? custom = null)
        {
            byte[] b = new byte[4];
            var Ran = RandomNumberGenerator.Create();
            Ran.GetBytes(b);
            Random r = new(BitConverter.ToInt32(b, 0));
            string? s = null, str = custom;

            if (useNum == true)
            {
                str += "0123456789";
            }

            if (useLow == true)
            {
                str += "abcdefghijklmnopqrstuvwxyz";
            }

            if (useUpp == true)
            {
                str += "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
            }

            if (useSpe == true)
            {
                str += "!\"#$%&'()*+,-./:;<=>?@[\\]^_`{|}~";
            }

            for (int i = 0; i < length; i++)
            {
                if (str != null)
                {
                    s += str.Substring(r.Next(0, str.Length - 1), 1);
                }
            }

            if (s != null)
            {
                return s;
            }
            else
            {
                return "";
            }
        }

        //md5
        public string GetMD5(string encypStr)
        {
            try
            {
                MD5 md5 = MD5.Create();
                byte[] emailBytes = Encoding.UTF8.GetBytes(encypStr.ToLower());
                byte[] hashedEmailBytes = md5.ComputeHash(emailBytes);
                StringBuilder sb = new();
                foreach (var b in hashedEmailBytes)
                {
                    sb.Append(b.ToString("x2").ToLower());
                }
                encypStr = sb.ToString();
            }
            catch (Exception e)
            {
                Console.WriteLine(e.Message);
            }

            return encypStr;
        }

        /// <summary>
        /// 文件转换成Base64字符串
        /// </summary>
        /// <param name="fs">文件流</param>
        /// <returns></returns>
        public String FileToBase64(string fileName)
        {
            string? strRet;

            try
            {
                FileStream fs = new(fileName, FileMode.Open);
                byte[] bt = new byte[fs.Length];
                fs.Read(bt, 0, bt.Length);
                strRet = Convert.ToBase64String(bt);
                fs.Close();
            }
            catch (Exception e)
            {
                Console.WriteLine(e.Message);
                return "";
            }

            return strRet;
        }

        //base64压缩
        public string Base64Encode(string TestStr)
        {
            byte[] bytes = Encoding.Default.GetBytes(TestStr);
            return Convert.ToBase64String(bytes);
        }

        //base64还原
        public string Base64Decode(string TestStr)
        {
            byte[] outputb = Convert.FromBase64String(TestStr);
            return Encoding.Default.GetString(outputb);
        }

        //列举目录
        public ArrayList ListDirectory(string path)
        {
            ArrayList list = new();
            DirectoryInfo theFolder = new(@path);

            //遍历文件
            foreach (FileInfo NextFile in theFolder.GetFiles())
            {
                list.Add(path + NextFile.Name);
            }
            return list;
        }

        //清空文件
        public void ClearFile(string FilePath)
        {
            FileStream stream = File.Open(FilePath, FileMode.OpenOrCreate, FileAccess.Write);
            stream.Seek(0, SeekOrigin.Begin);
            stream.SetLength(0);
            stream.Close();
        }

        //读文件
        public string ReadFile(string path)
        {
            return File.ReadAllText(path);
        }

        //写文件
        public void WriteFile(string path, string text)
        {
            File.WriteAllText(@path, text, Encoding.UTF8);
        }

        //utf8写入
        public bool WriteFileInUTF8(string FIlePath, string Content)
        {
            try
            {
                File.WriteAllText(FIlePath, Content, new UTF8Encoding(false));
                return true;
            }
            catch (Exception e)
            {
                Console.WriteLine(e.Message);
                return false;
            }
        }

        // 新建文件
        public bool MKFile(string Path, string FileName)
        {
            Path = Path.Replace(@"\\", "/");
            string FilePath = Path + "/" + FileName;
            if (!File.Exists(FilePath))
            {
                try
                {
                    StreamWriter FC = File.CreateText(FilePath);
                    FC.Close();
                    return true;
                }
                catch (Exception e)
                {
                    Console.WriteLine(e.Message);
                    return false;
                }
            }
            else
            {
                return true;
            }
        }

        public bool CreateFile(string FilePath)
        {
            FilePath = FilePath.Replace(@"\\", "/");
            if (!File.Exists(FilePath))
            {
                try
                {
                    StreamWriter FC = File.CreateText(FilePath);
                    FC.Close();
                    return true;
                }
                catch (Exception e)
                {
                    Console.WriteLine(e.Message);
                    return false;
                }
            }
            else
            {
                return true;
            }
        }

        // 上传到外网
        public IFormFile ToFormFileUpload(string FilePath)
        {
            using var FStream = new FileStream(FilePath, FileMode.Open);
            var MStream = new MemoryStream();
            FStream.CopyTo(MStream);
            return new FormFile(MStream, 0, MStream.Length, "", FStream.Name)
            {
                Headers = new HeaderDictionary(),
                ContentType = "application/" + Path.GetExtension(FilePath),
            };
        }

        // 上传到服务器处理
        public IFormFile ToFormFileAnalysis(string FilePath)
        {
            var FileBytes = File.ReadAllBytes(FilePath);
            var FileMS = new MemoryStream(FileBytes) { Position = 0 };
            IFormFile _FormFile = new FormFile(FileMS, 0, FileMS.Length, Path.GetFileNameWithoutExtension(FilePath), Path.GetFileName(FilePath));
            return _FormFile;
        }

        //建立目录
        public bool Mkdir(string path)
        {
            if (!Directory.Exists(path))
            {
                Directory.CreateDirectory(path);
                if (!Directory.Exists(path))
                {
                    return false;
                }
                else
                {
                    return true;
                }
            }
            else
            {
                return true;
            }
        }

        public int DivRem(int a, int b, out int result)
        {
            result = a % b;
            return (a / b);
        }

        public bool DelDir(string DirPath, bool DelAll = false)
        {
            if (Directory.Exists(DirPath))
            {
                try
                {
                    Directory.Delete(DirPath, DelAll);
                    return true;
                }
                catch (Exception e)
                {
                    Console.WriteLine(e.Message);
                    return false;
                }
            }
            else
            {
                return true;
            }
        }

        //身份证验证
        public bool CheckIDCard(string Id)
        {
            if (long.TryParse(Id.Remove(17), out long n) == false || n < Math.Pow(10, 16) || long.TryParse(Id.Replace('x', '0').Replace('X', '0'), out n) == false)
            {
                return false;//数字验证
            }

            string address = "11x22x35x44x53x12x23x36x45x54x13x31x37x46x61x14x32x41x50x62x15x33x42x51x63x21x34x43x52x64x65x71x81x82x91";

            if (address.IndexOf(Id.Remove(2)) == -1)
            {
                return false;//省份验证
            }

            string birth = Id.Substring(6, 8).Insert(6, "-").Insert(4, "-");

            DateTime time = new DateTime();

            if (DateTime.TryParse(birth, out time) == false)
            {
                return false;//生日验证
            }

            string[] arrVarifyCode = ("1,0,x,9,8,7,6,5,4,3,2").Split(',');
            string[] Wi = ("7,9,10,5,8,4,2,1,6,3,7,9,10,5,8,4,2").Split(',');
            char[] Ai = Id.Remove(17).ToCharArray();

            int sum = 0;

            for (int i = 0; i < 17; i++)
            {
                sum += int.Parse(Wi[i]) * int.Parse(Ai[i].ToString());
            }

            DivRem(sum, 11, out int y);

            if (arrVarifyCode[y] != Id.Substring(17, 1).ToLower())
            {
                return false;//校验码验证
            }

            return true;//符合GB11643-1999标准
        }

        //获取年龄
        public int GetAge(string m_Str)
        {
            int m_Y1 = DateTime.Parse(m_Str).Year;
            int m_Y2 = DateTime.Now.Year;
            int m_Age = m_Y2 - m_Y1;
            return m_Age;
        }

        /// <summary>
        /// 指定Url地址使用Get方式获取全部字符串
        /// </summary>
        /// <param name="url">请求链接地址</param>
        /// <param name="referer">请求来源url</param>
        /// <param name="Method">请求方式 1 get 2 post</param>
        /// <param name="param">参数</param>
        /// <returns></returns>
        //public string GetPost(string url, string referer = "", int Method = 1, string param = "")
        //{
        //    string result = "";
        //    HttpWebRequest req = (HttpWebRequest)WebRequest.Create(url);

        //    if (Method == 1)
        //    {
        //        req.Method = "GET";
        //    }
        //    else if (Method == 2)
        //    {
        //        req.Method = "POST";
        //        req.ContentType = "application/x-www-form-urlencoded";
        //    }

        //    req.Headers["Accept-Language"] = "zh-CN,zh;q=0.8";

        //    if (referer != "")
        //    {
        //        req.Referer = referer;
        //    }

        //    if (param != "")
        //    {
        //        byte[] bs = Encoding.ASCII.GetBytes(param);
        //        req.ContentLength = bs.Length;
        //        using (Stream reqStream = req.GetRequestStream())
        //        {
        //            reqStream.Write(bs, 0, bs.Length);
        //            reqStream.Close();
        //        }
        //    }

        //    HttpWebResponse resp = (HttpWebResponse)req.GetResponse();
        //    Stream stream = resp.GetResponseStream();
        //    try
        //    {
        //        //获取内容
        //        using (StreamReader reader = new StreamReader(stream, Encoding.Default))
        //        {
        //            result = reader.ReadToEnd();
        //        }
        //    }
        //    finally
        //    {
        //        stream.Close();
        //    }
        //    return result;
        //}

        //public string PostDic(string url, Dictionary<string, string> dic)
        //{
        //    string result = "";
        //    HttpWebRequest req = (HttpWebRequest)WebRequest.Create(url);
        //    req.Method = "POST";
        //    req.ContentType = "application/x-www-form-urlencoded";
        //    StringBuilder builder = new StringBuilder();
        //    int i = 0;
        //    foreach (var item in dic)
        //    {
        //        if (i > 0)
        //            builder.Append("&");
        //        builder.AppendFormat("{0}={1}", item.Key, item.Value);
        //        i++;
        //    }
        //    byte[] data = Encoding.UTF8.GetBytes(builder.ToString());
        //    req.ContentLength = data.Length;
        //    using (Stream reqStream = req.GetRequestStream())
        //    {
        //        reqStream.Write(data, 0, data.Length);
        //        reqStream.Close();
        //    }
        //    HttpWebResponse resp = (HttpWebResponse)req.GetResponse();
        //    Stream stream = resp.GetResponseStream();
        //    //获取响应内容
        //    using (StreamReader reader = new StreamReader(stream, Encoding.UTF8))
        //    {
        //        result = reader.ReadToEnd();
        //    }
        //    return result;
        //}

        /// <summary>
        /// 文件上传
        /// </summary>
        /// <param name="UploadFile">上传的文件实体</param>
        /// <param name="SizeLimit">文件尺寸限制</param>
        /// <param name="ExtentionLimit">文件后缀限制</param>
        /// <param name="SavePath">保存路径</param>
        /// <param name="NewFileName">新的文件名</param>
        /// <param name="IsSave">是否保存</param>
        /// <param name="IsContent">是否回显正文</param>
        /// <param name="IsUpload">是否上传云盘</param>
        /// <returns></returns>

        /*
        public UploadEt Upload(IFormFile UploadFile, string SizeLimit = "", string ExtentionLimit = "", string SavePath = "", string NewFileName = "", bool IsSave = false, bool IsContent = false, bool IsUpload = false)
        {
            var Result = new UploadEt();
            try
            {
                Result.FileSize = UploadFile.Length;
            }
            catch (Exception e)
            {
                Console.WriteLine(e.Message);
                Result.Memo = "检测文件大小异常";
                return Result;
            }
            int DefaultSize;
            if (!String.IsNullOrEmpty(SizeLimit))
            {
                DefaultSize = Convert.ToInt32(SizeLimit.Trim()[0..^1]);
            }
            else
            {
                DefaultSize = 524288000; // 默认500M
            }
            if (Result.FileSize > DefaultSize)
            {
                Console.WriteLine(Result.FileSize);
                Console.WriteLine(DefaultSize);
                Result.Memo = "超出上传大小限制" + SizeLimit;
                return Result;
            }

            var FileName = UploadFile.FileName;
            Result.ContentType = UploadFile.ContentType;
            Result.FileExtention = Path.GetExtension(UploadFile.FileName).ToLower().Replace(".", "");
            if (NewFileName != "")
            {
                Result.FileName = NewFileName + "." + Result.FileExtention;
            }
            else
            {
                Result.FileName = FileName;
            }
            Result.FileWidth = 0;
            Result.FileHeight = 0;
            if (SavePath != "")
            {
                //如果开头带wwwroot，去掉
                if (SavePath.Length > 6)
                {
                    if (SavePath.Substring(0, 6).ToLower() == "Upload")
                    {
                        SavePath = SavePath.Substring(6, SavePath.Length - 6);
                    }
                    else if (SavePath.Substring(0, 7).ToLower() == "/Upload")
                    {
                        SavePath = SavePath.Substring(7, SavePath.Length - 7);
                    }
                }
                if (SavePath.Substring(SavePath.Length - 1, 1) != "/")
                {
                    SavePath += "/";
                }
                //如果最后一位是/哪么去掉
                if (SavePath[..1] == "/")
                {
                    SavePath = SavePath[1..];
                }
            }
            string TargetDirect = Directory.GetCurrentDirectory() + "/Upload/" + SavePath;

            //当尺寸限制不为空
            // if (SizeLimit.Trim() != "")
            // {
            //     //截取限制单位
            //     string SizeLimitUnit = SizeLimit.Substring(SizeLimit.Length - 1, 1).ToUpper();
            //     //截取限制值
            //     long SizeLimitNum = Convert.ToInt32(SizeLimit[0..^1]);

            //     switch (SizeLimitUnit)
            //     {
            //         case "K":
            //             SizeLimitNum *= 1024;
            //             break;
            //         case "M":
            //             SizeLimitNum = SizeLimitNum * 1024 * 1024;
            //             break;
            //         default:
            //             Result.Memo = "文件尺寸限制单位异常";
            //             return Result;
            //     }

            //     if (Result.FileSize > SizeLimitNum)
            //     {
            //         Result.Memo = "超出上传限制" + SizeLimit + "，现文件已有 " + Result.FileSize.ToString() + " 字节";
            //         return Result;
            //     }
            // }

            //当后缀有限制时
            if (ExtentionLimit.Trim() != "")
            {
                var Extenion = ExtentionLimit.ToUpper().Split(",");
                bool exist = ((IList)Extenion).Contains(Result.FileExtention.ToUpper());
                if (!exist)
                {
                    Result.Memo = "上传格式" + Result.FileExtention + "异常，上传文件只允许 " + string.Join(",", Extenion);
                    return Result;
                }
            }

            Mkdir(TargetDirect);
            try
            {
                using var stream = File.Create(TargetDirect + Result.FileName);
                UploadFile.CopyTo(stream);
                stream.Flush();
            }
            catch (Exception e)
            {
                Result.Memo = e.Message;
                return Result;
            }

            if (File.Exists(TargetDirect + Result.FileName) == true)
            {
                Result.Status = true;
                Result.Memo = "";
                if (IsContent == true)
                {
                    Result.FileContent = FileToBase64(TargetDirect + Result.FileName);
                }

                //if (Result.FileExtention.ToUpper() == "JPG" || Result.FileExtention.ToUpper() == "JPEG" || Result.FileExtention.ToUpper() == "PNG")
                //{
                //    using var image = SixLabors.ImageSharp.Image.Load(TargetDirect + Result.FileName);
                //    Result.FileWidth = image.Width;
                //    Result.FileHeight = image.Height;
                //}

                var image = SKBitmap.Decode(TargetDirect + Result.FileName);
                Result.FileWidth = image.Width;
                Result.FileHeight = image.Height;

                if (IsUpload == true)
                {
                    var AliOss = new AliyunOss();
                    string upload = AliOss.Upload(SavePath + Result.FileName);
                    if (upload.Trim() != "")
                    {
                        Result.FileUrl = upload.Trim();
                        File.Delete(TargetDirect + Result.FileName);
                    }
                    else
                    {
                        Result.Status = false;
                        Result.Memo = "上传网盘异常";
                        return Result;
                    }
                }
                else if (IsSave == false)
                {
                    File.Delete(TargetDirect + Result.FileName);
                }
                else
                {
                    Result.FileUrl = "/" + SavePath + Result.FileName;
                    Result.Status = true;
                    Result.Memo = "Success";
                }
            }
            else
            {
                Result.Memo = "文件不存在";
            }

            return Result;
        }
        */

        public UploadEt Upload(
            IFormFile UploadFile,
            string SizeLimit = "",
            string ExtentionLimit = "",
            string SavePath = "",
            string NewFileName = "",
            bool IsSave = false,
            bool IsContent = false,
            bool IsUpload = false
        )
        {
            var Result = new UploadEt();
            try
            {
                Result.FileSize = UploadFile.Length;
            }
            catch (Exception e)
            {
                Console.WriteLine(e.Message);
                Result.Memo = "检测文件大小异常";
                return Result;
            }
            int DefaultSize;
            if (!String.IsNullOrEmpty(SizeLimit))
            {
                DefaultSize = Convert.ToInt32(SizeLimit.Trim()[0..^1]) * 1024;
            }
            else
            {
                DefaultSize = 524288000; // 默认500M
            }
            if (Result.FileSize > DefaultSize)
            {
                Result.Memo = "超出上传大小限制" + SizeLimit;
                return Result;
            }

            var FileName = UploadFile.FileName;
            Result.ContentType = UploadFile.ContentType;
            Result.FileExtention = Path.GetExtension(UploadFile.FileName).ToLower().Replace(".", "");
            if (NewFileName != "")
            {
                Result.FileName = NewFileName + "." + Result.FileExtention;
            }
            else
            {
                Result.FileName = FileName;
            }
            Result.FileWidth = 0;
            Result.FileHeight = 0;
            if (SavePath != "")
            {
                //如果开头带wwwroot，去掉
                if (SavePath.Length > 6)
                {
                    if (SavePath.Substring(0, 6).ToLower() == "Upload")
                    {
                        SavePath = SavePath.Substring(6, SavePath.Length - 6);
                    }
                    else if (SavePath.Substring(0, 7).ToLower() == "/Upload")
                    {
                        SavePath = SavePath.Substring(7, SavePath.Length - 7);
                    }
                }
                if (SavePath.Substring(SavePath.Length - 1, 1) != "/")
                {
                    SavePath += "/";
                }
                //如果最后一位是/哪么去掉
                if (SavePath[..1] == "/")
                {
                    SavePath = SavePath[1..];
                }
            }

            string TargetDirect = Directory.GetCurrentDirectory() + "/Temp/" + SavePath;

            //当尺寸限制不为空
            // if (SizeLimit.Trim() != "")
            // {
            //     //截取限制单位
            //     string SizeLimitUnit = SizeLimit.Substring(SizeLimit.Length - 1, 1).ToUpper();
            //     //截取限制值
            //     long SizeLimitNum = Convert.ToInt32(SizeLimit[0..^1]);

            //     switch (SizeLimitUnit)
            //     {
            //         case "K":
            //             SizeLimitNum *= 1024;
            //             break;
            //         case "M":
            //             SizeLimitNum = SizeLimitNum * 1024 * 1024;
            //             break;
            //         default:
            //             Result.Memo = "文件尺寸限制单位异常";
            //             return Result;
            //     }

            //     if (Result.FileSize > SizeLimitNum)
            //     {
            //         Result.Memo = "超出上传限制" + SizeLimit + "，现文件已有 " + Result.FileSize.ToString() + " 字节";
            //         return Result;
            //     }
            // }

            //当后缀有限制时
            if (ExtentionLimit.Trim() != "")
            {
                var Extenion = ExtentionLimit.ToUpper().Split(",");
                bool exist = ((IList)Extenion).Contains(Result.FileExtention.ToUpper());
                if (!exist)
                {
                    Result.Memo = "上传格式" + Result.FileExtention + "异常，上传文件只允许 " + string.Join(",", Extenion);
                    return Result;
                }
            }

            Mkdir(TargetDirect);
            try
            {
                using var stream = File.Create(TargetDirect + Result.FileName);
                UploadFile.CopyTo(stream);
                stream.Flush();
            }
            catch (Exception e)
            {
                Result.Memo = e.Message;
                return Result;
            }

            if (File.Exists(TargetDirect + Result.FileName) == true)
            {
                Result.Status = true;
                Result.Memo = "";
                if (IsContent == true)
                {
                    Result.FileContent = FileToBase64(TargetDirect + Result.FileName);
                }

                var image = SKBitmap.Decode(TargetDirect + Result.FileName);
                Result.FileWidth = image.Width;
                Result.FileHeight = image.Height;

                if (IsUpload == true)
                {
                    //var AliOss = new AliyunOss();
                    //string upload = AliOss.Upload(Result.FileName, "\"ATAC-Core\"").Trim();
                    //if (upload.Trim() != "")
                    //{
                    //    Result.FileUrl = upload.Trim();
                    //    File.Delete(TargetDirect + Result.FileName);
                    //}
                    //else
                    //{
                    //    Result.Status = false;
                    //    Result.Memo = "上传网盘异常";
                    //    return Result;
                    //}
                }
                else if (IsSave == false)
                {
                    File.Delete(TargetDirect + Result.FileName);
                }
                else
                {
                    Result.FileUrl = "/" + SavePath + Result.FileName;
                    Result.Status = true;
                    Result.Memo = "Success";
                }
            }
            else
            {
                Result.Memo = "文件不存在";
            }

            return Result;
        }


        public string BasePath(string SubPath = "")
        {
            SubPath = SubPath == "" ? "" : SubPath + "/";
            return (Directory.GetCurrentDirectory() + "/" + SubPath).Replace("\\", "/");
        }

        public bool DelFile(string FilePath)
        {
            if (File.Exists(FilePath))
            {
                try
                {
                    File.Delete(FilePath);
                    return true;
                }
                catch (Exception e)
                {
                    Console.WriteLine(e.Message);
                    return false;
                }
            }
            else
            {
                return true;
            }
        }

        public string FileType(string FilePath)
        {
            if (File.Exists(FilePath))
            {
                return Path.GetExtension(FilePath);
            }
            else
            {
                return "";
            }
        }

        //列表乱序
        public List<T> ListRandom<T>(List<T> Sources)
        {
            var Random = new Random();
            var ResultList = new List<T>();
            foreach (var item in Sources)
            {
                ResultList.Insert(Random.Next(ResultList.Count), item);
            }
            return ResultList;
        }

        //数组中随机抽取元素
        public int GetRandomNumber(int[] a)
        {
            Random rnd = new();
            int index = rnd.Next(a.Length);
            return a[index];
        }

        //数组中随机抽取指定数量的不同元素
        public int[] GetRandomNumberRange(int[] a, int num)
        {
            var s = new List<string>();
            foreach (var Item in a)
            {
                s.Add(Item.ToString());
            }
            var NewArr = string.Join(",", s.OrderBy(d => Guid.NewGuid()).Take(num));
            var StrArr = NewArr.Split(",");
            var IntArr = new int[StrArr.Length];
            for (int i = 0; i < StrArr.Length; i++)
            {
                IntArr[i] = Convert.ToInt32(StrArr[i]);
            }
            return IntArr;
        }

        public string LocalIP()
        {
            string HostName = Dns.GetHostName();
            var IPAddrList = Dns.GetHostAddresses(HostName);
            var Result = "";
            foreach (IPAddress IP in IPAddrList)
            {
                if (IP.AddressFamily == AddressFamily.InterNetwork)
                {
                    Result = IP.ToString();
                }
            }
            return "http://" + Result;
        }

        public string ClientIP(HttpContext? Context)
        {
            string? IP = "";
            if (Context != null)
            {
                IP = Context.Request.Headers["Cdn-Src-Ip"].FirstOrDefault();
                if (!string.IsNullOrEmpty(IP))
                {
                    return IP.Replace("::ffff:", "");
                }

                IP = Context.Request.Headers["X-Forwarded-For"].FirstOrDefault();
                if (!string.IsNullOrEmpty(IP))
                {
                    return IP.Replace("::ffff:", "");
                }

                IP = Context.Connection.RemoteIpAddress?.ToString();
            }

            if (!string.IsNullOrEmpty(IP))
            {
                return IP.Replace("::ffff:", "");
            }
            else
            {
                return "";
            }
        }

        public bool ZIP(string DirPath, string ZipPath)
        {
            try
            {
                ZipFile.CreateFromDirectory(DirPath, ZipPath);
                return true;
            }
            catch (Exception e)
            {
                Console.WriteLine(e.Message);
                return false;
            }
        }

        public bool UnZIP(string ZipPath, string ExtractPath)
        {
            try
            {
                ZipFile.ExtractToDirectory(ZipPath, ExtractPath);
                return true;
            }
            catch (Exception e)
            {
                Console.WriteLine(e.Message);
                return false;
            }
        }

        public bool SetToken(string Token, string TokenFileName = "Token")
        {
            string CacheDir = FileSystem.Current.CacheDirectory + "/";
            if (!Mkdir(CacheDir)) return false;
            string TokenFile = CacheDir + TokenFileName + DateTime.Today.ToString().Split(" ")[0].Replace("/", "").Replace("\\", "");
            if (File.Exists(TokenFile) && !DelFile(TokenFile)) return false;
            if (!CreateFile(TokenFile)) return false;
            try { WriteFile(TokenFile, Token); }
            catch (Exception) { return false; }
            return true;
        }

        public string GetToken(string TokenFileName = "Token")
        {
            return ReadFile(FileSystem.Current.CacheDirectory + "/" + TokenFileName + DateTime.Today.ToString().Split(" ")[0].Replace("/", "").Replace("\\", ""));
        }

        public bool CleanTheToken(string TokenFileName = "Token")
        {
            return DelFile(FileSystem.Current.CacheDirectory + "/" + TokenFileName + DateTime.Today.ToString().Split(" ")[0].Replace("/", "").Replace("\\", ""));
        }
    }

    /// <summary>
    /// 上传实体
    /// </summary>
    public class UploadEt
    {
        [JsonPropertyName("FileName")]
        public string FileName { get; set; }

        [JsonPropertyName("ContentType")]
        public string ContentType { get; set; }

        [JsonPropertyName("FileExtention")]
        public string FileExtention { get; set; }

        [JsonPropertyName("FileContent")]
        public string FileContent { get; set; }

        [JsonPropertyName("FileSize")]
        public long FileSize { get; set; }

        [JsonPropertyName("FileWidth")]
        public int FileWidth { get; set; }

        [JsonPropertyName("FileHeight")]
        public int FileHeight { get; set; }

        [JsonPropertyName("FileUrl")]
        public string FileUrl { get; set; }

        [JsonPropertyName("Status")]
        public bool Status { get; set; }

        [JsonPropertyName("Memo")]
        public string Memo { get; set; }

        [JsonPropertyName("Code")]
        public int Code { get; set; }

        public UploadEt()
        {
            FileName = "";
            ContentType = "";
            FileExtention = "";
            FileContent = "";
            FileSize = 0;
            FileWidth = 0;
            FileHeight = 0;
            FileUrl = "";
            Status = false;
            Memo = "";
            Code = 200;
        }
    }
}
