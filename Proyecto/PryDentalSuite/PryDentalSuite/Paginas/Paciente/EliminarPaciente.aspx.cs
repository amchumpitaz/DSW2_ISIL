using System;
using System.Web.UI;

namespace PryDentalSuite.Paginas.Paciente
{
    public partial class EliminarPaciente : Page
    {
        string codigo = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.QueryString.Count>0)
            {
                codigo = Request["codPaciente"].ToString();
                txtCodigo.Text = codigo;
            }
        }
    }
}