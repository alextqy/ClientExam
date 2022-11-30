using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace client_exam.Models
{
    public class Base
    {
        public bool State { get; set; }
        public string Memo { get; set; }
        public int Code { get; set; }

        public Base()
        {
            this.State = false;
            this.Memo = string.Empty;
            this.Code = 0;
        }
    }
}
