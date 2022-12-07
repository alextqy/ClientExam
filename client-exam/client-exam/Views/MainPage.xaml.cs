namespace client_exam.Views;

public partial class MainPage : ContentPage
{
    public Lang _lang = new();

    public MainPage()
    {
        InitializeComponent();
        Manager.Text = this._lang.Manager;
        Teacher.Text = this._lang.Teacher;
    }

    async private void ManagerClicked(object sender, EventArgs e)
    {
        await Shell.Current.GoToAsync("LoginPage");
        Manager.BackgroundColor = Colors.Black;
        Manager.TextColor = Colors.Grey;
    }

    private void ManagerPressed(object sender, EventArgs e)
    {
        Manager.BackgroundColor = Colors.Grey;
        Manager.TextColor = Colors.Black;
    }

    private void ManagerReleased(object sender, EventArgs e)
    {
        Manager.BackgroundColor = Colors.Black;
        Manager.TextColor = Colors.Grey;
    }

    private void TeacherClicked(object sender, EventArgs e)
    {

    }

    private void TeacherPressed(object sender, EventArgs e)
    {
        Teacher.BackgroundColor = Colors.Grey;
        Teacher.TextColor = Colors.Black;
    }

    private void TeacherReleased(object sender, EventArgs e)
    {
        Teacher.BackgroundColor = Colors.Black;
        Teacher.TextColor = Colors.Grey;
    }
}