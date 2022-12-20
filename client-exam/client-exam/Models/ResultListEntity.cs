namespace client_exam.Models
{
    public class ResultListEntity : Base
    {
        public int Page { get; set; }
        public int PageSize { get; set; }
        public int TotalPage { get; set; }
        public dynamic Data { get; set; }

        public ResultListEntity()
        {
            this.Page = 0;
            this.PageSize = 0;
            this.TotalPage = 0;
            this.Data = null;
        }
    }
}
