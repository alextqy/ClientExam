namespace client_exam.Views;

using client_exam.Lib;
using client_exam.Models;
using client_exam.Requests;
using System.Diagnostics;
using System.Text.Json;

public partial class LoginPage : ContentPage
{
    public Lang _lang = new();
    public ManagerHttp _managerHttp = new();
    public Tools _tools = new();

    public LoginPage()
    {
        InitializeComponent();
        LoginLayout.FadeTo(1, 3000);
    }

    async private void Clicked(object sender, EventArgs e)
    {
        if (string.IsNullOrEmpty(Account.Text) || string.IsNullOrEmpty(Password.Text))
        {
            await DisplayAlert("Error", this._lang.IncorrectInput, "Close");
        }
        else
        {
            try
            {
                var Result = _managerHttp.ManagerSignIn(Account.Text, Password.Text);
                var RequestInfo = JsonSerializer.Deserialize<LoginModel>(Result);
                string CacheDir = FileSystem.Current.CacheDirectory + "/";
                string TokenFile = CacheDir + "Token" + DateTime.Today.ToString().Split(" ")[0].Replace("/", "").Replace("\\", "");

                await DisplayAlert("Succeed", CacheDir, "Close");
            }
            catch (Exception)
            {
                await DisplayAlert("Error", this._lang.TheRequestFailed, "Close");
            }
            //await LoginLayout.FadeTo(0, 1200);
            //await Navigation.PushAsync(new MenuRoot());
            //await Shell.Current.GoToAsync("IndexPage");
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