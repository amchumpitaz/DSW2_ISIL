using System;
using System.Web.UI;
using Librerias.Isil.DentalSuite.Entidades;
using Librerias.Isil.DentalSuite.ReglasNegocio;

namespace PryDentalSuite.Paginas.Paciente
{
    public partial class EliminarPaciente : Page
    {
        bePaciente obePaciente;
        protected void Page_Load(object sender, EventArgs e)
        {
            string codigo = "";
            brPaciente obrPaciente = null;
            if (Request.QueryString.Count>0)
            {
                codigo = Request["codPaciente"];
                obePaciente = new bePaciente();
                obrPaciente = new brPaciente();
                obePaciente = obrPaciente.buscarPaciente(codigo);
                llenarDatos();
            }
        }

        protected void btnEliminar_Click(object sender, EventArgs e)
        {
            brPaciente obrPaciente = null;
            bool exito=false;
            if (obePaciente != null)
            {
                obrPaciente = new brPaciente();
                exito=obrPaciente.EliminarPaciente(obePaciente.Codigo);
                if (exito)
                {
                    Response.Redirect("~/Paginas/Paciente/ListaPacientes.aspx");
                }   
            }
        }

        public void llenarDatos()
        {
            llenarCombos();
            if (obePaciente != null)
            {
                txtCodigo.Text = obePaciente.Codigo;
                txtNombres.Text = obePaciente.Nombres;
                txtApePaterno.Text = obePaciente.ApellidoPaterno;
                txtApeMaterno.Text = obePaciente.ApellidoMaterno;
                if (obePaciente.Sexo.ToUpper() == "M")
                {
                    rbMasculino.Checked = true;
                }
                else
                {
                    if (obePaciente.Sexo.ToUpper() == "F") rbFemenino.Checked = true;
                }
                cboTipoDocumento.SelectedValue = brGenerales.ObtenerCodTipDoc(obePaciente.TipoDocumento.Trim());
                txtNumDocumento.Text = obePaciente.NumeroDocumento;
                txtCorreo.Text = obePaciente.Correo;
                txtDireccion.Text = obePaciente.Direccion;
                cboDepartamento.SelectedValue = obePaciente.CodigoDepartamento.Trim();
                cboProvincia.SelectedValue = obePaciente.CodigoProvincia.Trim();
                cboDistrito.SelectedValue = obePaciente.CodigoDistrito.Trim();
            }
        }
        public void llenarCombos()
        {
            cboTipoDocumento.DataSource = brGenerales.ListarTipoDocumento();
            cboTipoDocumento.DataValueField = "Codigo";
            cboTipoDocumento.DataTextField = "Detalle";
            cboTipoDocumento.DataBind();

            cboDepartamento.DataSource = brGenerales.ListarDepartamento();            
            cboDepartamento.DataValueField = "codigo";
            cboDepartamento.DataTextField= "Detalle";
            cboDepartamento.DataBind();


            cboProvincia.DataSource = brGenerales.ListarProvincias(cboDepartamento.SelectedValue);
            cboProvincia.DataValueField = "Codigo";
            cboProvincia.DataTextField = "Detalle";
            cboProvincia.DataBind();


            cboDistrito.DataSource = brGenerales.ListarDistritos(cboDepartamento.SelectedValue,cboProvincia.SelectedValue);
            cboDistrito.DataValueField = "Codigo";
            cboDistrito.DataTextField = "Detalle";
            cboDistrito.DataBind();

        }
    }
}