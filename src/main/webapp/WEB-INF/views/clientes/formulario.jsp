<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="pageTitle" value="${cliente != null ? 'Editar Propietario' : 'Registrar Propietario'} - CanStyling" />
<jsp:include page="/WEB-INF/views/includes/header.jsp" />
<jsp:include page="/WEB-INF/views/includes/navbar.jsp" />

<div class="container" style="max-width: 700px;">
    <div class="card">
        <div class="card-header">
            <h2 class="card-title">
                ${cliente != null ? '✏️ Modificar Datos del Propietario' : '➕ Registrar Nuevo Propietario'}
            </h2>
            <a href="${pageContext.request.contextPath}/clientes" class="btn btn-secondary btn-sm">&larr; Volver</a>
        </div>

        <c:if test="${not empty errorMessage}">
            <div class="alert alert-danger">${errorMessage}</div>
        </c:if>

        <form action="${pageContext.request.contextPath}/clientes" method="POST">
            <input type="hidden" name="action" value="guardar">
            <input type="hidden" name="idCliente" value="${cliente != null ? cliente.idCliente : ''}">

            <div class="form-grid">
                <div class="form-group">
                    <label for="tipoDocumento">Tipo de Documento:</label>
                    <select id="tipoDocumento" name="tipoDocumento" class="form-control" required>
                        <option value="CC" ${cliente.tipoDocumento eq 'CC' ? 'selected' : ''}>Cédula de Ciudadanía (CC)</option>
                        <option value="CE" ${cliente.tipoDocumento eq 'CE' ? 'selected' : ''}>Cédula de Extranjería (CE)</option>
                        <option value="TI" ${cliente.tipoDocumento eq 'TI' ? 'selected' : ''}>Tarjeta de Identidad (TI)</option>
                        <option value="PASAPORTE" ${cliente.tipoDocumento eq 'PASAPORTE' ? 'selected' : ''}>Pasaporte</option>
                    </select>
                </div>

                <div class="form-group">
                    <label for="numeroDocumento">Número de Documento:</label>
                    <input type="text" id="numeroDocumento" name="numeroDocumento" class="form-control" required
                           value="${cliente != null ? cliente.numeroDocumento : ''}" placeholder="1067890123">
                </div>
            </div>

            <div class="form-grid">
                <div class="form-group">
                    <label for="nombres">Nombres:</label>
                    <input type="text" id="nombres" name="nombres" class="form-control" required
                           value="${cliente != null ? cliente.nombres : ''}" placeholder="Laura">
                </div>

                <div class="form-group">
                    <label for="apellidos">Apellidos:</label>
                    <input type="text" id="apellidos" name="apellidos" class="form-control" required
                           value="${cliente != null ? cliente.apellidos : ''}" placeholder="Martínez Pérez">
                </div>
            </div>

            <div class="form-grid">
                <div class="form-group">
                    <label for="correo">Correo Electrónico (para Login OTP):</label>
                    <input type="email" id="correo" name="correo" class="form-control" required
                           value="${cliente != null ? cliente.correo : ''}" placeholder="laura@gmail.com">
                </div>

                <div class="form-group">
                    <label for="telefonoPrincipal">Teléfono Principal / WhatsApp:</label>
                    <input type="tel" id="telefonoPrincipal" name="telefonoPrincipal" class="form-control" required
                           value="${cliente != null ? cliente.telefonoPrincipal : ''}" placeholder="3001234567">
                </div>
            </div>

            <div class="form-grid">
                <div class="form-group">
                    <label for="direccion">Dirección Residencial:</label>
                    <input type="text" id="direccion" name="direccion" class="form-control"
                           value="${cliente != null ? cliente.direccion : ''}" placeholder="Calle 44 # 12-30">
                </div>

                <div class="form-group">
                    <label for="ciudad">Ciudad:</label>
                    <input type="text" id="ciudad" name="ciudad" class="form-control"
                           value="${cliente != null ? cliente.ciudad : 'Montería'}">
                </div>
            </div>

            <div style="text-align: right; margin-top: 1.5rem;">
                <button type="submit" class="btn btn-primary">
                    💾 Guardar Datos del Propietario
                </button>
            </div>
        </form>
    </div>
</div>

<jsp:include page="/WEB-INF/views/includes/footer.jsp" />
