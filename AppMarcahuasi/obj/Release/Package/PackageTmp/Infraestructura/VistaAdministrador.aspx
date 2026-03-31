<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="VistaAdministrador.aspx.cs"
    Inherits="AppMarcahuasi.Infraestructura.VistaAdministrador" %>

    <!DOCTYPE html>
    <html xmlns="http://www.w3.org/1999/xhtml">

    <head runat="server">
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <script src="../scripts/sweetalert2.all.min.js"></script>
        <title>Administrador</title>

        <style>
            * {
                box-sizing: border-box;
                margin: 0;
                padding: 0;
            }

            body {
                font-family: 'Segoe UI', Roboto, 'Helvetica Neue', Arial, sans-serif;
                background-color: #f0f4f8;
                color: #2d3748;
                display: flex;
                flex-direction: column;
                min-height: 100vh;
                font-size: 18px;
            }

            .top-header {
                width: 100%;
                background-color: #2b6cb0;
                color: #ffffff;
                padding: 16px 30px;
                display: flex;
                justify-content: space-between;
                align-items: center;
                box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            }

            .user-info {
                font-size: 22px;
                font-weight: 600;
            }

            .btn-logout {
                background-color: transparent;
                color: #ffffff;
                border: 2px solid #ffffff;
                padding: 10px 20px;
                border-radius: 8px;
                font-size: 18px;
                font-weight: bold;
                cursor: pointer;
                transition: all 0.2s ease;
            }

            .btn-logout:hover {
                background-color: #ffffff;
                color: #2b6cb0;
            }

            .main-container {
                flex-grow: 1;
                display: flex;
                justify-content: center;
                align-items: center;
                padding: 20px;
            }

            #form1 {
                background-color: #ffffff;
                width: 100%;
                max-width: 600px;
                padding: 40px;
                border-radius: 16px;
                box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
                display: flex;
                flex-direction: column;
                gap: 25px;
            }

            .form-header {
                text-align: center;
                margin-bottom: 10px;
                margin-top: -50px;
            }

            .form-header h1 {
                font-size: 29px;
                color: #1a202c;
                margin-bottom: 10px;
            }

            .form-header p {
                color: #4a5568;
                font-size: 19px;
            }

            .form-group {
                display: flex;
                flex-direction: column;
                gap: 12px;
            }

            .form-group label {
                font-weight: 600;
                color: #1a202c;
                font-size: 20px;
            }

            input[type="date"] {
                width: 100%;
                padding: 11px 20px;
                font-size: 20px;
                border: 2px solid #cbd5e0;
                border-radius: 12px;
                color: #2d3748;
                background-color: #f7fafc;
                transition: all 0.2s ease;
                outline: none;
                cursor: pointer;
            }

            input[type="date"]:focus {
                border-color: #3182ce;
                box-shadow: 0 0 0 4px rgba(49, 130, 206, 0.2);
                background-color: #ffffff;
            }

            table[id*="Nacionalidad"] {
                width: 100%;
                border-collapse: separate;
                border-spacing: 0 10px;
            }

            table[id*="Nacionalidad"] td {
                background-color: #edf2f7;
                border-radius: 12px;
                padding: 14px 20px;
                cursor: pointer;
                transition: background-color 0.2s;
                border: 2px solid transparent;
            }

            table[id*="Nacionalidad"] td:hover {
                background-color: #e2e8f0;
            }

            table[id*="Nacionalidad"] label {
                cursor: pointer;
                font-size: 20px;
                font-weight: 500;
                margin-left: 12px;
                display: inline-block;
                vertical-align: middle;
                color: #1a202c;
            }

            table[id*="Nacionalidad"] input[type="radio"] {
                width: 24px;
                height: 24px;
                accent-color: #3182ce;
                cursor: pointer;
                vertical-align: middle;
            }

            .botonExportarExcel {
                background-color: #3182ce;
                color: #ffffff;
                font-size: 22px;
                font-weight: bold;
                padding: 20px 24px;
                border: none;
                border-radius: 12px;
                cursor: pointer;
                width: 100%;
                transition: background-color 0.2s, transform 0.1s;
                box-shadow: 0 4px 6px rgba(49, 130, 206, 0.3);
            }

            .botonExportarExcel {
                background-color: #2b6cb0;
            }

            .botonExportarExcel {
                transform: scale(0.98);
            }

            @media (max-width: 480px) {
                .top-header {
                    flex-direction: column;
                    gap: 15px;
                    text-align: center;
                    padding: 20px;
                }

                #form1 {
                    padding: 30px 20px;
                }

                .botonExportarExcel {
                    font-size: 20px;
                    padding: 18px;
                }

                .loader-card {
                    padding: 30px 40px;
                }
            }

            .loading-overlay {
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background-color: rgba(0, 0, 0, 0.7);
                z-index: 9999;
                display: none;
                justify-content: center;
                align-items: center;
            }

            .loader-card {
                background-color: #ffffff;
                padding: 40px 60px;
                border-radius: 16px;
                text-align: center;
                box-shadow: 0 10px 30px rgba(0, 0, 0, 0.5);
            }

            .spinner {
                border: 8px solid #edf2f7;
                border-top: 8px solid #3182ce;
                border-radius: 50%;
                width: 70px;
                height: 70px;
                animation: spin 1s linear infinite;
                margin: 0 auto 20px auto;
            }

            @keyframes spin {
                0% {
                    transform: rotate(0deg);
                }

                100% {
                    transform: rotate(360deg);
                }
            }

            .loader-text {
                color: #1a202c;
                font-size: 24px;
                font-weight: bold;
                margin-top: 15px;
            }

            .btn-floating-admin {
                position: fixed;
                bottom: 25px;
                right: 25px;
                background-color: #e53e3e;
                color: #ffffff;
                width: 65px;
                height: 65px;
                border-radius: 50%;
                display: flex;
                align-items: center;
                justify-content: center;
                box-shadow: 0 4px 12px rgba(229, 62, 62, 0.4);
                cursor: pointer;
                z-index: 1000;
                transition: all 0.2s ease;
                border: none;
            }

            .btn-floating-admin:hover {
                background-color: #c53030;
                transform: scale(1.05);
            }

            .modal-overlay {
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

            .modal-overlay.show {
                opacity: 1;
                visibility: visible;
            }

            .modal-box {
                background-color: #ffffff;
                border-radius: 16px;
                padding: 3rem;
                width: 100%;
                max-width: 450px;
                box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.25);
                transform: translateY(20px);
                transition: transform 0.3s ease;
            }

            .modal-overlay.show .modal-box {
                transform: translateY(0);
            }

            .modal-box h2 {
                font-size: 2.2rem;
                color: #1a202c;
                margin-bottom: 0.5rem;
            }

            .modal-box p {
                color: #4a5568;
                font-size: 1.2rem;
                margin-bottom: 1.5rem;
            }

            .modal-input {
                width: 100%;
                padding: 1rem 1.2rem;
                font-size: 1.15rem;
                border: 2px solid #cbd5e0;
                border-radius: 8px;
                margin-bottom: 1.5rem;
                outline: none;
                transition: border-color 0.2s;
            }

            .modal-input:focus {
                border-color: #3182ce;
                box-shadow: 0 0 0 5px rgba(49, 130, 206, 0.2);
            }

            .btn-modal-action {
                width: 100%;
                padding: 1.1rem;
                background-color: #e53e3e;
                color: #ffffff;
                border: none;
                border-radius: 8px;
                font-size: 1.2rem;
                font-weight: 600;
                cursor: pointer;
                transition: all 0.2s;
                margin-bottom: 10px;
            }

            .btn-modal-action:hover {
                background-color: #c53030;
            }

            .btn-modal-close {
                width: 100%;
                padding: 1.1rem;
                background-color: transparent;
                color: #4a5568;
                border: 2px solid #cbd5e0;
                border-radius: 8px;
                font-size: 1.2rem;
                font-weight: 600;
                cursor: pointer;
                transition: all 0.2s;
            }

            .btn-modal-close:hover {
                background-color: rgba(0, 0, 0, 0.05);
            }
        </style>

        <script>

            function cerrarSesion() {
                document.getElementById('Accion').value = "LOGOUT";
                document.forms[0].submit();
            }

            function exportarExcel() {
                var loadingOverlay = document.getElementById("loadingOverlay");
                loadingOverlay.style.display = "flex";

                document.getElementById('Accion').value = "EXP_EXCEL";

                downloadTimer = window.setInterval(function () {
                    var token = getCookie("descargaCompleta");
                    if (token === "true") {
                        quitarSpinner();
                        detenerMonitor();
                    }
                }, 1000);

                document.forms[0].submit();
            }

            function detenerMonitor() {
                window.clearInterval(downloadTimer);
                document.cookie = "descargaCompleta=; expires=Thu, 01 Jan 1970 00:00:00 UTC; path=/;";
            }

            function getCookie(name) {
                var parts = document.cookie.split(name + "=");
                if (parts.length == 2) return parts.pop().split(";").shift();
            }

            function quitarSpinner() {
                var loadingOverlay = document.getElementById("loadingOverlay");
                if (loadingOverlay) loadingOverlay.style.display = "none";
            }

            function abrirModalNombre() {
                document.getElementById('modalNombre').classList.add('show');
                setTimeout(function () {
                    document.getElementById('txtNombreAdmin').focus();
                }, 100);
            }

            function cerrarModalNombre() {
                document.getElementById('modalNombre').classList.remove('show');
                document.getElementById('txtNombreAdmin').value = '';
            }

            function guardarNombre() {
                const nombre = document.getElementById('txtNombreAdmin').value.trim();
                if (nombre === "") {
                    alert("Por favor, digite un nombre.");
                    return;
                }

                document.getElementById('Accion').value = "SAVE_USER";
                document.forms[0].submit();
            }

            function saveUserSucces(mensaje) {

                Swal.fire({
                    title: "¡Éxito!",
                    text: mensaje,
                    icon: "success",
                    showConfirmButton: false,
                    timer: 3000,
                    timerProgressBar: true
                });

                setTimeout(function () {
                    window.location.href = ('VistaPrincipal.aspx');
                    cerrarModalNombre();
                }, 4000)
            }

        </script>

    </head>

    <body>

        <header class="top-header">
            <div class="user-info"><span id="lblUsuarioLogueado" runat="server">👤 Bienvenido.</span></div>
            <button type="button" class="btn-logout" onclick="cerrarSesion()">Cerrar Sesión</button>
        </header>

        <div class="main-container">
            <form id="form1" runat="server">

                <div class="form-header">
                    <h1>Reporte de Datos</h1>
                    <p>Seleccione los filtros para exportar el archivo</p>
                </div>

                <div class="form-group">
                    <label for="txtfechaInicio">Fecha de Inicio:</label>
                    <input id="txtfechaInicio" runat="server" type="date" />
                </div>

                <div class="form-group">
                    <label for="txtfechaFin">Fecha de Fin:</label>
                    <input id="txtfechaFin" runat="server" type="date" />
                </div>

                <div class="form-group">
                    <label>Seleccione Nacionalidad:</label>
                    <asp:RadioButtonList ID="Nacionalidad" runat="server">
                        <asp:ListItem Value="N">Nacional</asp:ListItem>
                        <asp:ListItem Value="E">Extranjero</asp:ListItem>
                        <asp:ListItem Value="S">Estudiante</asp:ListItem>
                        <asp:ListItem Value="T" Selected="True">Todos</asp:ListItem>
                    </asp:RadioButtonList>
                </div>

                <button type="submit" onclick="exportarExcel()" class="botonExportarExcel">Exportar a Excel</button>

                <asp:HiddenField ID="Accion" runat="server" Value="" />

                <button class="btn-floating-admin" onclick="abrirModalNombre()" title="Asignar Gestor" type="button">
                    <svg xmlns="http://www.w3.org/2000/svg" width="30" height="30" viewBox="0 0 24 24" fill="none"
                        stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                        <path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"></path>
                        <circle cx="12" cy="7" r="4"></circle>
                    </svg>
                </button>

                <div id="modalNombre" class="modal-overlay">
                    <div class="modal-box">
                        <h2>Asignar Gestor</h2>
                        <p>Por favor, digite un nombre para asignarlo.</p>
                        <input type="text" id="txtNombreAdmin" class="modal-input" placeholder="Ej. Juan Pérez"
                            autocomplete="off" runat="server" />
                        <button class="btn-modal-action" type="button" onclick="guardarNombre()">Asignar</button>
                        <button class="btn-modal-close" type="button" onclick="cerrarModalNombre()">Cancelar</button>
                    </div>
                </div>
            </form>
        </div>

        <div id="loadingOverlay" class="loading-overlay">
            <div class="loader-card">
                <div class="spinner"></div>
                <div class="loader-text">Generando excel...</div>
            </div>
        </div>

    </body>

    </html>