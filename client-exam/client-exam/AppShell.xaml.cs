using client_exam.Views;
using client_exam.Views.Manager;

namespace client_exam;

public partial class AppShell : Shell
{
    public AppShell()
    {
        InitializeComponent();
        Routing.RegisterRoute("MainPage", typeof(MainPage));
        Routing.RegisterRoute("LoginPage", typeof(LoginPage));
        Routing.RegisterRoute("MenuRootPage", typeof(MenuRootPage));
        Routing.RegisterRoute("ManagerPage", typeof(ManagerPage));
        Routing.RegisterRoute("TeacherPage", typeof(TeacherPage));
        Routing.RegisterRoute("ClassPage", typeof(ClassPage));
    }
}
