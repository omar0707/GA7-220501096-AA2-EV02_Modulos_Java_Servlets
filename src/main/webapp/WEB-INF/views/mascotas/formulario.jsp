<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="pageTitle" value="Registrar Mascota - CanStyling" />
<jsp:include page="/WEB-INF/views/includes/header.jsp" />
<jsp:include page="/WEB-INF/views/includes/navbar.jsp" />

<div class="container" style="max-width: 650px;">
    <div class="card">
        <div class="card-header">
            <h2 class="card-title">🐾 Registrar Mascota (Ficha Canina)</h2>
            <a href="${pageContext.request.contextPath}/clientes" class="btn btn-secondary btn-sm">&larr; Volver</a>
        </div>

        <c:if test="${not empty errorMessage}">
            <div class="alert alert-danger">${errorMessage}</div>
        </c:if>

        <form action="${pageContext.request.contextPath}/mascotas" method="POST">
            <input type="hidden" name="idCliente" value="${param.idCliente}">

            <div class="form-grid">
                <div class="form-group">
                    <label for="nombre">Nombre de la Mascota:</label>
                    <input type="text" id="nombre" name="nombre" class="form-control" required placeholder="Toby">
                </div>

                <div class="form-group">
                    <label for="idRaza">Raza Canina:</label>
                    <select id="idRaza" name="idRaza" class="form-control" required>
                        <option value="">-- Seleccione Raza --</option>
                        <c:forEach var="r" items="${razas}">
                            <option value="${r.idRaza}">${r.nombreRaza} (${r.tamano})</option>
                        </c:forEach>
                    </select>
                </div>
            </div>

            <div class="form-grid">
                <div class="form-group">
                    <label for="genero">Género:</label>
                    <select id="genero" name="genero" class="form-control" required>
                        <option value="MACHO">Macho</option>
                        <option value="HEMBRA">Hembra</option>
                    </select>
                </div>

                <div class="form-group">
                    <label for="edadAnos">Edad (Años):</label>
                    <input type="number" id="edadAnos" name="edadAnos" class="form-control" min="0" max="25" value="2" required>
                </div>
            </div>

            <div class="form-grid">
                <div class="form-group">
                    <label for="pesoKg">Peso (Kg):</label>
                    <input type="number" step="0.1" id="pesoKg" name="pesoKg" class="form-control" required placeholder="6.5">
                </div>

                <div class="form-group">
                    <label for="color">Color del Manto:</label>
                    <input type="text" id="color" name="color" class="form-control" placeholder="Blanco, Dorado, Sal y Pimienta...">
                </div>
            </div>

            <div style="text-align: right; margin-top: 1.5rem;">
                <button type="submit" class="btn btn-primary">
                    💾 Guardar Ficha de la Mascota
                </button>
            </div>
        </form>
    </div>
</div>

<jsp:include page="/WEB-INF/views/includes/footer.jsp" />
