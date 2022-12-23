namespace client_exam.Views.Manager;

public partial class MenuPage : ContentPage
{
    public Lang _lang = new();
    public Tools _tools = new();
    public ManagerHttp _managerHttp = new();

    public MenuPage()
    {
        InitializeComponent();
        //PersonalSettings.Text = this._lang.PersonalSettings;
    }

    async private void AccountLogout(object sender, EventArgs e)
    {
        var Result = this._managerHttp.ManagerSignOut(this._tools.GetToken());
        if (Result.State == true)
        {
            this._tools.CleanTheToken();
            await Navigation.PushModalAsync(new MainPage());
        }
        else
        {
            await DisplayAlert(this._lang.Error, this._lang.TheRequestFailed, this._lang.Close);
        }
    }
}