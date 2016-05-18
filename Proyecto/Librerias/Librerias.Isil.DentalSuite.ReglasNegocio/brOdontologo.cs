using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using Librerias.Isil.DentalSuite.Datos;
using Librerias.Isil.DentalSuite.Entidades;

namespace Librerias.Isil.DentalSuite.ReglasNegocio
{
    public class brOdontologo
    {
        public List<beOdontologo> Listar()
        {
            List<beOdontologo> lbeOdontologo = null;
            string conexion = ConfigurationManager.ConnectionStrings["Dental"].ConnectionString;
            using (SqlConnection con = new SqlConnection(conexion))
            {
                try
                {
                    con.Open();
                    daOdontologo odaOdontologo = new daOdontologo();
                    lbeOdontologo = odaOdontologo.ListarOdontologos(con);
                }
                catch (Exception ex)
                {
                    throw ex;
                }
            }
            return lbeOdontologo;
        }

        public beOdontologo buscarOdontologo(string codigo)
        {
            beOdontologo obeOdontologo = null;
            string conexion = ConfigurationManager.ConnectionStrings["Dental"].ConnectionString;
            using (SqlConnection con = new SqlConnection(conexion))
            {
                try
                {
                    con.Open();
                    daOdontologo odaOdontologo = new daOdontologo();
                    obeOdontologo = odaOdontologo.BuscarOdontologo(con, codigo);
                }
                catch (Exception ex)
                {
                    throw ex;
                }
            }
            return obeOdontologo;
        }

        public bool EliminarOdontologo(string codigo)
        {
            bool exito = false;
            string conexion = ConfigurationManager.ConnectionStrings["Dental"].ConnectionString;
            using (SqlConnection con = new SqlConnection(conexion))
            {
                try
                {
                    con.Open();
                    daOdontologo odaOdontologo = new daOdontologo();
                    exito = odaOdontologo.EliminarOdontologo(con, codigo);
                }
                catch (Exception ex)
                {
                    throw ex;
                }
            }
            return exito;
        }

        public bool ActualizarOdontologo(beOdontologo obeOdontologo)
        {
            bool exito = false;
            string conexion = ConfigurationManager.ConnectionStrings["Dental"].ConnectionString;
            using (SqlConnection con = new SqlConnection(conexion))
            {
                try
                {
                    con.Open();
                    daOdontologo odaOdontologo = new daOdontologo();
                    exito = odaOdontologo.ActualizarOdontologo(con, obeOdontologo);
                }
                catch (Exception ex)
                {
                    throw ex;
                }
            }
            return exito;
        }
    }
}
