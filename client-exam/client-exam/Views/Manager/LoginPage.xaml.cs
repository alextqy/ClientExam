namespace client_exam.Views;

public partial class LoginPage : ContentPage
{
    public Lang _lang = new();
    public ManagerHttp _managerHttp = new();
    public Tools _tools = new();

    public LoginPage()
    {
        InitializeComponent();
        LoginLayout.FadeTo(1, 1000);
    }

    async private void Clicked(object sender, EventArgs e)
    {
        if (string.IsNullOrEmpty(Account.Text) || string.IsNullOrEmpty(Password.Text))
        {
            await DisplayAlert(this._lang.Error, this._lang.IncorrectInput, this._lang.Close);
        }
        else
        {
            try
            {
                var Result = this._managerHttp.ManagerSignIn(Account.Text, Password.Text);
                var RequestInfo = JsonSerializer.Deserialize<LoginModel>(Result);
                if (RequestInfo.State == true && this._tools.SetToken(RequestInfo.Data))
                {
                    Debug.WriteLine(this._tools.GetToken());
                    //await LoginLayout.FadeTo(0, 1000);
                    //await Navigation.PushAsync(new MenuRoot());
                    await Shell.Current.GoToAsync("MenuRootPage");
                }
                else
                {
                    await DisplayAlert(this._lang.Error, this._lang.TheRequestFailed, this._lang.Close);
                }
            }
            catch (Exception)
            {
                await DisplayAlert(this._lang.Error, this._lang.TheRequestFailed, this._lang.Close);
            }
        }
    }

    private void Pressed(object sender, EventArgs e)
    {
        LoginButton.BackgroundColor = Colors.Grey;
        LoginButton.TextColor = Colors.Black;
    }

    private void Released(object sender, EventArgs e)
    {
        LoginButton.BackgroundColor = Colors.Black;
        LoginButton.TextColor = Colors.Grey;
    }
}