<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="VistaPrincipal.aspx.cs" Inherits="AppMarcahuasi.Infraestructura.VistaPrincipal" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<title>Sistema de Registro de Turistas</title>

    <link href="../stilos/bootstrap.min.css" rel="stylesheet" />
    <script src="../javascript/bootstrap.bundle.min.js"></script>
<%--<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />--%>
   <%-- <link href="../fonts/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">--%>
    <%--<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">--%>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<style>
    body {
        background-color: #f5f7fa;
        transition: all 0.3s ease;
    }
    .navbar-custom {
        background-color: #2c3e50;
    }
    .card {
        border-radius: 12px;
        transition: all 0.3s ease;
    }
    .table thead {
        background-color: #2c3e50;
        color: white;
    }

    /* MODO OSCURO */
    body.dark-mode {
        background-color: #1e1e1e;
        color: #ffffff;
    }
    body.dark-mode .card {
        background-color: #2c2c2c;
        color: white;
    }
    body.dark-mode .table {
        color: white;
    }
    body.dark-mode .table thead {
        background-color: #000;
    }
    body.dark-mode .form-control,
    body.dark-mode .form-select {
        background-color: #3a3a3a;
        color: white;
        border-color: #555;
    }
    body.dark-mode .navbar-custom {
        background-color: #000 !important;
    }

    .theme-btn {
        border-radius: 20px;
    }
</style>
    <script>
        const PrecioNacional = <%= PrecioNacional %>;
        const PrecioInternacional = <%= PrecioInternacional %>;

        function imprimirExito() {
            Swal.fire({
                title: "Resgistro exitoso!",
                text: "Marcahuasi 2026",
                icon: "success",
                confirmButtonText: "OK"
            })
        }
        //function errorTicket() {
        //    Swal.fire({
        //        icon: "error",
        //        title: "Oops... Algo salio mal",
        //        html: ` <small>Contacta soporte si el problema persiste.</small>`,
        //    });
        //}
        function errorTicket(texto) {
            console.log(texto)
            return 
            Swal.fire({
                icon: "error",
                title: "Oops... Algo salio mal",
                html: ` <small>' + texto + '</small> `,
            });
        }
        function registrarTicket() {
            document.forms[0].submit();
        }
        function asignarPrecio() {
            const nacionalidad = document.getElementById("ddlNacionalidad").value;
            const precioInput = document.getElementById("txtPrecio");

            switch (nacionalidad) {
                case "Nacional":
                    precioInput.value = PrecioNacional.toFixed(2);
                    break;
                case "Extranjero":
                    precioInput.value = PrecioInternacional.toFixed(2);
                    break;
                default:
                    precioInput.value = "";
            }
        }

        document.addEventListener("DOMContentLoaded", function () {
            asignarPrecio();
        });
    </script>
</head>

<body>
<form id="form1" runat="server">
    <nav class="navbar navbar-expand-lg navbar-dark navbar-custom">
        <div class="container-fluid">
            <a class="navbar-brand fw-bold" href="#">Marcahuasi Tours</a>
            <!--------------------------- Login ------------------->
            <div class="d-flex align-items-center ms-auto gap-3">
               <div>
                    <button id="Login" runat="server" onclick="registrarTicket()"
                    class="btn btn-success px-4" type="button" >Login </button>
                </div>

                <span class="navbar-text text-white d-none d-md-block">
                    Sistema de Registro
                </span>
                <button type="button" class="btn btn-outline-light theme-btn" onclick="toggleTheme()">
                    <i id="themeIcon" class="bi bi-moon-fill"></i>
                </button>
            </div>
        </div>
    </nav>
    <div style=" background-color:white; width:500px; height:80vh; margin:0 auto; position:absolute; z-index:10; border:1px solid black; left:0; right:0">
      
    <style>
        bodyD {
            display: flex;
            align-items: center;
            justify-content: center;
            color: #111827;
        }
        .login-container {
            background-color: #ffffff;
            border-radius: 16px;
            padding: 48px;
            width: 100%;
            max-width: 400px;
            box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.05), 0 4px 6px -2px rgba(0, 0, 0, 0.025);
            animation: fadeIn 0.5s ease-out forwards;
        }
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(10px); }
            to { opacity: 1; transform: translateY(0); }
        }
        @keyframes shake {
            0%, 100% { transform: translateX(0); }
            20%, 60% { transform: translateX(-5px); }
            40%, 80% { transform: translateX(5px); }
        }
        .login-header {
            margin-bottom: 32px;
            text-align: left;
        }
        .login-header h1 {
            font-size: 26px;
            font-weight: 600;
            color: #111827;
            margin-bottom: 8px;
            letter-spacing: -0.02em;
        }
        .login-header p {
            font-size: 15px;
            color: #6b7280;
        }
        .input-group {
            margin-bottom: 24px;
        }
        .input-group label {
            display: block;
            font-size: 14px;
            font-weight: 500;
            color: #374151;
            margin-bottom: 8px;
        }
        .input-group input {
            width: 100%;
            padding: 12px 16px;
            background-color: #ffffff;
            border: 1px solid #d1d5db;
            border-radius: 8px;
            font-size: 15px;
            color: #111827;
            transition: all 0.2s ease;
            outline: none;
        }
        .input-group input::placeholder {
            color: #9ca3af;
        }
        .input-group input:focus {
            border-color: #000000;
            box-shadow: 0 0 0 1px #000000;
        }
        .submit-btn {
            width: 100%;
            padding: 14px;
            background-color: #111827;
            color: #ffffff;
            border: none;
            border-radius: 8px;
            font-size: 15px;
            font-weight: 500;
            cursor: pointer;
            transition: background-color 0.2s ease, transform 0.1s ease;
            margin-top: 8px;
        }
        .submit-btn:hover {
            background-color: #374151;
        }
        .submit-btn:active {
            transform: scale(0.98);
        }
        .submit-btn:disabled {
            opacity: 0.7;
            cursor: not-allowed;
            transform: none;
        }
        .message {
            margin-top: 16px;
            text-align: center;
            font-size: 14px;
            min-height: 20px;
            font-weight: 500;
        }
        .message.error {
            color: #ef4444;
        }
        .message.success {
            color: #10b981; 
        }
    </style>
        <bodyD>
            <div class="login-container">
                <div class="login-header">
                    <h1>Acceder a tu cuenta</h1>
                    <p>Ingresa tu DNI y contraseña</p>
                </div>
                <form id="loginForm">
                    <div class="input-group">
                        <label for="dni">DNI</label>
                        <input type="text" id="dni" placeholder="Ej. 12345678" maxlength="8" autocomplete="off">
                    </div>
                    <div class="input-group">
                        <label for="password">Contraseña</label>
                        <input type="password" id="password" placeholder="Tu contraseña" autocomplete="new-password">
                    </div>
                    <button type="submit" class="submit-btn" id="submitBtn">
                        Iniciar Sesión
                    </button>
                    <div id="statusMessage" class="message"></div>
                </form>
            </div>
            <script>
                document.addEventListener('DOMContentLoaded', () => {
                    const dniInput = document.getElementById('dni');
                    const form = document.querySelector('form');

                    dniInput.addEventListener('input', function () {
                        this.value = this.value.replace(/\D/g, '');
                    });

                    form.addEventListener('submit', function (e) {
                        if (dniInput.value.length !== 8) {
                            e.preventDefault();
                            alert('El DNI debe tener 8 números');
                            dniInput.focus();
                        }
                    });
                });
            </script>
        </bodyD>
    </div>

    <div class="container mt-5">
        <div class="card shadow mb-4">
            <div class="card-header">
                <h5 class="mb-0">Registro de Turista</h5>
            </div>
            <div class="card-bodyD">
                <div class="row">
                    <div class="col-md-4 mb-3">
                        <label class="form-label">Nombre</label>
                        <asp:TextBox ID="txtNombre" runat="server" CssClass="form-control" placeholder="Ingrese nombre" />
                    </div>

                    <div class="col-md-4 mb-3">
                        <label class="form-label">Apellido</label>
                        <asp:TextBox ID="txtApellido" runat="server" CssClass="form-control" placeholder="Ingrese apellido" />
                    </div>
                    <div class="col-md-4 mb-3">
                        <label class="form-label">Nacionalidad</label>
                        <asp:DropDownList 
                            ID="ddlNacionalidad" 
                            runat="server" 
                            CssClass="form-select"
                            onchange="asignarPrecio()">

                            <asp:ListItem Text="Nacional" Value="Nacional" Selected="True" />
                            <asp:ListItem Text="Extranjero" Value="Extranjero" />
                        </asp:DropDownList>
                    </div>

                    <div class="col-md-4 mb-3">
                        <label class="form-label">Precio (S/)</label>
                        <asp:TextBox ID="txtPrecio"  runat="server"  CssClass="form-control" ReadOnly="true" />
                    </div>
                </div>
                <div class="text-end">
                    <button id="btnGuardar" runat="server" onclick="registrarTicket()"
                        class="btn btn-success px-4" type="button" >Registrar </button>
                </div>
            </div>
        </div>
        <!--------------------------- TABLA ------------------->
        <div class="card shadow">
            <div class="card-header">
                <h5 class="mb-0">Lista de Turistas</h5>
            </div>
            <div class="card-body">
                <asp:GridView ID="gvTuristas" runat="server"
                    CssClass="table table-bordered table-hover text-center"
                    AutoGenerateColumns="false"
                    ShowHeaderWhenEmpty="true">
                    <Columns>
                        <asp:BoundField DataField="Nombres" HeaderText="Nombres" />
                        <asp:BoundField DataField="Apellidos" HeaderText="Apellidos" />
                        <asp:TemplateField HeaderText="Nacionalidad">
                            <ItemTemplate>
                                <asp:DropDownList 
                                    ID="ddlGridNacionalidad" 
                                    runat="server" 
                                    CssClass="form-select"
                                    onchange ="asignarPrecio()"
                                    Enabled ="false">
                                    <asp:ListItem Text="Nacional" Value="Nacional" />
                                    <asp:ListItem Text="Extranjero" Value="Extranjero" />
                                </asp:DropDownList >
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="PrecioBoleta" HeaderText="PrecioBoleta" />
                        <asp:BoundField DataField="" HeaderText="" />
                    </Columns>
                </asp:GridView>
            </div>
        </div>
    </div>
</form>

<%--<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>--%>

<script>
    

</script>
<script>
    function toggleTheme() {
        const body = document.body;
        const icon = document.getElementById("themeIcon");

        body.classList.toggle("dark-mode");

        if (body.classList.contains("dark-mode")) {
            localStorage.setItem("theme", "dark");
            icon.classList.remove("bi-moon-fill");
            icon.classList.add("bi-sun-fill");
        } else {
            localStorage.setItem("theme", "light");
            icon.classList.remove("bi-sun-fill");
            icon.classList.add("bi-moon-fill");
        }
    }

    window.onload = function () {
        const theme = localStorage.getItem("theme");
        const icon = document.getElementById("themeIcon");

        if (theme === "dark") {
            document.body.classList.add("dark-mode");
            icon.classList.remove("bi-moon-fill");
            icon.classList.add("bi-sun-fill");
        }
    }
</script>
</body>
</html>