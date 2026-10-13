<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<header class="navbar">
    <a href="${pageContext.request.contextPath}/" class="brand">
        <span class="brand-icon">🐕</span>
        <span>Can</span>Styling
    </a>
    <ul class="nav-links">
        <li><a href="${pageContext.request.contextPath}/citas">📅 Citas</a></li>
        <li><a href="${pageContext.request.contextPath}/clientes">👥 Clientes</a></li>
        <li><a href="${pageContext.request.contextPath}/album?token=e4b2d18a-78f9-4c12-98ab-34cd56ef7890">🖼️ Álbum Demo</a></li>
        <c:choose>
            <c:when test="${sessionScope.usuarioLogueado != null || sessionScope.usuarioLogueadoEmail != null}">
                <li>
                    <span style="font-size: 0.88rem; color: var(--dark); font-weight: 700;">
                        👤 ${sessionScope.nombreUsuario}
                    </span>
                </li>
                <li><a href="${pageContext.request.contextPath}/logout" class="btn btn-secondary btn-sm" style="color: var(--danger);">Salir</a></li>
            </c:when>
            <c:otherwise>
                <li><a href="${pageContext.request.contextPath}/login" class="btn btn-primary btn-sm">Iniciar Sesión</a></li>
            </c:otherwise>
        </c:choose>
    </ul>
</header>
