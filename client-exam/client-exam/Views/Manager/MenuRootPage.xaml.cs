namespace client_exam.Views.Manager;

public partial class MenuRootPage : FlyoutPage
{
    public MenuRootPage()
    {
        InitializeComponent();
        MenuRoot.MenuView.SelectionChanged += OnSelectionChanged;
    }

    void OnSelectionChanged(object sender, SelectionChangedEventArgs e)
    {
        FlyoutPageItem item = e.CurrentSelection.FirstOrDefault() as FlyoutPageItem;
        if (item != null)
        {
            Detail = new NavigationPage((Page)Activator.CreateInstance(item.TargetType));
            IsPresented = true;
        }
    }
}