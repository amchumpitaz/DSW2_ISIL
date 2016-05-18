using System;
using System.Web.UI;
using Librerias.Isil.DentalSuite.Entidades;
using Librerias.Isil.DentalSuite.ReglasNegocio;

namespace PryDentalSuite.Paginas.Odontologo
{
    public partial class EliminarOdontologo : Page
    {
        beOdontologo obeOdontologo;
        protected void Page_Load(object sender, EventArgs e)
        {
            string codigo = "";
            brOdontologo obrOdontologo = null;
            if (Request.QueryString.Count > 0)
            {
                codigo = Request["codOdontologo"];
                obeOdontologo = new beOdontologo();
                obrOdontologo = new brOdontologo();
                obeOdontologo = obrOdontologo.buscarOdontologo(codigo);
                llenarDatos();
            }
        }

        protected void btnEliminar_Click(object sender, EventArgs e)
        {
            brPaciente obrPaciente = null;
            bool exito = false;
            if (obeOdontologo != null)
            {
                obrPaciente = new brPaciente();
                exito = obrPaciente.EliminarPaciente(obeOdontologo.Codigo);
                if (exito)
                {
                    Response.Redirect("~/Paginas/Odontologo/ListaOdontologo.aspx");
                }
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
                txtCOP.Text = obeOdontologo.COP;
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


            cboProvincia.DataSource = brGenerales.ListarProvincias(cboDepartamento.SelectedValue);
            cboProvincia.DataValueField = "Codigo";
            cboProvincia.DataTextField = "Detalle";
            cboProvincia.DataBind();


            cboDistrito.DataSource = brGenerales.ListarDistritos(cboDepartamento.SelectedValue, cboProvincia.SelectedValue);
            cboDistrito.DataValueField = "Codigo";
            cboDistrito.DataTextField = "Detalle";
            cboDistrito.DataBind();
        }
    }
}