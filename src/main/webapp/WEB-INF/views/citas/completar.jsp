<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="pageTitle" value="Finalizar Servicio - CanStyling" />
<jsp:include page="/WEB-INF/views/includes/header.jsp" />
<jsp:include page="/WEB-INF/views/includes/navbar.jsp" />

<div class="container" style="max-width: 600px;">
    <div class="card">
        <div class="card-header">
            <h2 class="card-title">✔ Finalizar Servicio de Peluquería</h2>
            <a href="${pageContext.request.contextPath}/citas" class="btn btn-secondary btn-sm">&larr; Volver</a>
        </div>

        <div class="alert alert-info">
            <strong>Cita #${cita.idCita}:</strong> Mascota: <strong>${cita.nombreMascota}</strong> | Dueño: <strong>${cita.nombreCliente}</strong>
        </div>

        <form action="${pageContext.request.contextPath}/citas" method="POST">
            <input type="hidden" name="action" value="finalizar_servicio">
            <input type="hidden" name="idCita" value="${cita.idCita}">

            <div class="form-group">
                <label for="observacionesEntrega">Observaciones de Entrega y Estado Final:</label>
                <textarea id="observacionesEntrega" name="observacionesEntrega" class="form-control" rows="4" required
                          placeholder="Ej. Servicio completado con éxito, corte de uñas realizado, pelo desenredado..."></textarea>
            </div>

            <div style="text-align: right; margin-top: 1.5rem;">
                <button type="submit" class="btn btn-success">
                    ✔ Marcar como COMPLETADA
                </button>
            </div>
        </form>
    </div>
</div>

<jsp:include page="/WEB-INF/views/includes/footer.jsp" />
