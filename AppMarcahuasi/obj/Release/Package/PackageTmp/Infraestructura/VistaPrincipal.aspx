<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="VistaPrincipal.aspx.cs"
    Inherits="AppMarcahuasi.Infraestructura.VistaPrincipal" %>
    <!DOCTYPE html>
    <html xmlns="http://www.w3.org/1999/xhtml">
    <head runat="server">
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <title>Sistema de Registro de Turistas</title>

        <link href="../stilos/bootstrap.min.css" rel="stylesheet" />
        <script src="../javascript/bootstrap.bundle.min.js"></script>
        <script src="../scripts/sweetalert2.all.min.js"></script>

        <style>

            :root {
                --primary-color: #0f4c81;
                --primary-hover: #0a355c;
                --bg-light: #f4f7f6;
                --text-main: #111827;
                --text-muted: #4b5563;
                --card-bg: #ffffff;
                --border-color: #94a3b8;
                --focus-ring: rgba(15, 76, 129, 0.25);
                --font-base: system-ui, -apple-system, sans-serif;
            }

            body.dark-mode {
                --primary-color: #3b82f6;
                --primary-hover: #60a5fa;
                --bg-light: #121212;
                --text-main: #f8fafc;
                --text-muted: #cbd5e1;
                --card-bg: #1e1e1e;
                --border-color: #475569;
                --focus-ring: rgba(59, 130, 246, 0.35);
            }

            body {
                background-color: var(--bg-light);
                color: var(--text-main);
                font-family: var(--font-base);
                font-size: 18px;
                transition: background-color 0.3s ease, color 0.3s ease;
                margin: 0;
            }

            .navbar-custom {
                background-color: #0f4c81 !important;
                padding: 15px 0;
            }

            body.dark-mode .navbar-custom {
                background-color: #000000 !important;
            }

            .navbar-brand {
                font-size: 30px;
                margin-left: 20px;
                font-weight: 700;
                letter-spacing: 0.5px;
            }

            .theme-btn {
                border-radius: 50%;
                width: 45px;
                height: 45px;
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 1.2rem;
            }

            .card {
                background-color: var(--card-bg);
                border: 1px solid var(--border-color);
                border-radius: 12px;
                box-shadow: 0 4px 10px rgba(0, 0, 0, 0.08);
                margin-bottom: 2rem;
                transition: all 0.3s ease;
            }

            .card-header {
                background-color: rgba(0, 0, 0, 0.03);
                border-bottom: 1px solid var(--border-color);
                padding: 1.25rem 1.5rem;
            }

            body.dark-mode .card-header {
                background-color: rgba(255, 255, 255, 0.05);
            }

            .card-header h5 {
                font-size: 1.4rem;
                font-weight: 700;
                margin: 0;
                color: var(--text-main);
            }

            .card-body,
            .card-bodyD {
                padding: 2rem;
            }

            .form-label {
                font-size: 1.15rem;
                font-weight: 600;
                color: var(--text-main);
                margin-bottom: 0.6rem;
            }

            .form-control,
            .form-select {
                font-size: 1.15rem;
                padding: 0.8rem 1rem;
                border: 2px solid var(--border-color);
                border-radius: 8px;
                background-color: var(--card-bg);
                color: var(--text-main);
                transition: all 0.2s;
                box-shadow: none;
            }

            .form-control:focus,
            .form-select:focus {
                border-color: var(--primary-color);
                box-shadow: 0 0 0 5px var(--focus-ring);
                outline: none;
            }

            .form-control:read-only {
                background-color: rgba(0, 0, 0, 0.05);
            }

            body.dark-mode .form-control:read-only {
                background-color: rgba(255, 255, 255, 0.05);
            }

            .btn {
                font-size: 1.15rem;
                font-weight: 600;
                padding: 0.8rem 1.5rem;
                border-radius: 8px;
                transition: all 0.2s;
            }

            .btn-success {
                background-color: #16a34a;
                border-color: #16a34a;
                color: white;
            }

            .btn-success:hover {
                background-color: #15803d;
                border-color: #15803d;
                transform: translateY(-2px);
            }

            body.dark-mode .btn-success {
                background-color: #22c55e;
                color: #000;
            }

            body.dark-mode .btn-success:hover {
                background-color: #16a34a;
                color: white;
            }

            .table {
                color: var(--text-main);
                font-size: 1.1rem;
            }

            .table thead {
                background-color: var(--primary-color);
                color: white;
            }

            body.dark-mode .table thead {
                background-color: #000000;
            }

            .table-bordered th,
            .table-bordered td {
                border: 1px solid var(--border-color);
            }

            .table th {
                padding: 1rem;
                font-size: 1.15rem;
                font-weight: 600;
                border: none;
            }

            .table td {
                padding: 1rem;
                vertical-align: middle;
            }

            #mostrarInicioSesion {
                opacity: 0;
                visibility: hidden;
                transition: all 0.3s ease;
                position: fixed;
                top: 0;
                left: 0;
                right: 0;
                bottom: 0;
                background-color: rgba(0, 0, 0, 0.75);
                z-index: 9999;
                display: flex;
                align-items: center;
                justify-content: center;
                backdrop-filter: blur(4px);
            }

            #mostrarInicioSesion.show {
                opacity: 1;
                visibility: visible;
            }

            .login-container {
                background-color: var(--card-bg);
                border: 1px solid var(--border-color);
                border-radius: 16px;
                padding: 3rem;
                width: 100%;
                max-width: 480px;
                box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.25);
                transform: translateY(20px);
                transition: transform 0.3s ease;
            }

            #mostrarInicioSesion.show .login-container {
                transform: translateY(0);
            }

            .login-header {
                margin-bottom: 30px;
                text-align: left;
            }

            .login-header h1 {
                font-size: 2.2rem;
                font-weight: 700;
                color: var(--text-main);
                margin-bottom: 0.5rem;
            }

            .login-header p {
                font-size: 1.2rem;
                color: var(--text-muted);
                text-align: left;
            }

            .login-field {
                margin-bottom: 1.2rem;
            }

            .login-field label {
                display: block;
                font-size: 1.15rem;
                font-weight: 600;
                color: var(--text-main);
                margin-bottom: 0.5rem;
            }

            .login-field input {
                width: 100%;
                padding: 1rem 1.2rem;
                font-size: 1.15rem;
                background-color: var(--card-bg);
                border: 2px solid var(--border-color);
                border-radius: 8px;
                color: var(--text-main);
                transition: all 0.2s ease;
            }

            .login-field input:focus {
                border-color: var(--primary-color);
                box-shadow: 0 0 0 5px var(--focus-ring);
                outline: none;
            }

            .submit-btn {
                width: 100%;
                padding: 1.1rem;
                background-color: var(--primary-color);
                color: #ffffff;
                border: none;
                border-radius: 8px;
                font-size: 1.2rem;
                font-weight: 600;
                cursor: pointer;
                transition: all 0.2s;
                margin-top: 10px;
                margin-bottom: 10px;
            }

            .submit-btn:hover {
                background-color: var(--primary-hover);
                transform: translateY(-2px);
            }

            #cerrarBtn {
                background-color: transparent;
                color: var(--text-main);
                border: 2px solid var(--border-color);
            }

            #cerrarBtn:hover {
                background-color: rgba(0, 0, 0, 0.05);
                transform: none;
            }

            body.dark-mode #cerrarBtn {
                border-color: var(--border-color);
            }

            body.dark-mode #cerrarBtn:hover {
                background-color: rgba(255, 255, 255, 0.05);
            }

            .bordeCeleste {
                border: 1px solid #94a3b8
            }

            .floating-support {
                position: fixed;
                bottom: 20px;
                left: 20px;
                background-color: var(--primary-color);
                color: #ffffff;
                padding: 12px 20px;
                border-radius: 30px;
                display: flex;
                align-items: center;
                gap: 12px;
                font-size: 1.15rem;
                font-weight: 600;
                box-shadow: 0 6px 12px rgba(0, 0, 0, 0.15);
                z-index: 1000;
                transition: transform 0.2s, background-color 0.2s;
                cursor: default;
            }

            .floating-support:hover {
                background-color: var(--primary-hover);
                transform: translateY(-3px);
            }

            body.dark-mode .floating-support {
                background-color: #1e1e1e;
                color: #e2e8f0;
                border: 1px solid var(--border-color);
            }

            .floating-user {
                position: fixed;
                bottom: 20px;
                right: 20px;
                background-color: var(--card-bg);
                color: var(--text-main);
                border: 1px solid var(--border-color);
                padding: 12px 20px;
                border-radius: 30px;
                display: flex;
                align-items: center;
                gap: 12px;
                font-size: 1.15rem;
                font-weight: 600;
                box-shadow: 0 6px 12px rgba(0, 0, 0, 0.15);
                z-index: 1000;
                transition: transform 0.2s, background-color 0.2s;
                cursor: default;
            }

            .floating-user:hover {
                transform: translateY(-3px);
            }

            body.dark-mode .floating-user {
                background-color: #1e1e1e;
                color: #e2e8f0;
                border: 1px solid var(--border-color);
            }

            .support-icon {
                flex-shrink: 0;
                width: 28px;
                height: 28px;
            }

            .btn-edit {
                border: none;
                background: transparent;
                color: var(--primary-color);
                padding: 0.4rem 0.6rem;
                display: inline-flex;
                align-items: center;
                justify-content: center;
                border-radius: 6px;
                transition: all 0.2s;
            }

            .btn-edit:hover {
                background-color: rgba(0, 0, 0, 0.05);
                color: var(--primary-hover);
            }

            body.dark-mode .btn-edit:hover {
                background-color: rgba(255, 255, 255, 0.1);
            }
        </style>

        <script>
            const PrecioNacional = <%= PrecioNacional %>;
            const PrecioInternacional = <%= PrecioInternacional %>;
            const PrecioEstudiante = <%= PrecioEstudiante %>;

            function soloNumeros(e) {
                var char = e.key;
                return /^[0-9]$/.test(char);
            }

            function iniciarSession() {
                document.getElementById('mostrarInicioSesion').classList.add("show");
            }

            function ocultarInicioSesion() {
                document.getElementById('mostrarInicioSesion').classList.remove("show");
            }

            function imprimirExito() {
                Swal.fire({
                    title: "¡Registro exitoso!",
                    text: "Marcahuasi 2026",
                    icon: "success",
                    showConfirmButton: false,
                    timer: 2000,  
                    timerProgressBar: true
                })
                setTimeout(function () {
                    window.location.href = "VistaPrincipal.aspx";
                }, 2000)
            }

            function errorTicket(texto) {
                Swal.fire({
                    icon: "error",
                    title: "Oops... Algo salió mal",
                    html: `<small style="font-size:20px">` + texto + `</small>`
                });
            }

            //-------------------------------configuracion para la impresion terminca--------------------------
            function imprimirDirecto() {
                const Nombre = document.getElementById('txtNombre')?.value;
                const Apellido = document.getElementById('txtApellido')?.value;
                const cboNacionalidad = document.getElementById('ddlNacionalidad');
                const Nacionalidad = cboNacionalidad.options[cboNacionalidad.selectedIndex].text;
                let precio = 0;
                if (Nacionalidad == "Nacional") {
                    precio = 20;
                }
                else if (Nacionalidad == "Extranjero") {
                    precio = 25;
                }
                else
                    precio = 15;

                let mensajeError = "";

                if (Nombre.trim() == "")
                    mensajeError += "*Ingrese el nombre ";
                if (Apellido.trim() == "")
                    mensajeError += "*Ingrese el apellido";

                if (mensajeError != "") {
                    errorTicket(mensajeError);
                    return;
                }

                try {
                    const iframe = document.getElementById('iframeImpresion');

                    if (!iframe) {
                        throw new Error("No existe el iframe");
                    }
                    const doc = iframe.contentWindow.document;
                    iframe.onload = function () {
                        iframe.contentWindow.focus();
                        iframe.contentWindow.print();
                        registrarTicket();
                    };
                    doc.open();
                    doc.write(`
                    <html>
                    <style>
                        @page { margin: 0;
                            size: 80mm auto }
                        body {
                            font-family: 'Courier New', monospace;
                            width: 70mm;
                            margin: 0;
                            padding: 5px;
                            text-align: center;
                        }

                        .logo {
                            width: 100%;
                            max-height: 80px; /* 🔥 limita altura */
                            object-fit: contain; /* evita deformación */
                        }

                        .title {
                            font-size: 13px;
                            font-weight: bold;
                            margin-top: 5px;
                        }

                        .divider {
                            border-top: 1px dashed #000;
                            margin: 6px 0;
                        }

                        .text {
                            font-size: 12px;
                            line-height: 1.4;
                        }
                    </style>
                </head>
                <body>
                    <!-- IMAGEN CONTROLADA -->
                    <div class="title">COMITÉ COMUNAL DE TURISMO</div>
                    <img src="../image/marcahuasimg.jpg" class="logo">
                    <div class="title">SAN PEDRO DE CASTA</div>

                    <div class="text" id="fechaHora"> </div>
                    

                    <div class="divider"></div>

                    <div class="text">
                        Nombres:       ${Nombre} <br> <br> 
                        Apellidos:     ${Apellido}<br> <br> 
                        Nacionalidad: <strong>${Nacionalidad}</strong><br> <br> 
                        Precio: ${precio}<br> <br> 
                        Fecha:        ${new Date().toLocaleDateString()} ${new Date().toLocaleTimeString() } <br>  <br> 
                    </div>
                    <div class="divider"></div>
                    </body>
                    </html>
                `);
                    doc.close();

                } catch (error) {
                    console.error(error);
                    alert("Error al imprimir");
                }    
            }
            

            function actualizarDirecto() {
                const Nombre = document.getElementById('txtEditNombre')?.value;
                const Apellido = document.getElementById('txtEditApellido')?.value;
                const cboNacionalidad = document.getElementById('ddlEditNacionalidad');
                const Nacionalidad = cboNacionalidad.options[cboNacionalidad.selectedIndex].text;
                let precio = 0;
                if (Nacionalidad == "Nacional") {
                    precio = 20;
                }
                else if (Nacionalidad == "Extranjero") {
                    precio = 25;
                }
                else 
                    precio = 15;


                let mensajeError = "";

                if (Nombre.trim() == "")
                    mensajeError += "*Ingrese el nombre ";
                if (Apellido.trim() == "")
                    mensajeError += "*Ingrese el apellido";

                if (mensajeError != "") {
                    errorTicket(mensajeError);
                    return;
                }

                try {
                    const iframe = document.getElementById('iframeImpresion');

                    if (!iframe) {
                        throw new Error("No existe el iframe");
                    }
                    const doc = iframe.contentWindow.document;
                    iframe.onload = function () {
                        iframe.contentWindow.focus();
                        iframe.contentWindow.print();
                        volverAImprimir();
                    };
                    doc.open();
                    doc.write(`
                        <html>
                        <style>
                            @page { margin: 0; 
                               size: 80mm auto }
                            body {
                                font-family: 'Courier New', monospace;
                                width: 70mm;
                                margin: 0;
                                padding: 5px;
                                text-align: center;
                            }

                            .logo {
                                width: 100%;
                                max-height: 80px; /* 🔥 limita altura */
                                object-fit: contain; /* evita deformación */
                            }

                            .title {
                                font-size: 13px;
                                font-weight: bold;
                                margin-top: 5px;
                            }

                            .divider {
                                border-top: 1px dashed #000;
                                margin: 6px 0;
                            }

                            .text {
                                font-size: 12px;
                                line-height: 1.4;
                            }
                        </style>
                    </head>
                    <body>
                        <div class="title">COMITÉ COMUNAL DE TURISMO </div>
                        <img style="padding: 10px;" src="../image/marcahuasimg.jpg" class="logo">
                        <div class="title">SAN PEDRO DE CASTA</div>
                        <div class="divider"></div>

                        <div class="text" style='text-align: left; padding-left: 20px'>
                         Nombres:       ${Nombre} <br> <br> 
                         Apellidos:     ${Apellido}<br> <br> 
                         Nacionalidad: <strong>${Nacionalidad}</strong><br> <br> 
                         Precio: <strong><h3 style='display: inline'> S/ ${precio}</h3></strong><br> <br> 
                         Fecha:        ${new Date().toLocaleDateString()} ${new Date().toLocaleTimeString() } <br> <br> 
                        </div>
                        <div class="divider"></div>
                        </body>
                        </html>
                    `);
                    doc.close();

                } catch (error) {
                    console.error(error);
                    alert("Error al imprimir");
                }
            }
            //----------------------------------------------------fin-------------------------------------
            function registrarTicket() {                
                document.getElementById('Accion').value = "REGISTRAR";
                document.forms[0].submit();                
            }

            function asignarPrecio() {
                const ddlNacionalidad = document.getElementById("ddlNacionalidad");
                const precioInput = document.getElementById("txtPrecio");

                if (ddlNacionalidad && precioInput) {
                    const nacionalidad = ddlNacionalidad.value;
                    switch (nacionalidad) {
                        case "N":
                            precioInput.value = PrecioNacional.toFixed(2);
                            break;
                        case "E":
                            precioInput.value = PrecioInternacional.toFixed(2);
                            break;
                        case "S":
                            precioInput.value = PrecioEstudiante.toFixed(2);
                            break;
                        default:
                            precioInput.value = "0.00";
                    }
                }
            }

            function abrirModalEdicion(boton) {
                var fila = boton.closest('tr');
                if (!fila) return;

                var nombre = fila.cells[0].innerText.trim();
                var apellido = fila.cells[1].innerText.trim();

                var dropDownListOriginal = fila.querySelector('select');
                var nacionalidad = dropDownListOriginal ? dropDownListOriginal.value : 'N';

                document.getElementById('txtEditNombre').value = nombre;
                document.getElementById('txtEditApellido').value = apellido;

                var ddlModalNacionalidad = document.querySelector('select[id*="ddlEditNacionalidad"]');
                if (ddlModalNacionalidad) {
                    ddlModalNacionalidad.value = nacionalidad;
                }

                var myModal = new bootstrap.Modal(document.getElementById('modalEdicion'));
                myModal.show();
            }

            function volverAImprimir() {
                document.getElementById('Accion').value = "ACTUALIZAR";
                document.forms[0].submit();
            }

            function bloquearActualizacion() {
                document.querySelectorAll(".btn-edit").forEach(btn => {
                    btn.removeAttribute("onclick");
                    btn.style.color = "red";
                });
            }

            document.addEventListener('DOMContentLoaded', () => {
                const dniInput = document.getElementById('dni');
                const form = document.querySelector('form');

                asignarPrecio()

                if (dniInput) {
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
                }
            });

        </script>
    </head>
    <body>
        <iframe id="iframeImpresion" style="display: none;"></iframe>

        <form id="form1" runat="server">

            <!----------- CABECERA Inicio ----------->
            <nav class="navbar navbar-expand-lg navbar-dark navbar-custom">
                <div class="container-fluid">
                    <a class="navbar-brand" href="#">Marcahuasi Tours</a>

                    <div class="d-flex align-items-center ms-auto gap-3">

                        <span class="navbar-text text-white d-none d-md-block" style="font-size: 24px; opacity: 0.9;">
                            Sistema de Registro
                        </span>

                        <div>
                            <button id="Login" runat="server" onclick="iniciarSession()"
                                class="btn btn-outline-light px-4" type="button"
                                style="margin-right:20px">Login</button>
                        </div>
                    </div>
                </div>
            </nav>
            <!----------- CABECERA Fin ----------->

            <!----------- MODAL INICIO SESION Inicio ----------->
            <div id="mostrarInicioSesion">
                <div class="login-container">
                    <div class="login-header">
                        <h1>Acceso</h1>
                        <p>Ingresa tu DNI y contraseña</p>
                    </div>
                    <div id="loginForm">
                        <div class="login-field">
                            <label for="txtDni">Documento de Identidad (DNI)</label>
                            <asp:TextBox ID="txtDni" runat="server" CssClass="form-control" placeholder="Ej. 12345678"
                                maxlength="8" autocomplete="off" onkeypress="return soloNumeros(event)" />
                        </div>
                        <div class="login-field">
                            <label for="txtPassword">Contraseña</label>
                            <asp:TextBox ID="txtPassword" TextMode="password" runat="server" CssClass="form-control"
                                placeholder="Tu contraseña" autocomplete="new-password" />
                        </div>

                        <asp:Button ID="btnLogin" runat="server" CssClass="submit-btn" Text="Iniciar Sesión"
                            OnClick="IngresarLogin" />

                        <button type="button" class="submit-btn" id="cerrarBtn" onclick="ocultarInicioSesion()">
                            Cerrar Ventana
                        </button>
                        <div id="statusMessage" class="message"></div>
                    </div>
                </div>
            </div>
            <!----------- MODAL INICIO SESION Fin ----------->

            <!----------- FORMULARIO REGISTRO Inicio ----------->
            <div class="container mt-4">
                <div class="card mb-5">
                    <div class="card-header">
                        <h5 style="margin-left:9px">Registro de Turista</h5>
                    </div>
                    <div class="card-bodyD">
                        <div class="row">
                            <div class="col-md-4 mb-4">
                                <label class="form-label" style="margin-left:6px">Nombre del Turista</label>
                                <asp:TextBox ID="txtNombre" runat="server" CssClass="form-control"
                                    placeholder="Ingrese nombre" />
                            </div>

                            <div class="col-md-4 mb-4">
                                <label class="form-label" style="margin-left:6px">Apellido del Turista</label>
                                <asp:TextBox ID="txtApellido" runat="server" CssClass="form-control"
                                    placeholder="Ingrese apellido" />
                            </div>

                            <div class="col-md-4 mb-4">
                                <label class="form-label" style="margin-left:6px">Nacionalidad</label>
                                <asp:DropDownList ID="ddlNacionalidad" runat="server" CssClass="form-select"
                                    onchange="asignarPrecio()">
                                    <asp:ListItem Text="Nacional" Value="N" Selected="True" />
                                    <asp:ListItem Text="Extranjero" Value="E" />
                                    <asp:ListItem Text="Estudiante" Value="S" />
                                </asp:DropDownList>
                            </div>

                            <div class="col-md-4 mb-4">
                                <label class="form-label" style="margin-left:6px">Precio del Ticket (S/)</label>
                                <asp:TextBox ID="txtPrecio" runat="server" CssClass="form-control" ReadOnly="true" />
                            </div>
                        </div>
                        <div class="text-end" style="margin-top: -85px;">
                            <button id="btnGuardar" runat="server" onclick="imprimirDirecto()"
                                class="btn btn-success px-5 py-3" type="button">Registrar Turista</button>
                        </div>
                    </div>
                </div>

                <!--------------------------- TABLA ------------------->
                <div class="card">
                    <div class="card-header">
                        <h5 style="margin-left:9px">Último Ingreso Registrado</h5>
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <asp:GridView ID="gvTuristas" runat="server"
                                CssClass="table table-bordered table-hover text-center bordeCeleste"
                                AutoGenerateColumns="false" ShowHeaderWhenEmpty="true">
                                <Columns>
                                    <asp:BoundField DataField="Nombres" HeaderText="Nombres">
                                        <ItemStyle Width="190px" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="Apellidos" HeaderText="Apellidos">
                                        <ItemStyle Width="190px" />
                                    </asp:BoundField>
                                    <asp:TemplateField HeaderText="Nacionalidad">
                                        <ItemStyle Width="150px" />
                                        <ItemTemplate>
                                            <asp:DropDownList ID="Nacionalidad" runat="server" CssClass="form-select"
                                                onchange="asignarPrecio()" Enabled="false"
                                                SelectedValue='<%# Bind("Nacionalidad") %>'>
                                                <asp:ListItem Text="Nacional" Value="N" />
                                                <asp:ListItem Text="Extranjero" Value="E" />
                                                <asp:ListItem Text="Estudiante" Value="S" />
                                            </asp:DropDownList>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="PrecioBoleta" HeaderText="Monto Pagado">
                                        <ItemStyle Width="70px" />
                                    </asp:BoundField>
                                    <asp:TemplateField HeaderText="Acciones">
                                        <ItemStyle Width="20px" />
                                        <ItemTemplate>
                                            <button type="button" class="btn-edit"
                                                onclick="abrirModalEdicion(this)" title="Editar">
                                                <svg width="20" height="20" fill="currentColor"
                                                    class="bi bi-pencil-square" viewBox="0 0 16 16">
                                                    <path
                                                        d="M15.502 1.94a.5.5 0 0 1 0 .706L14.459 3.69l-2-2L13.502.646a.5.5 0 0 1 .707 0l1.293 1.293zm-1.75 2.456-2-2L4.939 9.21a.5.5 0 0 0-.121.196l-.805 2.414a.25.25 0 0 0 .316.316l2.414-.805a.5.5 0 0 0 .196-.12l6.813-6.814z" />
                                                    <path fill-rule="evenodd"
                                                        d="M1 13.5A1.5 1.5 0 0 0 2.5 15h11a1.5 1.5 0 0 0 1.5-1.5v-6a.5.5 0 0 0-1 0v6a.5.5 0 0 1-.5.5h-11a.5.5 0 0 1-.5-.5v-11a.5.5 0 0 1 .5-.5H9a.5.5 0 0 0 0-1H2.5A1.5 1.5 0 0 0 1 2.5z" />
                                                </svg>
                                            </button>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                        </div>
                    </div>
                </div>
            </div>
            <!----------- FORMULARIO REGISTRO FIN ----------->

            <asp:HiddenField ID="Accion" runat="server" Value="" />
            <asp:HiddenField ID="IdIngresoEdit" runat="server" Value="" />

            <!-- Modal de Edición de Turista -->
            <div class="modal fade" id="modalEdicion" tabindex="-1" aria-labelledby="modalEdicionLabel"
                aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered">
                    <div class="modal-content" style="padding: 20px">
                        <div class="modal-header">
                            <h5 class="modal-title" id="modalEdicionLabel">Editar Información</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal"
                                aria-label="Cerrar"></button>
                        </div>
                        <div class="modal-body">
                            <div class="mb-3">
                                <label for="txtEditNombre" class="form-label">Nombre</label>
                                <input type="text" class="form-control" id="txtEditNombre" runat="server">
                            </div>
                            <div class="mb-3">
                                <label for="txtEditApellido" class="form-label">Apellido</label>
                                <input type="text" class="form-control" id="txtEditApellido" runat="server">
                            </div>
                            <div class="mb-3">
                                <label for="ddlEditNacionalidad" class="form-label">Nacionalidad</label>
                                <asp:DropDownList ID="ddlEditNacionalidad" runat="server" CssClass="form-select">
                                    <asp:ListItem Text="Nacional" Value="N" />
                                    <asp:ListItem Text="Extranjero" Value="E" />
                                    <asp:ListItem Text="Estudiante" Value="S" />
                                </asp:DropDownList>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                            <button type="button" class="btn btn-primary" onclick="actualizarDirecto()">Volver a
                                imprimir</button>
                        </div>
                    </div>
                </div>
            </div>

        </form>

        <!----------- SOPORTE TECNICO INICIO ----------->
        <div class="floating-support" title="Llámanos si necesitas ayuda">
            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round"
                stroke-linejoin="round" class="support-icon">
                <path d="M3 18v-6a9 9 0 0 1 18 0v6"></path>
                <path
                    d="M21 19a2 2 0 0 1-2 2h-1a2 2 0 0 1-2-2v-3a2 2 0 0 1 2-2h3zM3 19a2 2 0 0 0 2 2h1a2 2 0 0 0 2-2v-3a2 2 0 0 0-2-2H3z">
                </path>
            </svg>
            <span>Soporte: 932 306 660</span>
        </div>
        <!----------- SOPORTE TECNICO FIN ----------->


        <!----------- USUARIO LOGUEADO INICIO ----------->
        <div id="ContEmplAsig" runat="server" class="floating-user" title="Usuario conectado" visible="false">
            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round"
                stroke-linejoin="round" class="support-icon">
                <path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"></path>
                <circle cx="12" cy="7" r="4"></circle>
            </svg>
            <span id="lblUsuarioLogueado" runat="server"></span>
        </div>
   
        <script>

</script>

    </body>

    </html>