using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using Librerias.Isil.DentalSuite.Datos;
using Librerias.Isil.DentalSuite.Entidades;

namespace Librerias.Isil.DentalSuite.ReglasNegocio
{
    public class brGenerales
    {
        public static List<beDepartamento> ListarDepartamento()
        {
            List<beDepartamento> lbeDepartamento = null;
            string conexion = ConfigurationManager.ConnectionStrings["Dental"].ConnectionString;
            using (SqlConnection con = new SqlConnection(conexion))
            {
                try
                {
                    con.Open();
                    daGenerales odaGenerales = new daGenerales();
                    lbeDepartamento = odaGenerales.ListarDepartamento(con);
                }
                catch (Exception ex)
                {
                    throw ex;
                }
            }
            return lbeDepartamento;
        }

        public static List<beProvincia> ListarProvincias(string cod_departamento)
        {
            List<beProvincia> lbeProvincia = null;
            string conexion = ConfigurationManager.ConnectionStrings["Dental"].ConnectionString;
            using (SqlConnection con = new SqlConnection(conexion))
            {
                try
                {
                    con.Open();
                    daGenerales odaGenerales = new daGenerales();
                    lbeProvincia = odaGenerales.ListarProvincia(con,cod_departamento);
                }
                catch (Exception ex)
                {
                    throw ex;
                }
            }
            return lbeProvincia;
        }

        public static List<beDistrito> ListarDistritos(string cod_departamento,string cod_provincia)
        {
            List<beDistrito> lbeDistrito = null;
            string conexion = ConfigurationManager.ConnectionStrings["Dental"].ConnectionString;
            using (SqlConnection con = new SqlConnection(conexion))
            {
                try
                {
                    con.Open();
                    daGenerales odaGenerales = new daGenerales();
                    lbeDistrito = odaGenerales.ListarDistritos(con, cod_departamento,cod_provincia);
                }
                catch (Exception ex)
                {
                    throw ex;
                }
            }
            return lbeDistrito;
        }

        public static List<beTipoDocumento> ListarTipoDocumento()
        {
            List<beTipoDocumento> lbeTipoDocumento = null;
            string conexion = ConfigurationManager.ConnectionStrings["Dental"].ConnectionString;
            using (SqlConnection con = new SqlConnection(conexion))
            {
                try
                {
                    con.Open();
                    daGenerales odaGenerales = new daGenerales();
                    lbeTipoDocumento = odaGenerales.ListarTipoDocumento(con);
                }
                catch (Exception ex)
                {
                    throw ex;
                }
            }
            return lbeTipoDocumento;
        }

        public static string ObtenerCodTipDoc(string desc_corta)
        {
            string codigo = "";
            string conexion = ConfigurationManager.ConnectionStrings["Dental"].ConnectionString;
            using (SqlConnection con = new SqlConnection(conexion))
            {
                try
                {
                    con.Open();
                    daGenerales odaGenerales = new daGenerales();
                    codigo = odaGenerales.ObtenerCodigoTipDocumento(con,desc_corta);
                }
                catch (Exception ex)
                {
                    throw ex;
                }
            }
            return codigo;
        }

        public static List<beEspecialidad> ListarEspecialidadCbo()
        {
            List<beEspecialidad> lbeEspecialidad = null;
            string conexion = ConfigurationManager.ConnectionStrings["Dental"].ConnectionString;
            using (SqlConnection con = new SqlConnection(conexion))
            {
                try
                {
                    con.Open();
                    daGenerales odaGenerales = new daGenerales();
                    lbeEspecialidad = odaGenerales.ListarEspecialidadCBO(con);                    
                }
                catch (Exception ex)
                {
                    throw ex;
                }
            }
            return lbeEspecialidad;
        }

        public static List<beOdontologo> ListarOdontologoCbo()
        {
            List<beOdontologo> lbeOdontologo = null;
            string conexion = ConfigurationManager.ConnectionStrings["Dental"].ConnectionString;
            using (SqlConnection con = new SqlConnection(conexion))
            {
                try
                {
                    con.Open();
                    daGenerales odaGenerales = new daGenerales();
                    lbeOdontologo = odaGenerales.ListarOdontologoCBO(con);
                }
                catch (Exception ex)
                {
                    throw ex;
                }
            }
            return lbeOdontologo;
        }

        public static List<beHorarioOdontologo> ListarHorarioOdontologoCbo(string codOdontologo)
        {
            List<beHorarioOdontologo> lbeHorarioOdontologo = null;
            string conexion = ConfigurationManager.ConnectionStrings["Dental"].ConnectionString;
            using (SqlConnection con = new SqlConnection(conexion))
            {
                try
                {
                    con.Open();
                    daGenerales odaGenerales = new daGenerales();
                    lbeHorarioOdontologo = odaGenerales.ListarHorarioOdontologoCBO(con, codOdontologo);
                }
                catch (Exception ex)
                {
                    throw ex;
                }
            }
            return lbeHorarioOdontologo;
        }

        public static string mostrarMensaje(string mens)
        {
            string mensaje = "";
            mensaje += "<script>alert('";
            mensaje += mens;
            mensaje += "')</script>";
            return mensaje;
        }
    }
}
