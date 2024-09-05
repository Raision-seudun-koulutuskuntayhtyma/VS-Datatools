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
using System.Windows.Navigation;
using System.Windows.Shapes;

namespace TorstainWPFapp
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        public MainWindow()
        {
            InitializeComponent();
        }
        TorstainWPFapp.LaiteDataSet LaiteDataSet;
        TorstainWPFapp.LaiteDataSetTableAdapters.LainaajaTableAdapter lainaajaTableAdapter;
        private void Window_Loaded(object sender, RoutedEventArgs e)
        {

            TorstainWPFapp.LaiteDataSet laiteDataSet = ((TorstainWPFapp.LaiteDataSet)(this.FindResource("laiteDataSet")));
            // Load data into the table LainassaOlevatLaitteet. You can modify this code as needed.
            TorstainWPFapp.LaiteDataSetTableAdapters.LainassaOlevatLaitteetTableAdapter laiteDataSetLainassaOlevatLaitteetTableAdapter = new TorstainWPFapp.LaiteDataSetTableAdapters.LainassaOlevatLaitteetTableAdapter();
            laiteDataSetLainassaOlevatLaitteetTableAdapter.Fill(laiteDataSet.LainassaOlevatLaitteet);
            System.Windows.Data.CollectionViewSource lainassaOlevatLaitteetViewSource = ((System.Windows.Data.CollectionViewSource)(this.FindResource("lainassaOlevatLaitteetViewSource")));
            lainassaOlevatLaitteetViewSource.View.MoveCurrentToFirst();
            // Load data into the table Lainaaja. You can modify this code as needed.
            TorstainWPFapp.LaiteDataSetTableAdapters.LainaajaTableAdapter laiteDataSetLainaajaTableAdapter = new TorstainWPFapp.LaiteDataSetTableAdapters.LainaajaTableAdapter();
            laiteDataSetLainaajaTableAdapter.Fill(laiteDataSet.Lainaaja);
            System.Windows.Data.CollectionViewSource lainaajaViewSource = ((System.Windows.Data.CollectionViewSource)(this.FindResource("lainaajaViewSource")));
            lainaajaViewSource.View.MoveCurrentToFirst();
        }

        private void Button_Click(object sender, RoutedEventArgs e)
        {
            LaiteDataSet laiteDataSet = new LaiteDataSet();
        }
    }
}
