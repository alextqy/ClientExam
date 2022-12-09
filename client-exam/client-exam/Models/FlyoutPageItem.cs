using client_exam.Views.Manager;

namespace client_exam.Models
{
    public class FlyoutPageItem
    {
        public string Title { get; set; }
        public string IconSource { get; set; }
        public Type TargetType { get; set; }

        public FlyoutPageItem()
        {
            this.Title = string.Empty;
            this.IconSource = string.Empty;
            this.TargetType = null;
        }
    }

    public class AllFlyoutPageItem
    {
        public Lang _lang = new();

        public ObservableCollection<FlyoutPageItem> FlyoutPageItems { get; set; } = new();
        public AllFlyoutPageItem() => LoadFlyoutPageItems();
        public void LoadFlyoutPageItems()
        {
            FlyoutPageItems.Clear();

            List<FlyoutPageItem> flyoutPageItems = new();
            flyoutPageItems.Insert(0, new FlyoutPageItem() { Title = this._lang.Manager, IconSource = "", TargetType = null });
            flyoutPageItems.Insert(1, new FlyoutPageItem() { Title = this._lang.Teacher, IconSource = "", TargetType = null });
            flyoutPageItems.Insert(2, new FlyoutPageItem() { Title = this._lang.Class, IconSource = "", TargetType = null });
            flyoutPageItems.Insert(3, new FlyoutPageItem() { Title = this._lang.Examinee, IconSource = "", TargetType = null });
            flyoutPageItems.Insert(4, new FlyoutPageItem() { Title = this._lang.ExamRegistration, IconSource = "", TargetType = null });
            flyoutPageItems.Insert(5, new FlyoutPageItem() { Title = this._lang.OldExamRegistration, IconSource = "", TargetType = null });
            flyoutPageItems.Insert(6, new FlyoutPageItem() { Title = this._lang.ExamSubjects, IconSource = "", TargetType = null });
            flyoutPageItems.Insert(7, new FlyoutPageItem() { Title = this._lang.KnowledgePoints, IconSource = "", TargetType = null });
            flyoutPageItems.Insert(8, new FlyoutPageItem() { Title = this._lang.HeadTopics, IconSource = "", TargetType = null });
            flyoutPageItems.Insert(9, new FlyoutPageItem() { Title = this._lang.Questions, IconSource = "", TargetType = null });
            flyoutPageItems.Insert(10, new FlyoutPageItem() { Title = this._lang.Paper, IconSource = "", TargetType = null });
            flyoutPageItems.Insert(11, new FlyoutPageItem() { Title = this._lang.AnswerCards, IconSource = "", TargetType = null });
            flyoutPageItems.Insert(12, new FlyoutPageItem() { Title = this._lang.OldAnswerCards, IconSource = "", TargetType = null });
            flyoutPageItems.Insert(13, new FlyoutPageItem() { Title = this._lang.SystemLogs, IconSource = "", TargetType = null });
            flyoutPageItems.Insert(14, new FlyoutPageItem() { Title = this._lang.ExamLogs, IconSource = "", TargetType = null });
            flyoutPageItems.Insert(15, new FlyoutPageItem() { Title = this._lang.Exit, IconSource = "", TargetType = null });
            foreach (FlyoutPageItem Item in flyoutPageItems) FlyoutPageItems.Add(Item);
        }
    }
}
