namespace client_exam.Views.Manager;

public partial class ManagerDetails : ContentPage
{
    public ManagerDetails()
    {
        InitializeComponent();
    }

    async private void BackToPage(object sender, EventArgs e)
    {
        await Navigation.PushAsync(new ManagerPage());
    }
}