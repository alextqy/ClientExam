using Microsoft.Maui.Layouts;

namespace client_exam.Views.Manager;

public partial class ManagerPage : ContentPage
{
    public Lang _lang = new();

    public ManagerPage()
    {
        InitializeComponent();
        FloatingButton.Text = this._lang.AddData;
    }

    async private void AddDataItemClicked(object sender, EventArgs e)
    {
        await Navigation.PushAsync(new ManagerDetailsPage());
    }
}