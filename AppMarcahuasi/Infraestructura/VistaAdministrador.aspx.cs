using Antlr.Runtime.Misc;
using AppMarcahuasi.Entities;
using AppMarcahuasi.Procedimientos;
using ClosedXML.Excel;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AppMarcahuasi.Infraestructura
{
    public partial class VistaAdministrador : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                
            }
            else
            {
                if (Accion.Value == "EXP_EXCEL")
                {
                    ObtenerListadoTuristas();
                }
            }
        }

        public void ObtenerListadoTuristas()
        {
            try
            {
                Logica logica = new Logica();

                DateTime fechaInicio = new DateTime(1753, 1, 1);
                DateTime fechaFin = new DateTime(9999, 12, 31);
                string filtroNacionalidad = "";

                if (txtfechaInicio.Value != "")
                    fechaInicio = DateTime.Parse(txtfechaInicio.Value);

                if (txtfechaFin.Value != "")
                    fechaFin = DateTime.Parse(txtfechaFin.Value);

                if (Nacionalidad.SelectedValue != "T")
                    filtroNacionalidad = Nacionalidad.SelectedValue;

                List<Turismo> listado = new List<Turismo>();
                listado = logica.ListarTuristas(fechaInicio, fechaFin, filtroNacionalidad);
                ExportarExcel(listado, fechaInicio, fechaFin);
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "msg", "errorTicket('" + ex.Message.Replace("'", "").Replace("\"", "") + "')", true);
            }
        }

        public void ExportarExcel(List<Turismo> lista, DateTime fechaInicio, DateTime fechaFin)
        {
            string colorCabecera = "#224275";
            string colorLetraCabecera = "#FFFFFF";

            using (var workbook = new XLWorkbook())
            {
                var prueba = workbook.Worksheets.Add("LISTADO TURISTAS");

                int nFila = 1;
                int nColumna = 1;
                string rango = "";

                #region cabecera
                prueba.Range("A1:E1").Merge();
                prueba.Range("A1:E1").Value = "LISTADO DE TURISTAS PARA CONTROL DEL " + fechaInicio.ToShortDateString() + " AL " + fechaFin.ToShortDateString();
                prueba.Range("A1:E1").Style.Font.Bold = true;
                prueba.Range("A1:E1").Style.Font.FontSize = 15;



                nFila = nFila + 2;
                string[] textosCabecera = new string[] { "Numero", "Nombres", "Apellidos", "Correlativo", "Nacionalidad", "Precio", "Fecha Ingreso", "Usuario Registra" };

                foreach (string item in textosCabecera)
                {
                    prueba.Cell(nFila, nColumna).Value = item;
                    nColumna++;
                }

                rango = string.Format("A{0}:H{0}", nFila);
                prueba.Range(rango).Style.Fill.BackgroundColor = XLColor.FromHtml(colorCabecera);
                prueba.Range(rango).Style.Font.FontColor = XLColor.FromHtml(colorLetraCabecera);
                prueba.Range(rango).Style.Font.Bold = true;
                prueba.Range(rango).Style.Alignment.Horizontal = XLAlignmentHorizontalValues.Center;
                prueba.Range(rango).Style.Alignment.Vertical = XLAlignmentVerticalValues.Center;

                rango = string.Format("D{0}:D{0}", nFila);
                prueba.Range(rango).Style.Fill.BackgroundColor = XLColor.FromHtml("#538dd5");
                prueba.Row(3).Height = 23;
                #endregion

                #region tabla

                int xCont = 0;
                int xMontoAcumulado = 0;

                foreach (Turismo item in lista)
                {
                    nFila++;
                    nColumna = 1;
                    xCont++;
                    xMontoAcumulado += item.PrecioBoleta;

                    prueba.Cell(nFila, nColumna++).Value = xCont;
                    prueba.Cell(nFila, nColumna++).Value = item.Nombres;
                    prueba.Cell(nFila, nColumna++).Value = item.Apellidos;
                    prueba.Cell(nFila, nColumna++).Value = item.Correlativo;
                    prueba.Cell(nFila, nColumna++).Value = (item.Nacionalidad.ToString() == "N" ? "Nacional" : "Extranjero");
                    prueba.Cell(nFila, nColumna++).Value = item.PrecioBoleta;
                    prueba.Cell(nFila, nColumna - 1).Style.NumberFormat.Format = "0.00";
                    prueba.Cell(nFila, nColumna++).Value = item.Fecha_Registro.ToString("dd-MM-yyyy  hh:mm tt");
                    prueba.Cell(nFila, nColumna++).Value = item.Usuario_Registro;
                }
                #endregion

                #region tabla inferior
                nFila = nFila + 2;
                nColumna = 5;
                string colorFondoItemInferior = "#92d150";

                prueba.Cell(nFila, nColumna).Value = "Total";
                prueba.Cell(nFila, nColumna).Style.Fill.BackgroundColor = XLColor.FromHtml(colorFondoItemInferior);

                nColumna++;
                prueba.Cell(nFila, nColumna).Value = xMontoAcumulado;
                prueba.Cell(nFila, nColumna).Style.NumberFormat.Format = "0.00";

                #endregion

                #region estilos
                rango = "A3:H" + (nFila - 2);
                prueba.Range(rango).Style.Border.OutsideBorder = XLBorderStyleValues.Thin;
                prueba.Range(rango).Style.Border.InsideBorder = XLBorderStyleValues.Thin;

                rango = "E" + nFila + ":F" + nFila;
                prueba.Range(rango).Style.Border.OutsideBorder = XLBorderStyleValues.Thin;
                prueba.Range(rango).Style.Border.InsideBorder = XLBorderStyleValues.Thin;

                prueba.Column("A").Width = 10;
                prueba.Columns("A,D,E,G,H").Style.Alignment.Horizontal = XLAlignmentHorizontalValues.Center;
                prueba.Columns("B:C").Width = 30;
                prueba.Columns("D:E").Width = 15;
                prueba.Column("D").Style.Font.Bold = true;
                prueba.Column("F").Width = 12;
                prueba.Column("G").Width = 25;
                prueba.Column("H").Width = 20;
                prueba.Range("A1:E1").Style.Alignment.Horizontal = XLAlignmentHorizontalValues.Left;

                #endregion

                // Descargar
                Response.Clear();
                Response.Buffer = true;
                Response.Charset = "";
                Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
                Response.AddHeader("content-disposition", "attachment;filename=ReporteTuristasMarcahuasi.xlsx");

                using (MemoryStream memo = new MemoryStream())
                {
                    workbook.SaveAs(memo);
                    Response.BinaryWrite(memo.ToArray());
                    Response.Flush();
                    Response.End();
                }

            }
        }

    }
}