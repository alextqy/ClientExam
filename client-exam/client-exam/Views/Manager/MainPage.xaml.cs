namespace client_exam.Views;

public partial class MainPage : ContentPage
{
    public Lang _lang = new();

    public MainPage()
    {
        InitializeComponent();
        SelectButton.Text = this._lang.Manager;
        GoButton.Text = "Go";
    }


    async private void SelectButtonClicked(object sender, EventArgs e)
    {
        if (SelectButton.Text == this._lang.Manager)
        {
            await SelectButton.FadeTo(0, 350);
            SelectButton.Text = this._lang.Teacher;
            await SelectButton.FadeTo(1, 350);
        }
        else
        {
            await SelectButton.FadeTo(0, 350);
            SelectButton.Text = this._lang.Manager;
            await SelectButton.FadeTo(1, 350);
        }
    }

    private void GoButtonClicked(object sender, EventArgs e)
    {
        if (SelectButton.Text == this._lang.Manager)
        {
            Shell.Current.GoToAsync("LoginPage");
        }
        else
        {

        }
        GoButton.BackgroundColor = Colors.Black;
        GoButton.TextColor = Colors.Grey;
    }

    private void GoButtonPressed(object sender, EventArgs e)
    {
        GoButton.BackgroundColor = Colors.Grey;
        GoButton.TextColor = Colors.Black;
    }

    private void GoButtonReleased(object sender, EventArgs e)
    {
        GoButton.BackgroundColor = Colors.Black;
        GoButton.TextColor = Colors.Grey;
    }
}