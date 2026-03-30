using AppMarcahuasi.Entities;
using AppMarcahuasi.Procedimientos;
using AppMarcahuasi.Utils;
using ClosedXML.Excel;
using DocumentFormat.OpenXml.Math;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AppMarcahuasi.Infraestructura
{
    public partial class VistaPrincipal : System.Web.UI.Page
    {
        public int PrecioNacional => Parametros.PrecioNacional;
        public int PrecioInternacional => Parametros.PrecioInternacional;
        public int PrecioEstudiante => Parametros.PrecioEstudiante;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                gvTuristas.DataSource = new List<object>(); // lista vacía
                gvTuristas.DataBind();
                ObtenerUltimoTurista();
                SettearNombreEmpleado();
            }
            else
            {
                if (Accion.Value == "REGISTRAR")
                {
                    RegistrarTicket();
                    ObtenerUltimoTurista();
                }
                else if (Accion.Value == "ACTUALIZAR")
                {
                    ActualizarRegistro();
                    ObtenerUltimoTurista();
                }
                limpiarCamposRegistro();
            }
        }

        private void limpiarCamposRegistro()
        {
            txtNombre.Text = "";
            txtApellido.Text = "";
            ddlNacionalidad.SelectedIndex = 0;
        }

        private void ObtenerUltimoTurista()
        {
            Logica logica = new Logica();
            List<Turismo> lista = new List<Turismo>();

            try
            {
                lista = logica.ObtenerTuristas();
                gvTuristas.DataSource = lista;
                gvTuristas.DataBind();

                Turismo turismo = lista.FirstOrDefault();
                if (turismo != null)
                {
                    IdIngresoEdit.Value = turismo.Id_Turista.ToString();
                    if (turismo.Fecha_Modificacion != DateTime.MinValue)
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "msg", "bloquearActualizacion();", true);
                }
            }
            catch (Exception ex)
            {
                string mensajeSeguro = HttpUtility.JavaScriptStringEncode(ex.Message);
                ScriptManager.RegisterStartupScript(this, this.GetType(), "msg", $"errorTicket('{mensajeSeguro}');", true);
            }
        }

        private void SettearNombreEmpleado()
        {
            try
            {
                if(Parametros.UserLogin != "")
                {
                    lblUsuarioLogueado.InnerText = "Persona Asignada: " + Parametros.UserLogin;
                    ContEmplAsig.Visible = true;
                }
            }
            catch (Exception ex)
            {
                string mensajeSeguro = HttpUtility.JavaScriptStringEncode(ex.Message);
                ScriptManager.RegisterStartupScript(this, this.GetType(), "msg", $"errorTicket('{mensajeSeguro}');", true);
            }
        }

        private void RegistrarTicket()
        {
            if (string.IsNullOrWhiteSpace(txtNombre.Text) ||
                string.IsNullOrWhiteSpace(txtApellido.Text))
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "msg",
                    "errorTicket('Completa todos los campos')", true);
                return;
            }

            Logica logica = new Logica();
            Turismo turismo = new Turismo();

            try
            {
                turismo.Nombres = txtNombre.Text.Trim();
                turismo.Apellidos = txtApellido.Text.Trim();
                turismo.Nacionalidad = ddlNacionalidad.SelectedValue[0];

                if(turismo.Nacionalidad == 'N') turismo.PrecioBoleta = Parametros.PrecioNacional;
                else if (turismo.Nacionalidad == 'E') turismo.PrecioBoleta = Parametros.PrecioInternacional;
                else turismo.PrecioBoleta = Parametros.PrecioEstudiante;

                bool respuesta = logica.RegistrarTurista(turismo);

                if (respuesta)
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "ok", "imprimirExito();", true);            
                else
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "err", "errorTicket('No se pudo registrar el ingreso, contacte con soporte');", true);

            }
            catch (Exception ex)
            {
                string mensajeSeguro = HttpUtility.JavaScriptStringEncode(ex.Message);
                ScriptManager.RegisterStartupScript(this, this.GetType(), "msg", $"errorTicket('{mensajeSeguro}');", true);                
            }
        }

        protected void IngresarLogin(object sender, EventArgs e)
        {
            string Dni = txtDni.Text.Trim();
            string Password = txtPassword.Text.Trim();
            //if (string.IsNullOrEmpty(Dni) || string.IsNullOrEmpty(Password))
            //{
            //    MostrarError("Complete todos los campos");
            //    return;
            //}
            //if (!System.Text.RegularExpressions.Regex.IsMatch(Dni, @"^\d{8}$"))
            //{
            //    MostrarError("El DNI debe tener 8 dígitos");
            //    return;
            //}
            try
            {
                Administrador admin = new Administrador
                {
                    //Dni = Dni,
                    //Password = Password
                    Dni = "72557870",
                    Password = "planetas159"
                };
                Logica logica = new Logica();
                bool acceso = logica.VerificarLogin(admin);
                if (acceso)
                {
                    Session["Dni"] = Dni;
                    Response.Redirect("VistaAdministrador.aspx");
                }
                else
                {
                    MostrarError("DNI o contraseña incorrectos");
                }
            }
            catch
            {
                MostrarError("Ocurrió un error al intentar iniciar sesión");
            }
        }

        private void MostrarError(string mensaje)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "msg", $"errorTicket('{mensaje.Replace("'", "").Replace("\"", "")}')", true);
        }

        private void ActualizarRegistro()
        {
            try
            {
                Logica logica = new Logica();
                Turismo turismo = new Turismo();
                turismo.Id_Turista = int.Parse(IdIngresoEdit.Value);
                turismo.Nombres = txtEditNombre.Value;
                turismo.Apellidos = txtEditApellido.Value;
                turismo.Nacionalidad = ddlEditNacionalidad.SelectedValue[0];

                if (turismo.Nacionalidad == 'N') turismo.PrecioBoleta = Parametros.PrecioNacional;
                else if (turismo.Nacionalidad == 'E') turismo.PrecioBoleta = Parametros.PrecioInternacional;
                else turismo.PrecioBoleta = Parametros.PrecioEstudiante;

                bool respuesta = logica.ActualizarTurista(turismo);

                if (respuesta)
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "ok", "imprimirExito();", true);
                else
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "err", "errorTicket('No se pudo actualizar el ingreso, contacte con soporte');", true);
            }
            catch (Exception ex)
            {
                string mensajeSeguro = HttpUtility.JavaScriptStringEncode(ex.Message);
                ScriptManager.RegisterStartupScript(this, this.GetType(), "msg", $"errorTicket('{mensajeSeguro}');", true);
            }
        }
    }
}