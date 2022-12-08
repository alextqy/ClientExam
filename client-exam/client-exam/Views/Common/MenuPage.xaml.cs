namespace client_exam.Views.Common;
using client_exam.Views.Manager;

public partial class MenuPage : Picker
{
    public Lang _lang = new();
    public Tools _tools = new();

    public MenuPage()
    {
        InitializeComponent();
        TopMenu.FadeTo(1, 1000);
        TopMenu.Items.Add(this._lang.Menu);
        TopMenu.Items.Add(this._lang.Manager);
        TopMenu.Items.Add(this._lang.Teacher);
        TopMenu.Items.Add(this._lang.Class);
        TopMenu.Items.Add(this._lang.Examinee);
        TopMenu.Items.Add(this._lang.ExamRegistration);
        TopMenu.Items.Add(this._lang.OldExamRegistration);
        TopMenu.Items.Add(this._lang.ExamSubjects);
        TopMenu.Items.Add(this._lang.KnowledgePoints);
        TopMenu.Items.Add(this._lang.HeadTopics);
        TopMenu.Items.Add(this._lang.Questions);
        TopMenu.Items.Add(this._lang.Paper);
        TopMenu.Items.Add(this._lang.AnswerCards);
        TopMenu.Items.Add(this._lang.OldAnswerCards);
        TopMenu.Items.Add(this._lang.SystemLogs);
        TopMenu.Items.Add(this._lang.ExamLogs);
        TopMenu.Items.Add(this._lang.Exit);
        TopMenu.SelectedIndex = 0;
    }

    async private void OnPickerSelectedIndexChanged(object sender, EventArgs e)
    {
        var MenuObject = (Picker)sender;
        int SelectedItem = MenuObject.SelectedIndex;

        if (SelectedItem > 0)
        {
            //Debug.WriteLine("ItemIndex is: " + SelectedIndex.ToString());
            switch (SelectedItem)
            {
                case 1:
                    await Shell.Current.GoToAsync("ManagerPage");
                    //await Shell.Current.GoToAsync($"{nameof(ManagerPage)}?{nameof(ManagerPage.ItemIndex)}={1}");
                    break;
                case 2:
                    await Shell.Current.GoToAsync("TeacherPage");
                    break;
                case 3:
                    await Shell.Current.GoToAsync("IndexPage");
                    break;
                case 4:
                    await Shell.Current.GoToAsync("IndexPage");
                    break;
                case 5:
                    await Shell.Current.GoToAsync("IndexPage");
                    break;
                case 6:
                    await Shell.Current.GoToAsync("IndexPage");
                    break;
                case 7:
                    await Shell.Current.GoToAsync("IndexPage");
                    break;
                case 8:
                    await Shell.Current.GoToAsync("IndexPage");
                    break;
                case 9:
                    await Shell.Current.GoToAsync("IndexPage");
                    break;
                case 10:
                    await Shell.Current.GoToAsync("IndexPage");
                    break;
                case 11:
                    await Shell.Current.GoToAsync("IndexPage");
                    break;
                case 12:
                    await Shell.Current.GoToAsync("IndexPage");
                    break;
                case 13:
                    await Shell.Current.GoToAsync("IndexPage");
                    break;
                case 14:
                    await Shell.Current.GoToAsync("IndexPage");
                    break;
                case 15:
                    await Shell.Current.GoToAsync("IndexPage");
                    break;
                default:
                    await Shell.Current.GoToAsync("IndexPage");
                    break;
            }
        }
    }
}