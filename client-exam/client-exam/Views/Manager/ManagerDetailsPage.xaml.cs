namespace client_exam.Views.Manager;

public partial class ManagerDetailsPage : ContentPage
{
    public ManagerDetailsPage()
    {
        InitializeComponent();
    }

    async private void BackToPage(object sender, EventArgs e)
    {
        await Navigation.PushAsync(new ManagerPage());
    }
}