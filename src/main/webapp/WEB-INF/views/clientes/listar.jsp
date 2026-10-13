<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="pageTitle" value="Directorio de Clientes - CanStyling" />
<jsp:include page="/WEB-INF/views/includes/header.jsp" />
<jsp:include page="/WEB-INF/views/includes/navbar.jsp" />

<div class="container">
    <div class="card">
        <div class="card-header">
            <h2 class="card-title">👥 Directorio de Propietarios de Mascotas</h2>
            <a href="${pageContext.request.contextPath}/clientes?action=nuevo" class="btn btn-primary btn-sm">
                ➕ Nuevo Propietario
            </a>
        </div>

        <c:if test="${not empty param.msg}">
            <div class="alert alert-success">Operación sobre cliente realizada correctamente.</div>
        </c:if>

        <div class="table-responsive">
            <table class="data-table">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Documento</th>
                        <th>Nombre y Apellidos</th>
                        <th>Correo Electrónico</th>
                        <th>Teléfono Principal</th>
                        <th>Otros Teléfonos / WhatsApp</th>
                        <th>Ciudad</th>
                        <th>Acciones</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${empty clientes}">
                            <tr>
                                <td colspan="8" style="text-align: center; color: var(--gray-text); padding: 2rem;">
                                    No hay clientes registrados en la base de datos.
                                </td>
                            </tr>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="cl" items="${clientes}">
                                <tr>
                                    <td>${cl.idCliente}</td>
                                    <td>${cl.tipoDocumento} ${cl.numeroDocumento}</td>
                                    <td><strong>${cl.nombreCompleto}</strong></td>
                                    <td>${cl.correo}</td>
                                    <td><span style="color: #059669; font-weight: 700;">📱 ${cl.telefonoPrincipal}</span></td>
                                    <td>
                                        <c:forEach var="t" items="${cl.telefonos}">
                                            <c:if test="${not t.esPrincipal}">
                                                <small style="display: block; color: var(--gray-text);">${t.tipo}: ${t.numeroTelefono}</small>
                                            </c:if>
                                        </c:forEach>
                                    </td>
                                    <td>${cl.ciudad}</td>
                                    <td>
                                        <div style="display: flex; gap: 0.35rem;">
                                            <a href="${pageContext.request.contextPath}/clientes?action=ver&id=${cl.idCliente}" class="btn btn-secondary btn-sm" title="Ver Ficha y Mascotas">
                                                🐾 Mascotas
                                            </a>
                                            <a href="${pageContext.request.contextPath}/clientes?action=editar&id=${cl.idCliente}" class="btn btn-secondary btn-sm" title="Editar">
                                                ✏️
                                            </a>
                                        </div>
                                    </td>
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
