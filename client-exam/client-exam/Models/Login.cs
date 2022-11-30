using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace client_exam.Models
{
    public class LoginModel : Base
    {
        public string Data { get; set; }

        public LoginModel()
        {
            this.Data = string.Empty;
        }
    }
}
