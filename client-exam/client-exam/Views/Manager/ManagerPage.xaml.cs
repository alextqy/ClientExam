namespace client_exam.Views.Manager;

public partial class ManagerPage : ContentPage
{
    public Lang _lang = new();
    public Tools _tools = new();
    public ManagerHttp _managerHttp = new();
    public List<ManagerEntity> Data = new();

    public ManagerPage()
    {
        InitializeComponent();
        CollectionHeader.Text = this._lang.Manager;
        TitleAccount.Text = this._lang.Account;
        TitleName.Text = this._lang.Name;
        TitleCreateTime.Text = this._lang.CreationTime;
        FloatingButton.Text = this._lang.AddData;
        NumberOfItems.Placeholder = this._lang.NumberOfItems;
        //var DetailsText = this._lang.Details;
        BindingContext = new AllManagers();
    }

    async private void AddDataItemClicked(object sender, EventArgs e)
    {
        await Navigation.PushAsync(new ManagerDetailsPage());
    }

    async private void DataDetails(object sender, EventArgs e)
    {
        var commandParameter = ((Button)(sender)).CommandParameter.ToString();
        await Navigation.PushAsync(new ManagerDetailsPage(commandParameter));
    }
}