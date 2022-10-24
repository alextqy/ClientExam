namespace client_exam.Views;

public partial class LoginPage : ContentPage
{
    public LoginPage()
    {
        InitializeComponent();
        LoginLayout.FadeTo(1, 3000);
    }

    async private void Clicked(object sender, EventArgs e)
    {
        if (BindingContext is Models.LoginEt loginEt)
        {
            if (string.IsNullOrEmpty(loginEt.Account) || string.IsNullOrEmpty(loginEt.Password))
            {
                await DisplayAlert("Error", "账号或密码不正确", "OK");
            }
            else
            {
                await LoginLayout.FadeTo(0, 1200);
                //await Navigation.PushAsync(new MainContent());
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