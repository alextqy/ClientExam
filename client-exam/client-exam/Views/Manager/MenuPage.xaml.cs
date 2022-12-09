namespace client_exam.Views.Manager;
using client_exam.Models;

public partial class MenuPage : ContentPage
{
    public Lang _lang = new();

    public MenuPage()
    {
        InitializeComponent();
        BindingContext = new AllFlyoutPageItem();
    }
}