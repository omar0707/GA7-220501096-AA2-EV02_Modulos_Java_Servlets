/**
 * CanStyling - Scripts de interactividad para vistas JSP
 */
document.addEventListener("DOMContentLoaded", function () {
    // Manejo de tabs en la pantalla de Login (Contraseña / OTP)
    const tabBtns = document.querySelectorAll(".tab-btn");
    const tabPanes = document.querySelectorAll(".tab-pane");

    if (tabBtns.length > 0) {
        tabBtns.forEach(btn => {
            btn.addEventListener("click", function () {
                const targetTab = this.getAttribute("data-tab");
                tabBtns.forEach(b => b.classList.remove("active"));
                tabPanes.forEach(p => p.classList.remove("active"));

                this.classList.add("active");
                const activePane = document.getElementById(targetTab);
                if (activePane) activePane.classList.add("active");
            });
        });
    }

    // Carga dinamica de mascotas cuando cambia el cliente en el formulario de agendamiento
    const selectCliente = document.getElementById("selectCliente");
    const selectMascota = document.getElementById("selectMascota");

    if (selectCliente && selectMascota) {
        selectCliente.addEventListener("change", function () {
            const idCliente = this.value;
            selectMascota.innerHTML = '<option value="">Cargando mascotas...</option>';

            if (!idCliente) {
                selectMascota.innerHTML = '<option value="">-- Primero seleccione un cliente --</option>';
                return;
            }

            fetch("mascotas?action=api_por_cliente&idCliente=" + idCliente)
                .then(response => response.json())
                .then(data => {
                    selectMascota.innerHTML = '<option value="">-- Seleccione una mascota --</option>';
                    if (data.length === 0) {
                        selectMascota.innerHTML = '<option value="">(El cliente no tiene mascotas registradas)</option>';
                    } else {
                        data.forEach(m => {
                            const opt = document.createElement("option");
                            opt.value = m.idMascota;
                            opt.textContent = m.nombre + (m.raza ? " (" + m.raza + ")" : "");
                            selectMascota.appendChild(opt);
                        });
                    }
                })
                .catch(err => {
                    selectMascota.innerHTML = '<option value="">Error al cargar mascotas</option>';
                });
        });
    }

    // Auto-actualizacion de precio al seleccionar servicio
    const selectServicio = document.getElementById("selectServicio");
    const inputValorTotal = document.getElementById("valorTotal");

    if (selectServicio && inputValorTotal) {
        selectServicio.addEventListener("change", function () {
            const selectedOpt = this.options[this.selectedIndex];
            const precio = selectedOpt.getAttribute("data-precio");
            if (precio) {
                inputValorTotal.value = precio;
            }
        });
    }
});
