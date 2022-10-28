namespace client_exam.Views;
using client_exam.Lib;
using client_exam.Requests;

public partial class LoginPage : ContentPage
{
    public Lang _lang = new();
    public ManagerHttp _managerHttp = new();

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
                await DisplayAlert("Error", Result, "Close");
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