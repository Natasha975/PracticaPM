using Microsoft.Win32;
using System;
using System.CodeDom;
using System.Collections.Generic;
using System.IO;
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
using System.Windows.Navigation;
using System.Windows.Shapes;

namespace PhoneDirectory
{
	/// <summary>
	/// Логика взаимодействия для MainWindow.xaml
	/// </summary>
	public partial class MainWindow : Window
	{
		public MainWindow()
		{
			InitializeComponent();
		}

		private void Window_Loaded(object sender, RoutedEventArgs e)
		{
			using (var db = new PhoneDirectoryEntities())
			{
				cbGroup.ItemsSource= db.contact_group.ToList();
				cbGroup.DisplayMemberPath = "name";
			}
			Text();
		}
		private void Text()
		{
			var row = dgCont;
			try
			{
				using (var db = new PhoneDirectoryEntities())
				{
					var query = from con in db.contact
								join gro in db.contact_group on con.contact_group equals gro.id
								join p in db.position on con.position equals p.id
								join com in db.company on con.company equals com.id
								select new
								{
									Фамилия = con.lastname,
									Имя = con.name,
									Отчество = con.surname,
									Телефон = con.phone,
								};
					dgCont.ItemsSource = query.ToList();
				}
			}
			catch { MessageBox.Show("Отшибка!"); }
		}
		private void btAdd_Click(object sender, RoutedEventArgs e)
		{
			AddWindow window = new AddWindow();
			window.ShowDialog();
		}
		private void btDel_Click(object sender, RoutedEventArgs e)
		{
			var selectedItem = dgCont.SelectedItem;

			if (selectedItem != null)
			{
				var id = (int)selectedItem.GetType().GetProperty("Id").GetValue(selectedItem);

				try
				{
					using (var db = new PhoneDirectoryEntities())
					{
						var contact = db.contact.Find(id);
						db.contact.Remove(contact);
						db.SaveChanges();
					}
					dgCont.Items.Remove(selectedItem);
				}
				catch
				{
					MessageBox.Show("Ошибка при удалении записи!");
				}
			}
		}
		private void btPoisk_Click(object sender, RoutedEventArgs e)
		{
			try
			{
				var selectedGroup = (contact_group)cbGroup.SelectedItem;
				using (var db = new PhoneDirectoryEntities())
				{
					var query = from con in db.contact
								join gro in db.contact_group on con.contact_group equals gro.id
								join p in db.position on con.position equals p.id
								join com in db.company on con.company equals com.id
								where con.id == selectedGroup.id
								select new
								{
									Фамилия = con.lastname,
									Имя = con.name,
									Отчество = con.surname,
									Телефон = con.phone,
								};
					dgCont.ItemsSource = query.ToList();
				}
			}
			catch { MessageBox.Show("Отшибка!"); }
		}
		private void btSave_Click(object sender, RoutedEventArgs e)
		{
			SaveFileDialog saveFileDialog = new SaveFileDialog();
			saveFileDialog.FileName = "ExportData";
			saveFileDialog.Filter = "ExportData (*.csv)|*.csv";

			if (saveFileDialog.ShowDialog() == true)
			{

				var csvLines = new List<string>();

				foreach (var column in dgCont.Columns)
				{
					csvLines.Add(column.Header.ToString());
				}

				foreach (var item in dgCont.Items)
				{
					var line = "";

					foreach (var column in dgCont.Columns)
					{
						var value = column.GetCellContent(item).ToString();
						value = value.Replace(",", ";");
						value = value.Replace("\"", "\"\"");

						line += $"\"{value}\",";
					}

					line = line.TrimEnd(',');

					csvLines.Add(line);
				}

				File.WriteAllLines(saveFileDialog.FileName, csvLines);

				MessageBox.Show("Данные успешно экспортированы в файл " + saveFileDialog.FileName);
			}
		}
		private void TextBox_TextChanged(object sender, TextChangedEventArgs e)
		{
			var searchText = txtSearch.Text;

			using (var db = new PhoneDirectoryEntities())
			{
				var query = from con in db.contact
							join gro in db.contact_group on con.contact_group equals gro.id
							join p in db.position on con.position equals p.id
							join com in db.company on con.company equals com.id
							where con.lastname.Contains(searchText) || con.name.Contains(searchText) || con.surname.Contains(searchText)
							select new
							{
								Фамилия = con.lastname,
								Имя = con.name,
								Отчество = con.surname,
								Телефон = con.phone,
								Группа = gro.name,
							};
				dgCont.ItemsSource = query.ToList();
			}
		}
		private void btDetal_Click(object sender, RoutedEventArgs e)
		{
			int selectedRowIndex = dgCont.SelectedIndex-1;
			if (selectedRowIndex != 0)
			{
				DetailsWindow details = new DetailsWindow(selectedRowIndex);
				details.ShowDialog();
			}
		}
	}
}