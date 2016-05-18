using System;
using System.Web.UI;
using Librerias.Isil.DentalSuite.Entidades;
using Librerias.Isil.DentalSuite.ReglasNegocio;

namespace PryDentalSuite.Paginas.Paciente
{
    public partial class ActualizarPaciente : Page
    {
        bePaciente obePaciente;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack) return;

            string codigo;
            brPaciente obrPaciente;
            if (Request.QueryString.Count > 0)
            {
                codigo = Request["codPaciente"];
                obePaciente = new bePaciente();
                obrPaciente = new brPaciente();
                obePaciente = obrPaciente.buscarPaciente(codigo);
                llenarDatos();
            }
        }

        protected void btnActualizar_Click(object sender, EventArgs e)
        {
            brPaciente obrPaciente;
            bool exito;

                obrPaciente = new brPaciente();
                llenarDatosNuevos();
                exito = obrPaciente.ActualizarPaciente(obePaciente);
                if (exito)
                {
                    Response.Redirect("~/Paginas/Paciente/ListaPacientes.aspx");
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
            cboDepartamento.DataTextField = "Detalle";
            cboDepartamento.DataBind();


            cboProvincia.DataSource = brGenerales.ListarProvincias(obePaciente.CodigoDepartamento);//cboDepartamento.SelectedValue);
            cboProvincia.DataValueField = "Codigo";
            cboProvincia.DataTextField = "Detalle";
            cboProvincia.DataBind();


            cboDistrito.DataSource = brGenerales.ListarDistritos(obePaciente.CodigoDepartamento,obePaciente.CodigoProvincia);//cboDepartamento.SelectedValue, cboProvincia.SelectedValue);
            cboDistrito.DataValueField = "Codigo";
            cboDistrito.DataTextField = "Detalle";
            cboDistrito.DataBind();

        }

        protected void cargaComboProvincia(object sender, EventArgs e)
        {
            string cod_departamento = cboDepartamento.SelectedValue;
            cboProvincia.ClearSelection();
            cboDistrito.ClearSelection();
            cboProvincia.DataSource = brGenerales.ListarProvincias(cod_departamento);
            cboProvincia.DataValueField = "Codigo";
            cboProvincia.DataTextField = "Detalle";
            cboProvincia.DataBind();
        }

        protected void cargarComboDistrito(object sender, EventArgs e)
        {
            string cod_departamento = cboDepartamento.SelectedValue;
            string cod_provincia = cboProvincia.SelectedValue;
            cboDistrito.ClearSelection();
            cboDistrito.DataSource = brGenerales.ListarDistritos(cod_departamento, cod_provincia);
            cboDistrito.DataValueField = "Codigo";
            cboDistrito.DataTextField = "Detalle";
            cboDistrito.DataBind();
        }

        protected void llenarDatosNuevos()
        {
            obePaciente = new bePaciente();
            obePaciente.Codigo = txtCodigo.Text.Trim();
            obePaciente.Nombres = txtNombres.Text.Trim();
            obePaciente.ApellidoPaterno = txtApePaterno.Text.Trim();
            obePaciente.ApellidoMaterno = txtApeMaterno.Text.Trim();
            if (rbMasculino.Checked)
            {
                obePaciente.Sexo = "M";
            }
            else
            {
                if (rbFemenino.Checked) obePaciente.Sexo = "F";
            }
            obePaciente.TipoDocumento = cboTipoDocumento.SelectedValue.Trim();
            obePaciente.NumeroDocumento = txtNumDocumento.Text.Trim();
            obePaciente.Correo = txtCorreo.Text.Trim();
            obePaciente.Direccion = txtDireccion.Text.Trim();
            obePaciente.CodigoDepartamento = cboDepartamento.SelectedValue.Trim();
            obePaciente.CodigoProvincia = cboProvincia.SelectedValue.Trim();
            obePaciente.CodigoDistrito = cboDistrito.SelectedValue.Trim();
            
        }
    }

    
}