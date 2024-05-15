using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Mail;
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
	/// Логика взаимодействия для DetailsWindow.xaml
	/// </summary>
	public partial class DetailsWindow : Window
	{
		public DetailsWindow(int id)
		{
			InitializeComponent();
			using (var db = new PhoneDirectoryEntities())
			{
				var query = from con in db.contact
							join gro in db.contact_group on con.contact_group equals gro.id
							join p in db.position on con.position equals p.id
							join com in db.company on con.company equals com.id
							where con.id == id
							select new
							{
								Фамилия = con.lastname,
								Имя = con.name,
								Отчество = con.surname,
								Телефон = con.phone,
								Email = con.e_mail,
								Компания = com.name,
								Позиция = p.name,
								Группа = gro.name,
							};
				dgDetal.ItemsSource = query.ToList();
			}
		}
	}
}