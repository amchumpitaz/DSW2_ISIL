using System;
using System.Web.UI;
using Librerias.Isil.DentalSuite.Entidades;
using Librerias.Isil.DentalSuite.ReglasNegocio;

namespace PryDentalSuite.Paginas.Odontologo
{
    public partial class ActualizarOdontologo : Page
    {
        beOdontologo obeOdontologo;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack) return;

                string codigo;
            brOdontologo obrOdontologo;
            if (Request.QueryString.Count > 0)
            {
                codigo = Request["codOdontologo"];
                obeOdontologo = new beOdontologo();
                obrOdontologo = new brOdontologo();
                obeOdontologo = obrOdontologo.buscarOdontologo(codigo);
                llenarDatos();
            }
        }


        public void llenarDatos()
        {
            llenarCombos();
            if (obeOdontologo != null)
            {
                txtCodigo.Text = obeOdontologo.Codigo;
                txtNombres.Text = obeOdontologo.Nombres;
                txtApePaterno.Text = obeOdontologo.ApellidoPaterno;
                txtApeMaterno.Text = obeOdontologo.ApellidoMaterno;
                if (obeOdontologo.Sexo.ToUpper() == "M")
                {
                    rbMasculino.Checked = true;
                }
                else
                {
                    if (obeOdontologo.Sexo.ToUpper() == "F") rbFemenino.Checked = true;
                }
                cboTipoDocumento.SelectedValue = brGenerales.ObtenerCodTipDoc(obeOdontologo.TipoDocumento.Trim());
                txtNumDocumento.Text = obeOdontologo.NumeroDocumento;
                txtCorreo.Text = obeOdontologo.Correo;
                txtDireccion.Text = obeOdontologo.Direccion;
                cboDepartamento.SelectedValue = obeOdontologo.CodigoDepartamento.Trim();
                cboProvincia.SelectedValue = obeOdontologo.CodigoProvincia.Trim();
                cboDistrito.SelectedValue = obeOdontologo.CodigoDistrito.Trim();
                txtCOP.Text = obeOdontologo.COP.Trim();
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


            cboProvincia.DataSource = brGenerales.ListarProvincias(obeOdontologo.CodigoDepartamento.Trim());//cboDepartamento.SelectedValue.ToString().Trim());
            cboProvincia.DataValueField = "Codigo";
            cboProvincia.DataTextField = "Detalle";
            cboProvincia.DataBind();


            cboDistrito.DataSource = brGenerales.ListarDistritos(obeOdontologo.CodigoDepartamento.Trim(),obeOdontologo.CodigoProvincia.Trim());//cboDepartamento.SelectedValue.ToString(), cboProvincia.SelectedValue.ToString().Trim());
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
            obeOdontologo = new beOdontologo();
            obeOdontologo.Codigo = txtCodigo.Text.Trim();
            obeOdontologo.Nombres = txtNombres.Text.Trim();
            obeOdontologo.ApellidoPaterno = txtApePaterno.Text.Trim();
            obeOdontologo.ApellidoMaterno = txtApeMaterno.Text.Trim();
            if (rbMasculino.Checked)
            {
                obeOdontologo.Sexo = "M";
            }
            else
            {
                if (rbFemenino.Checked) obeOdontologo.Sexo = "F";
            }
            obeOdontologo.TipoDocumento = cboTipoDocumento.SelectedValue.Trim();
            obeOdontologo.NumeroDocumento = txtNumDocumento.Text.Trim();
            obeOdontologo.Correo = txtCorreo.Text.Trim();
            obeOdontologo.Direccion = txtDireccion.Text.Trim();
            obeOdontologo.CodigoDepartamento = cboDepartamento.SelectedValue.Trim();
            obeOdontologo.CodigoProvincia = cboProvincia.SelectedValue.Trim();
            obeOdontologo.CodigoDistrito = cboDistrito.SelectedValue.Trim();
            obeOdontologo.COP = txtCOP.Text.Trim();
        }

        protected void btnActualizar_Click(object sender, EventArgs e)
        {
            brOdontologo obrOdontologo;
            bool exito;
                obrOdontologo = new brOdontologo();
                llenarDatosNuevos();
                exito = obrOdontologo.ActualizarOdontologo(obeOdontologo);
                if (exito)
                {
                    Response.Redirect("~/Paginas/Odontologo/ListaOdontologo.aspx");
                }
            
        }
    }
}