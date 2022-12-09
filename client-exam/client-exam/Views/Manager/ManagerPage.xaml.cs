using Microsoft.Maui.Layouts;

namespace client_exam.Views.Manager;

public partial class ManagerPage : ContentPage
{
    public Lang _lang = new();

    public ManagerPage()
    {
        InitializeComponent();
        AddDataItem.Text = this._lang.AddData;
    }

    private void AddDataItemClicked(object sender, EventArgs e)
    {

    }
}