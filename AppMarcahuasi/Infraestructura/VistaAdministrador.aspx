<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="VistaAdministrador.aspx.cs" Inherits="AppMarcahuasi.Infraestructura.VistaAdministrador" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>Administrador</title>

    <script>
        function exportarExcel() {
            document.getElementById('Accion').value = "EXP_EXCEL";
            document.forms[0].submit();
        }
    </script>

</head>
<body>
    <form id="form1" runat="server">

        <input id="txtfechaInicio" runat="server" type="date" />
        <input id="txtfechaFin" runat="server" type="date" />

        <asp:RadioButtonList ID="Nacionalidad" runat="server">
            <asp:ListItem Value="N">Nacional</asp:ListItem>
            <asp:ListItem Value="E">Extranjero</asp:ListItem>
            <asp:ListItem Value="T" Selected="True">Todos</asp:ListItem>
        </asp:RadioButtonList>

        <button type="submit" onclick="exportarExcel()" >Exportar Excel</button>

        <asp:HiddenField ID="Accion" runat="server" Value="" />

    </form>
</body>
</html>
