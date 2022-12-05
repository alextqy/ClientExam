namespace client_exam.Views;

public partial class MainPage : ContentPage
{
    public MainPage()
    {
        InitializeComponent();
        MainLayout.FadeTo(1, 1000);
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