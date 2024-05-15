using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Shapes;

namespace PhoneDirectory
{
	/// <summary>
	/// Логика взаимодействия для AddWindow.xaml
	/// </summary>
	public partial class AddWindow : Window
	{
		public AddWindow()
		{
			InitializeComponent();
		}

		private void btAdd_Click(object sender, RoutedEventArgs e)
		{
			using (var db = new PhoneDirectoryEntities())
			{
				int last = db.contact.Max(u => u.id) + 1;
				var newCon = new contact();
				newCon.id = last;
				if (tbLast.Text == null || tbName == null || tbSur == null || tbPhone == null)
				{
					MessageBox.Show("Контакт не может быть создан!");
				}
				newCon.lastname = tbLast.Text;
				newCon.name = tbName.Text;
				newCon.surname = tbSur.Text;
				newCon.phone = tbPhone.Text;
				newCon.e_mail = tbEm.Text;
				newCon.birthday = (DateTime?)dpDay.SelectedDate;

				var selectedCom = (company)cbComp.SelectedItem;
				newCon.company = selectedCom.id;
				var selectedPos = (position)cbPos.SelectedItem;
				newCon.position = selectedPos.id;
				var selectedGroup = (contact_group)cbGroup.SelectedItem;
				newCon.contact_group = selectedGroup.id;
				try
				{
					db.contact.Add(newCon);
					db.SaveChanges();
					MessageBox.Show("Контакт создан!");
				}
				catch
				{
					MessageBox.Show("Контакт не может быть создан!");
				}
			}
		}
		private void Window_Loaded(object sender, RoutedEventArgs e)
		{
			using (var db = new PhoneDirectoryEntities())
			{
				cbComp.ItemsSource = db.company.ToList();
				cbGroup.ItemsSource = db.contact_group.ToList();
				cbPos.ItemsSource = db.position.ToList();

				cbComp.DisplayMemberPath = "name";
				cbGroup.DisplayMemberPath = "name";
				cbPos.DisplayMemberPath = "name";
			}
		}
    }
}
