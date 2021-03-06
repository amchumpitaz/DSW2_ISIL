﻿using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using Librerias.Isil.DentalSuite.Datos;
using Librerias.Isil.DentalSuite.Entidades;

namespace Librerias.Isil.DentalSuite.ReglasNegocio
{
    public class brPaciente
    {
        public List<bePaciente> Listar()
        {
            List<bePaciente> lbePaciente = null;
            string conexion = ConfigurationManager.ConnectionStrings["Dental"].ConnectionString;
            using (SqlConnection con = new SqlConnection(conexion))
            {
                try
                {
                    con.Open();
                    daPaciente odaPaciente = new daPaciente();
                    lbePaciente = odaPaciente.ListarPacientes(con);
                }
                catch (Exception ex)
                {
                    throw ex;
                }
            }
            return lbePaciente;
        }

        public bePaciente buscarPaciente(string codigo)
        {
            bePaciente obePaciente = null;
            string conexion = ConfigurationManager.ConnectionStrings["Dental"].ConnectionString;
            using (SqlConnection con = new SqlConnection(conexion))
            {
                try
                {
                    con.Open();
                    daPaciente odaPaciente = new daPaciente();
                    obePaciente = odaPaciente.BuscarPaciente(con,codigo);
                }
                catch (Exception ex)
                {
                    throw ex;
                }
            }
            return obePaciente;
        }

        public bool EliminarPaciente(string codigo)
        {
            bool exito = false;
            string conexion = ConfigurationManager.ConnectionStrings["Dental"].ConnectionString;
            using (SqlConnection con = new SqlConnection(conexion))
            {
                try
                {
                    con.Open();
                    daPaciente odaPaciente = new daPaciente();
                    exito = odaPaciente.EliminarPaciente(con, codigo);
                }
                catch (Exception ex)
                {
                    throw ex;
                }
            }
            return exito;
        }

        public bool ActualizarPaciente(bePaciente obePaciente)
        {
            bool exito = false;
            string conexion = ConfigurationManager.ConnectionStrings["Dental"].ConnectionString;
            using (SqlConnection con = new SqlConnection(conexion))
            {
                try
                {
                    con.Open();
                    daPaciente odaPaciente = new daPaciente();
                    exito = odaPaciente.ActualizarPaciente(con,obePaciente);
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
