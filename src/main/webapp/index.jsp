<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="pageTitle" value="Inicio - CanStyling Peluquería Canina" />
<jsp:include page="/WEB-INF/views/includes/header.jsp" />
<jsp:include page="/WEB-INF/views/includes/navbar.jsp" />

<div class="container">
    <div class="hero">
        <h1>🐾 Bienvenido a CanStyling</h1>
        <p>Sistema integral de gestión de peluquería canina, turnos, fichas clínicas y seguimiento fotográfico con seguridad avanzada.</p>
        <div style="display: flex; gap: 1rem; justify-content: center; flex-wrap: wrap;">
            <a href="${pageContext.request.contextPath}/citas" class="btn btn-primary">📅 Ver Agenda de Turnos</a>
            <a href="${pageContext.request.contextPath}/citas?action=agendar" class="btn btn-secondary">➕ Agendar Nueva Cita</a>
            <a href="${pageContext.request.contextPath}/album?token=e4b2d18a-78f9-4c12-98ab-34cd56ef7890" class="btn btn-secondary">🖼️ Ver Álbum Digital Demo</a>
        </div>
    </div>

    <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(300px, 1fr)); gap: 1.5rem;">
        <div class="card">
            <div class="card-title">📅 Gestión de Turnos</div>
            <p style="color: var(--gray-text); margin: 0.75rem 0 1.25rem;">
                Control de citas por estado, asignación de peluqueros, cálculo automático de tarifas y prevención de turnos fantasma.
            </p>
            <a href="${pageContext.request.contextPath}/citas" class="btn btn-primary btn-sm">Abrir Turnos &rarr;</a>
        </div>

        <div class="card">
            <div class="card-title">👥 Propietarios y Mascotas</div>
            <p style="color: var(--gray-text); margin: 0.75rem 0 1.25rem;">
                Directorio con soporte para múltiples líneas telefónicas (WhatsApp, Móvil) y fichas de salud canina por raza y peso.
            </p>
            <a href="${pageContext.request.contextPath}/clientes" class="btn btn-primary btn-sm">Directorio Clientes &rarr;</a>
        </div>

        <div class="card">
            <div class="card-title">🔐 Seguridad y Anti-IDOR</div>
            <p style="color: var(--gray-text); margin: 0.75rem 0 1.25rem;">
                Acceso público a álbumes protegido por tokens UUID impredecibles y sistema de autenticación passwordless con códigos OTP.
            </p>
            <a href="${pageContext.request.contextPath}/login" class="btn btn-primary btn-sm">Iniciar Sesión &rarr;</a>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/views/includes/footer.jsp" />
