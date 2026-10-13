<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="pageTitle" value="Acceso al Sistema - CanStyling" />
<jsp:include page="/WEB-INF/views/includes/header.jsp" />
<jsp:include page="/WEB-INF/views/includes/navbar.jsp" />

<div class="container" style="max-width: 480px; margin-top: 3rem;">
    <div class="card">
        <div style="text-align: center; margin-bottom: 1.5rem;">
            <span style="font-size: 2.5rem;">🔐</span>
            <h2 style="font-size: 1.5rem; color: var(--dark); margin-top: 0.5rem;">Acceso al Sistema</h2>
            <p style="color: var(--gray-text); font-size: 0.9rem;">Peluquería Canina CanStyling</p>
        </div>

        <c:if test="${not empty param.msg && param.msg eq 'sesion_cerrada'}">
            <div class="alert alert-info">Ha cerrado sesión correctamente.</div>
        </c:if>
        <c:if test="${not empty param.error && param.error eq 'requiere_autenticacion'}">
            <div class="alert alert-danger">Debe iniciar sesión para acceder a este módulo.</div>
        </c:if>

        <c:if test="${not empty errorMessage}">
            <div class="alert alert-danger">${errorMessage}</div>
        </c:if>

        <!-- Pestañas de Seleccion de Modo de Login -->
        <div style="display: flex; border-bottom: 2px solid var(--gray-border); margin-bottom: 1.5rem;">
            <button type="button" class="tab-btn ${empty activeTab or activeTab eq 'password' ? 'active' : ''}" data-tab="tab-pass"
                    style="flex: 1; padding: 0.75rem; font-weight: 700; border: none; background: none; cursor: pointer; border-bottom: 3px solid transparent;">
                🔑 Con Contraseña
            </button>
            <button type="button" class="tab-btn ${activeTab eq 'otp' ? 'active' : ''}" data-tab="tab-otp"
                    style="flex: 1; padding: 0.75rem; font-weight: 700; border: none; background: none; cursor: pointer; border-bottom: 3px solid transparent;">
                ✉️ Código OTP
            </button>
        </div>

        <style>
            .tab-btn.active { color: var(--primary-dark); border-bottom-color: var(--primary) !important; }
            .tab-pane { display: none; }
            .tab-pane.active { display: block; }
        </style>

        <!-- PANEL 1: LOGIN CON PASSWORD -->
        <div id="tab-pass" class="tab-pane ${empty activeTab or activeTab eq 'password' ? 'active' : ''}">
            <form action="${pageContext.request.contextPath}/auth" method="POST">
                <input type="hidden" name="action" value="login_password">

                <div class="form-group">
                    <label for="correo">Correo Electrónico:</label>
                    <input type="email" id="correo" name="correo" class="form-control" required placeholder="admin@canstyling.com">
                </div>

                <div class="form-group">
                    <label for="password">Contraseña:</label>
                    <input type="password" id="password" name="password" class="form-control" required placeholder="••••••••">
                </div>

                <button type="submit" class="btn btn-primary" style="width: 100%; justify-content: center; margin-top: 0.5rem;">
                    Ingresar al Panel
                </button>
            </form>
            <div style="margin-top: 1rem; font-size: 0.85rem; color: var(--gray-text); text-align: center;">
                <em>Usuario Demo: admin@canstyling.com (Pass: Admin123*)</em>
            </div>
        </div>

        <!-- PANEL 2: LOGIN CON OTP (PASSWORDLESS) -->
        <div id="tab-otp" class="tab-pane ${activeTab eq 'otp' ? 'active' : ''}">
            <c:if test="${not empty errorMessageOtp}">
                <div class="alert alert-danger">${errorMessageOtp}</div>
            </c:if>
            <c:if test="${not empty successMessageOtp}">
                <div class="alert alert-success">${successMessageOtp}</div>
            </c:if>

            <c:choose>
                <c:when test="${stepOtp eq 'verificar'}">
                    <!-- Paso 2: Ingreso del codigo OTP -->
                    <c:if test="${not empty otpGeneradoSimulado}">
                        <div class="alert alert-info" style="font-size: 0.88rem;">
                            <strong>Código de prueba generado:</strong> <span style="font-size: 1.1rem; font-weight: 800; color: var(--primary-dark);">${otpGeneradoSimulado}</span>
                        </div>
                    </c:if>

                    <form action="${pageContext.request.contextPath}/auth" method="POST">
                        <input type="hidden" name="action" value="verificar_otp">
                        <input type="hidden" name="correo_otp_hidden" value="${correoOtpEnviado}">

                        <div class="form-group">
                            <label>Correo de destino:</label>
                            <input type="text" class="form-control" value="${correoOtpEnviado}" disabled style="background: #f1f5f9;">
                        </div>

                        <div class="form-group">
                            <label for="codigo_otp">Código OTP (6 dígitos):</label>
                            <input type="text" id="codigo_otp" name="codigo_otp" class="form-control" required maxlength="6"
                                   placeholder="123456" style="letter-spacing: 4px; font-size: 1.3rem; text-align: center; font-weight: 700;">
                        </div>

                        <button type="submit" class="btn btn-success" style="width: 100%; justify-content: center;">
                            Validar Código y Entrar
                        </button>
                    </form>
                </c:when>
                <c:otherwise>
                    <!-- Paso 1: Solicitud de codigo al correo -->
                    <form action="${pageContext.request.contextPath}/auth" method="POST">
                        <input type="hidden" name="action" value="solicitar_otp">

                        <div class="form-group">
                            <label for="correo_otp">Su correo registrado:</label>
                            <input type="email" id="correo_otp" name="correo_otp" class="form-control" required placeholder="ejemplo@gmail.com">
                        </div>

                        <button type="submit" class="btn btn-primary" style="width: 100%; justify-content: center;">
                            Solicitar Código de Acceso
                        </button>
                    </form>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/views/includes/footer.jsp" />
