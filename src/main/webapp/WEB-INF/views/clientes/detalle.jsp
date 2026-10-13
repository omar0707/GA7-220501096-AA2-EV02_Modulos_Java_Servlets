<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="pageTitle" value="Ficha de Propietario - CanStyling" />
<jsp:include page="/WEB-INF/views/includes/header.jsp" />
<jsp:include page="/WEB-INF/views/includes/navbar.jsp" />

<div class="container">
    <div class="card">
        <div class="card-header">
            <h2 class="card-title">👤 Ficha de Propietario: ${cliente.nombreCompleto}</h2>
            <div style="display: flex; gap: 0.5rem;">
                <a href="${pageContext.request.contextPath}/mascotas?idCliente=${cliente.idCliente}" class="btn btn-primary btn-sm">
                    ➕ Registrar Mascota
                </a>
                <a href="${pageContext.request.contextPath}/clientes" class="btn btn-secondary btn-sm">&larr; Volver</a>
            </div>
        </div>

        <c:if test="${not empty param.msg}">
            <div class="alert alert-success">Mascota registrada exitosamente para este cliente.</div>
        </c:if>

        <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(220px, 1fr)); gap: 1rem; margin-bottom: 2rem; background: #f8fafc; padding: 1rem; border-radius: 8px;">
            <div><strong>Documento:</strong> ${cliente.tipoDocumento} ${cliente.numeroDocumento}</div>
            <div><strong>Correo:</strong> ${cliente.correo}</div>
            <div><strong>Teléfono Principal:</strong> ${cliente.telefonoPrincipal}</div>
            <div><strong>Dirección:</strong> ${cliente.direccion} (${cliente.ciudad})</div>
        </div>

        <h3 style="font-size: 1.15rem; color: var(--dark); margin-bottom: 1rem;">🐾 Mascotas Registradas</h3>
        <div class="table-responsive">
            <table class="data-table">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Nombre Mascota</th>
                        <th>Raza</th>
                        <th>Género</th>
                        <th>Edad</th>
                        <th>Peso (kg)</th>
                        <th>Condiciones / Alergias</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${empty mascotas}">
                            <tr>
                                <td colspan="7" style="text-align: center; color: var(--gray-text); padding: 1.5rem;">
                                    Este cliente aún no tiene mascotas vinculadas.
                                </td>
                            </tr>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="m" items="${mascotas}">
                                <tr>
                                    <td>${m.idMascota}</td>
                                    <td><strong>${m.nombre}</strong></td>
                                    <td>${m.nombreRaza}</td>
                                    <td>${m.genero}</td>
                                    <td>${m.edadAnos} años</td>
                                    <td>${m.pesoKg} kg</td>
                                    <td>${empty m.alergiasCondiciones ? 'Ninguna' : m.alergiasCondiciones}</td>
                                </tr>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/views/includes/footer.jsp" />
