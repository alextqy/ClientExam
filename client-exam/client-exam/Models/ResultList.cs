namespace client_exam.Models
{
    public class ResultList : Base
    {
        public int Page { get; set; }
        public int PageSize { get; set; }
        public int TotalPage { get; set; }
        public string Data { get; set; }

        public ResultList()
        {
            this.Page = 0;
            this.PageSize = 0;
            this.TotalPage = 0;
            this.Data = string.Empty;
        }
    }
}
