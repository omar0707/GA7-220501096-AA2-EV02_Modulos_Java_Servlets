<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="pageTitle" value="Agendar Cita - CanStyling" />
<jsp:include page="/WEB-INF/views/includes/header.jsp" />
<jsp:include page="/WEB-INF/views/includes/navbar.jsp" />

<div class="container" style="max-width: 700px;">
    <div class="card">
        <div class="card-header">
            <h2 class="card-title">📅 Agendar Nueva Cita de Peluquería</h2>
            <a href="${pageContext.request.contextPath}/citas" class="btn btn-secondary btn-sm">&larr; Volver</a>
        </div>

        <c:if test="${not empty errorMessage}">
            <div class="alert alert-danger">${errorMessage}</div>
        </c:if>

        <form action="${pageContext.request.contextPath}/citas" method="POST">
            <input type="hidden" name="action" value="guardar">

            <div class="form-group">
                <label for="selectCliente">1. Propietario / Cliente:</label>
                <select id="selectCliente" name="idCliente" class="form-control" required>
                    <option value="">-- Seleccione un Cliente --</option>
                    <c:forEach var="cl" items="${clientes}">
                        <option value="${cl.idCliente}">${cl.nombreCompleto} (Doc: ${cl.numeroDocumento} - Tel: ${cl.telefonoPrincipal})</option>
                    </c:forEach>
                </select>
            </div>

            <div class="form-group">
                <label for="selectMascota">2. Mascota:</label>
                <select id="selectMascota" name="idMascota" class="form-control" required>
                    <option value="">-- Primero seleccione un cliente --</option>
                </select>
            </div>

            <div class="form-group">
                <label for="selectServicio">3. Servicio de Estética Canina:</label>
                <select id="selectServicio" name="idServicio" class="form-control" required>
                    <option value="">-- Seleccione el Servicio --</option>
                    <c:forEach var="s" items="${servicios}">
                        <option value="${s.idServicio}" data-precio="${s.precioBase}">
                            ${s.nombreServicio} - $${s.precioBase} (${s.duracionMinutos} min)
                        </option>
                    </c:forEach>
                </select>
            </div>

            <div class="form-grid">
                <div class="form-group">
                    <label for="fechaHora">Fecha y Hora del Turno:</label>
                    <input type="datetime-local" id="fechaHora" name="fechaHora" class="form-control" required>
                </div>

                <div class="form-group">
                    <label for="valorTotal">Valor a Cobrar ($):</label>
                    <input type="number" step="1000" id="valorTotal" name="valorTotal" class="form-control" required placeholder="35000">
                </div>
            </div>

            <div class="form-group">
                <label for="observaciones">Observaciones de Recepción / Instrucciones del Cliente:</label>
                <textarea id="observaciones" name="observaciones" class="form-control" rows="3"
                          placeholder="Ej. Corte bajito, perro con piel sensible, evitar perfume fuerte..."></textarea>
            </div>

            <div style="text-align: right; margin-top: 1.5rem;">
                <button type="submit" class="btn btn-primary">
                    💾 Confirmar y Generar Token Anti-IDOR
                </button>
            </div>
        </form>
    </div>
</div>

<jsp:include page="/WEB-INF/views/includes/footer.jsp" />
