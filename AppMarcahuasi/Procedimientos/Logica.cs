using AppMarcahuasi.Entities;
using AppMarcahuasi.Utils;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;


namespace AppMarcahuasi.Procedimientos
{
    public class Logica
    {
        public readonly string _cadena = ConfigurationManager.ConnectionStrings["cadenaSQL"].ToString();

        public bool RegistrarTurista(Turismo turismo)
        {

            bool Respuesta = false;
            using (SqlConnection con = new SqlConnection(_cadena))
            using (SqlCommand oCm = new SqlCommand("sp_RegistrarTurista", con))
            {
                oCm.CommandType = CommandType.StoredProcedure;
                try
                {
                    con.Open();
                    oCm.Parameters.Clear();
                    oCm.Parameters.Add("@Nombres", SqlDbType.VarChar, 40).Value = turismo.Nombres;
                    oCm.Parameters.Add("@Apellidos", SqlDbType.VarChar, 40).Value = turismo.Apellidos;
                    oCm.Parameters.Add("@Nacionalidad", SqlDbType.Char, 1).Value = turismo.Nacionalidad;
                    oCm.Parameters.Add("@PrecioBoleta", SqlDbType.Int).Value = turismo.PrecioBoleta;
                    oCm.Parameters.AddWithValue("@Correlativo", Parametros.Correlativo);
                    oCm.Parameters.Add("@Usuario_Registro", SqlDbType.VarChar, 40).Value = "ADMIN";
                    Respuesta = oCm.ExecuteNonQuery() > 0;
                }
                catch (Exception)
                {
                    throw;
                }
            }
            return Respuesta;
        }
        public bool ActualizarTurista(Turismo turismo)
        {
            bool Respuesta = true;

            SqlConnection con = new SqlConnection(_cadena);
            SqlCommand oCm = new SqlCommand();

            oCm.CommandType = CommandType.StoredProcedure;
            oCm.CommandText = "sp_Actualizar";
            oCm.Connection = con;

            try
            {
                con.Open();
                oCm.Parameters.Clear();

                oCm.Parameters.Add("@Id_Turista", SqlDbType.Int);
                oCm.Parameters.Add("@Nombres", SqlDbType.VarChar, 40);
                oCm.Parameters.Add("@Apellidos", SqlDbType.VarChar, 40);
                oCm.Parameters.Add("@Nacionalidad", SqlDbType.Char, 1);
                oCm.Parameters.Add("@PrecioBoleta", SqlDbType.Int);
                oCm.Parameters.Add("@Usuario_Modifica", SqlDbType.VarChar, 40);

                oCm.Parameters["@Id_Turista"].Value = turismo.Id_Turista;
                oCm.Parameters["@Nombres"].Value = turismo.Nombres;
                oCm.Parameters["@Apellidos"].Value = turismo.Apellidos;
                oCm.Parameters["@Nacionalidad"].Value = turismo.Nacionalidad;
                oCm.Parameters["@PrecioBoleta"].Value = turismo.PrecioBoleta;
                oCm.Parameters["@Usuario_Modificacion"].Value = turismo.Usuario_Modificacion;

                Respuesta = oCm.ExecuteNonQuery() > 0;
            }
            catch (Exception)
            {
                throw;
            }
            finally
            {
                oCm.Dispose();
                con.Close();
                con.Dispose();
            }

            return Respuesta;
        }
        //public DataTable ListarTuristas(DateTime fechaInicio, DateTime fechaFin, string nacionalidad)
        //{
        //    DataTable dt = new DataTable();
        //    SqlConnection con = new SqlConnection(_cadena);
        //    SqlCommand oCm = new SqlCommand();

        //    oCm.CommandType = CommandType.StoredProcedure;
        //    oCm.CommandText = "sp_Listar";
        //    oCm.Connection = con;

        //    try
        //    {
        //        con.Open();
        //        oCm.Parameters.Clear();

        //        oCm.Parameters.Add("@Fecha_Inicio", SqlDbType.DateTime).Value = fechaInicio;
        //        oCm.Parameters.Add("@Fecha_Fin", SqlDbType.DateTime).Value = fechaFin;

        //        //Si no selecciona nada → NULL
        //        if (string.IsNullOrEmpty(nacionalidad))
        //            oCm.Parameters.Add("@Nacionalidad", SqlDbType.Char, 1).Value = DBNull.Value;
        //        else
        //            oCm.Parameters.Add("@Nacionalidad", SqlDbType.Char, 1).Value = nacionalidad;

        //        SqlDataAdapter da = new SqlDataAdapter(oCm);
        //        da.Fill(dt);
        //    }
        //    catch (Exception)
        //    {
        //        throw;
        //    }
        //    finally
        //    {
        //        con.Close();
        //        con.Dispose();
        //    }
        //    return dt;
        //}

        public Turismo ObtenerTuristas()
        {
            Turismo t = null;

            using (SqlConnection con = new SqlConnection(_cadena))
            using (SqlCommand cmd = new SqlCommand("sp_ObtenerUltimoRegistro", con))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                con.Open();
                using (SqlDataReader dr = cmd.ExecuteReader())
                {
                    if (dr.Read())
                    {
                        t = new Turismo()
                        {
                            Id_Turista = Convert.ToInt32(dr["Id_Turista"]),
                            Nombres = dr["Nombres"].ToString(),
                            Apellidos = dr["Apellidos"].ToString(),
                            Nacionalidad = dr["Nacionalidad"].ToString().Trim()[0],
                            PrecioBoleta = Convert.ToInt32(dr["PrecioBoleta"])
                        };
                    }
                }
            }
            return t;
        }
    }
}