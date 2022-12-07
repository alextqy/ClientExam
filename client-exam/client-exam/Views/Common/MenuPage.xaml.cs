namespace client_exam.Views.Common;

public partial class MenuPage : Picker
{
    public Lang _lang = new();

    public MenuPage()
    {
        InitializeComponent();
        Menu.FadeTo(1, 1000);
        Menu.Items.Add(this._lang.Menu);
        Menu.Items.Add("Capuchin Monkey");
        Menu.Items.Add("Blue Monkey");
        Menu.Items.Add("Squirrel Monkey");
        Menu.Items.Add("Golden Lion Tamarin");
        Menu.Items.Add("Howler Monkey");
        Menu.Items.Add("Japanese Macaque");
        Menu.SelectedIndex = 0;
    }

    private void OnPickerSelectedIndexChanged(object sender, EventArgs e)
    {
        var MenuObject = (Picker)sender;
        int selectedIndex = MenuObject.SelectedIndex;

        if (selectedIndex > 0)
        {
            Debug.WriteLine("ItemIndex is: " + SelectedIndex.ToString());
        }
    }
}