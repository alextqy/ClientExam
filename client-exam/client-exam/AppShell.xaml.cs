using client_exam.Views;

namespace client_exam;

public partial class AppShell : Shell
{
    public AppShell()
    {
        InitializeComponent();
        Routing.RegisterRoute("LoginPage", typeof(LoginPage));
        Routing.RegisterRoute("IndexPage", typeof(IndexPage));
    }
}
