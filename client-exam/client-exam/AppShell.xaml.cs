using client_exam.Views;
using client_exam.Views.Manager;

namespace client_exam;

public partial class AppShell : Shell
{
    public AppShell()
    {
        InitializeComponent();
        Routing.RegisterRoute("LoginPage", typeof(LoginPage));
        Routing.RegisterRoute("IndexPage", typeof(IndexPage));
        Routing.RegisterRoute("ManagerPage", typeof(ManagerPage));
        Routing.RegisterRoute("TeacherPage", typeof(TeacherPage));
    }
}
