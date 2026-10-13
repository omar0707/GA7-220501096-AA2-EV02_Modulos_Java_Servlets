<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="pageTitle" value="Álbum Digital de Mascota - CanStyling" />
<jsp:include page="/WEB-INF/views/includes/header.jsp" />
<jsp:include page="/WEB-INF/views/includes/navbar.jsp" />

<div class="container" style="max-width: 850px;">
    <c:choose>
        <c:when test="${tokenInvalido}">
            <div class="card" style="text-align: center; padding: 3rem;">
                <span style="font-size: 3.5rem;">🔒</span>
                <h2 style="color: var(--danger); margin: 1rem 0;">Acceso No Autorizado</h2>
                <p style="color: var(--gray-text); max-width: 500px; margin: 0 auto 1.5rem;">
                    El enlace del álbum es inválido, ha expirado o no cuenta con el token criptográfico correcto.
                    Por motivos de seguridad y privacidad (Anti-IDOR), no es posible acceder a las fotografías mediante identificadores secuenciales.
                </p>
                <a href="${pageContext.request.contextPath}/" class="btn btn-primary">Volver al Inicio</a>
            </div>
        </c:when>
        <c:otherwise>
            <div class="card" style="padding: 0; overflow: hidden;">
                <div style="background: linear-gradient(135deg, #f59e0b 0%, #d97706 100%); color: #ffffff; padding: 2rem; text-align: center;">
                    <span style="font-size: 3rem;">🐶✨</span>
                    <h1 style="font-size: 1.8rem; font-weight: 800; margin-top: 0.5rem;">
                        ¡Mira qué hermosa quedó ${cita.nombreMascota}!
                    </h1>
                    <p style="opacity: 0.9; font-size: 1rem;">
                        Álbum digital del servicio de ${cita.nombreServicio}
                    </p>
                </div>

                <div style="padding: 1.5rem; background: #ffffff; border-bottom: 1px solid var(--gray-border); display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 1rem; font-size: 0.92rem;">
                    <div><strong>Dueño:</strong> ${cita.nombreCliente}</div>
                    <div><strong>Fecha del Servicio:</strong> ${cita.fechaHora}</div>
                    <div><strong>Estado:</strong> <span class="badge badge-completed">${cita.estado}</span></div>
                    <div><strong>Pelúquero:</strong> ${cita.nombrePeluquero != null ? cita.nombrePeluquero : 'Estilista Canino CanStyling'}</div>
                </div>

                <div style="padding: 2rem 1.5rem;">
                    <h3 style="text-align: center; color: var(--dark); font-size: 1.2rem; margin-bottom: 1.5rem;">
                        📸 Comparativa: El Antes y el Después
                    </h3>

                    <div class="compare-grid">
                        <div class="photo-box">
                            <img src="https://images.unsplash.com/photo-1543466835-00a7907e9de1?auto=format&fit=crop&w=600&q=80" alt="Antes del servicio">
                            <div class="photo-label">✂️ 1. ANTES (Al llegar)</div>
                        </div>
                        <div class="photo-box">
                            <img src="https://images.unsplash.com/photo-1583511655857-d19b40a7a54e?auto=format&fit=crop&w=600&q=80" alt="Después del servicio">
                            <div class="photo-label" style="color: var(--primary-dark);">✨ 2. DESPUÉS (Listo para brillar)</div>
                        </div>
                    </div>

                    <c:if test="${not empty cita.observacionesEntrega}">
                        <div class="alert alert-success" style="margin-top: 1.5rem;">
                            <strong>Nota del Estilista:</strong> ${cita.observacionesEntrega}
                        </div>
                    </c:if>
                </div>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<jsp:include page="/WEB-INF/views/includes/footer.jsp" />
