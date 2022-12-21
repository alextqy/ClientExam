namespace client_exam.Models
{
    public class ManagerEntity
    {
        public int ID { get; set; }
        public string Account { get; set; }
        public string Password { get; set; }
        public string Name { get; set; }
        public int State { get; set; }
        public int Permission { get; set; }
        public int CreateTime { get; set; }
        public int UpdateTime { get; set; }
        public string Token { get; set; }

        public string CreateTimeStr { get; set; }

        public ManagerEntity()
        {
            this.ID = 0;
            this.Account = "";
            this.Password = "";
            this.Name = "";
            this.State = 0;
            this.Permission = 0;
            this.CreateTime = 0;
            this.UpdateTime = 0;
            this.Token = "";
            this.CreateTimeStr = "";
        }
    }

    public class AllManagers
    {
        public Tools _tools = new();
        public ManagerHttp _managerHttp = new();
        public ObservableCollection<ManagerEntity> Managers { get; set; } = new();

        public AllManagers(
            string Page = "1",
            string PageSize = "5",
            string Stext = "",
            string State = "0",
            string Permission = "0"
        ) => LoadManagers(Page, PageSize, Stext, State, Permission);

        public void LoadManagers(
            string Page,
            string PageSize,
            string Stext,
            string State,
            string Permission
        )
        {
            this.Managers.Clear();
            var Result = this._managerHttp.ManagerList(this._tools.GetToken(), Page, PageSize, Stext, State, Permission);
            List<ManagerEntity> managers = JsonSerializer.Deserialize<List<ManagerEntity>>(Result.Data);
            if (Result.State == true)
            {
                foreach (ManagerEntity manager in managers)
                {
                    manager.CreateTimeStr = this._tools.TimeStampToDateTime(manager.CreateTime).ToString();
                    Managers.Add(manager);
                }
            }
        }
    }
}
