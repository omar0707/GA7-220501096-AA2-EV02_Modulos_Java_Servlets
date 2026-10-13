<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="pageTitle" value="Gestión de Citas - CanStyling" />
<jsp:include page="/WEB-INF/views/includes/header.jsp" />
<jsp:include page="/WEB-INF/views/includes/navbar.jsp" />

<div class="container">
    <div class="card">
        <div class="card-header">
            <h2 class="card-title">📅 Agenda de Citas y Turnos de Peluquería</h2>
            <a href="${pageContext.request.contextPath}/citas?action=agendar" class="btn btn-primary btn-sm">
                ➕ Agendar Nueva Cita
            </a>
        </div>

        <c:if test="${not empty param.msg}">
            <div class="alert alert-success">Operación realizada correctamente.</div>
        </c:if>
        <c:if test="${not empty param.token}">
            <div class="alert alert-info">
                <strong>Token Anti-IDOR generado:</strong> <code>${param.token}</code><br>
                <a href="${pageContext.request.contextPath}/album?token=${param.token}" target="_blank" style="font-weight: 700;">
                    🔗 Abrir Álbum Digital del Cliente
                </a>
            </div>
        </c:if>

        <!-- Filtros por estado -->
        <div style="display: flex; gap: 0.5rem; margin-bottom: 1.5rem; flex-wrap: wrap;">
            <a href="${pageContext.request.contextPath}/citas" class="btn btn-sm ${empty estadoSeleccionado ? 'btn-primary' : 'btn-secondary'}">Todas</a>
            <a href="${pageContext.request.contextPath}/citas?estado=PENDIENTE" class="btn btn-sm ${estadoSeleccionado eq 'PENDIENTE' ? 'btn-primary' : 'btn-secondary'}">Pendientes</a>
            <a href="${pageContext.request.contextPath}/citas?estado=CONFIRMADA" class="btn btn-sm ${estadoSeleccionado eq 'CONFIRMADA' ? 'btn-primary' : 'btn-secondary'}">Confirmadas</a>
            <a href="${pageContext.request.contextPath}/citas?estado=COMPLETADA" class="btn btn-sm ${estadoSeleccionado eq 'COMPLETADA' ? 'btn-primary' : 'btn-secondary'}">Completadas</a>
        </div>

        <div class="table-responsive">
            <table class="data-table">
                <thead>
                    <tr>
                        <th># Cita</th>
                        <th>Fecha y Hora</th>
                        <th>Cliente / Propietario</th>
                        <th>Mascota</th>
                        <th>Servicio</th>
                        <th>Valor ($)</th>
                        <th>Estado</th>
                        <th>Álbum Anti-IDOR</th>
                        <th>Acciones</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${empty citas}">
                            <tr>
                                <td colspan="9" style="text-align: center; color: var(--gray-text); padding: 2rem;">
                                    No hay citas registradas bajo este criterio.
                                </td>
                            </tr>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="c" items="${citas}">
                                <tr>
                                    <td><strong>#${c.idCita}</strong></td>
                                    <td>${c.fechaHora}</td>
                                    <td>${c.nombreCliente}</td>
                                    <td><strong>${c.nombreMascota}</strong></td>
                                    <td>${c.nombreServicio}</td>
                                    <td>$${c.valorTotal}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${c.estado eq 'PENDIENTE'}"><span class="badge badge-pending">Pendiente</span></c:when>
                                            <c:when test="${c.estado eq 'CONFIRMADA'}"><span class="badge badge-confirmed">Confirmada</span></c:when>
                                            <c:when test="${c.estado eq 'EN_PROCESO'}"><span class="badge badge-process">En Proceso</span></c:when>
                                            <c:when test="${c.estado eq 'COMPLETADA'}"><span class="badge badge-completed">Completada</span></c:when>
                                            <c:otherwise><span class="badge badge-cancelled">${c.estado}</span></c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <a href="${pageContext.request.contextPath}/album?token=${c.tokenAcceso}" target="_blank" class="btn btn-secondary btn-sm" title="Ver Álbum">
                                            🖼️ Ver Álbum
                                        </a>
                                    </td>
                                    <td>
                                        <c:if test="${c.estado ne 'COMPLETADA' and c.estado ne 'CANCELADA'}">
                                            <a href="${pageContext.request.contextPath}/citas?action=completar&id=${c.idCita}" class="btn btn-success btn-sm">
                                                ✔ Finalizar
                                            </a>
                                        </c:if>
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
