package com.canstyling.servlet;

import com.canstyling.model.Cita;
import com.canstyling.model.Cliente;
import com.canstyling.model.Servicio;
import com.canstyling.service.CitaService;
import com.canstyling.service.ClienteService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

/**
 * Servlet para Gestion de Citas, Turnos y Generacion de Tokens Anti-IDOR.
 */
@WebServlet(name = "CitaServlet", urlPatterns = {"/citas", "/citas/*"})
public class CitaServlet extends HttpServlet {

    private final CitaService citaService = new CitaService();
    private final ClienteService clienteService = new ClienteService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null) {
            action = "listar";
        }

        try {
            switch (action) {
                case "agendar":
                    cargarFormularioAgendamiento(req, resp);
                    break;
                case "completar":
                    int idCompletar = Integer.parseInt(req.getParameter("id"));
                    Optional<Cita> optCita = citaService.listarTodas().stream().filter(c -> c.getIdCita() == idCompletar).findFirst();
                    if (optCita.isPresent()) {
                        req.setAttribute("cita", optCita.get());
                        req.getRequestDispatcher("/WEB-INF/views/citas/completar.jsp").forward(req, resp);
                    } else {
                        resp.sendRedirect(req.getContextPath() + "/citas?error=no_encontrada");
                    }
                    break;
                case "listar":
                default:
                    String estadoFiltro = req.getParameter("estado");
                    List<Cita> citas;
                    if (estadoFiltro != null && !estadoFiltro.trim().isEmpty()) {
                        citas = citaService.listarPorEstado(estadoFiltro);
                    } else {
                        citas = citaService.listarTodas();
                    }
                    req.setAttribute("citas", citas);
                    req.setAttribute("estadoSeleccionado", estadoFiltro);
                    req.getRequestDispatcher("/WEB-INF/views/citas/listar.jsp").forward(req, resp);
                    break;
            }
        } catch (Exception e) {
            req.setAttribute("errorMessage", "Error al procesar citas: " + e.getMessage());
            req.getRequestDispatcher("/WEB-INF/views/citas/listar.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null) {
            action = "guardar";
        }

        try {
            if ("guardar".equals(action)) {
                int idCliente = Integer.parseInt(req.getParameter("idCliente"));
                int idMascota = Integer.parseInt(req.getParameter("idMascota"));
                int idServicio = Integer.parseInt(req.getParameter("idServicio"));
                String fechaHoraStr = req.getParameter("fechaHora");
                BigDecimal valorTotal = new BigDecimal(req.getParameter("valorTotal"));
                String observaciones = req.getParameter("observaciones");

                Timestamp fechaHora;
                if (fechaHoraStr != null && !fechaHoraStr.trim().isEmpty()) {
                    fechaHora = Timestamp.valueOf(fechaHoraStr.replace("T", " ") + ":00");
                } else {
                    fechaHora = Timestamp.valueOf(LocalDateTime.now().plusHours(2));
                }

                Cita citaCreada = citaService.agendarCita(idCliente, idMascota, idServicio, fechaHora, valorTotal, BigDecimal.ZERO, observaciones);
                resp.sendRedirect(req.getContextPath() + "/citas?msg=cita_agendada_ok&token=" + citaCreada.getTokenAcceso());

            } else if ("finalizar_servicio".equals(action)) {
                int idCita = Integer.parseInt(req.getParameter("idCita"));
                String observacionesEntrega = req.getParameter("observacionesEntrega");
                citaService.completarServicio(idCita, observacionesEntrega);
                resp.sendRedirect(req.getContextPath() + "/citas?msg=servicio_completado_ok");
            }
        } catch (Exception e) {
            req.setAttribute("errorMessage", "Error al agendar cita: " + e.getMessage());
            try {
                cargarFormularioAgendamiento(req, resp);
            } catch (Exception ignored) {
            }
        }
    }

    private void cargarFormularioAgendamiento(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        List<Cliente> clientes = clienteService.listarTodos();
        List<Servicio> servicios = citaService.obtenerServiciosDisponibles();
        req.setAttribute("clientes", clientes);
        req.setAttribute("servicios", servicios);
        req.getRequestDispatcher("/WEB-INF/views/citas/agendar.jsp").forward(req, resp);
    }
}
