using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PryDentalSuite.Paginas.Paciente
{
    public partial class EliminarPaciente : System.Web.UI.Page
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