package com.canstyling.servlet;

import com.canstyling.dao.MascotaDAO;
import com.canstyling.dao.impl.MascotaDAOImpl;
import com.canstyling.model.Mascota;
import com.canstyling.model.Raza;
import com.canstyling.service.ClienteService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.util.List;

/**
 * Servlet para Gestion de Mascotas y endpoint auxiliar de carga dinamica.
 */
@WebServlet(name = "MascotaServlet", urlPatterns = {"/mascotas", "/mascotas/*"})
public class MascotaServlet extends HttpServlet {

    private final ClienteService clienteService = new ClienteService();
    private final MascotaDAO mascotaDAO = new MascotaDAOImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");

        if ("api_por_cliente".equals(action)) {
            // Retorna JSON simple con las mascotas del cliente para formularios dinamicos
            resp.setContentType("application/json;charset=UTF-8");
            try {
                int idCliente = Integer.parseInt(req.getParameter("idCliente"));
                List<Mascota> mascotas = clienteService.listarMascotasDeCliente(idCliente);
                PrintWriter out = resp.getWriter();
                StringBuilder json = new StringBuilder("[");
                for (int i = 0; i < mascotas.size(); i++) {
                    Mascota m = mascotas.get(i);
                    json.append(String.format("{\"idMascota\":%d,\"nombre\":\"%s\",\"raza\":\"%s\"}",
                            m.getIdMascota(), m.getNombre(), m.getNombreRaza() != null ? m.getNombreRaza() : ""));
                    if (i < mascotas.size() - 1) json.append(",");
                }
                json.append("]");
                out.print(json.toString());
                out.flush();
            } catch (Exception e) {
                resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            }
            return;
        }

        try {
            List<Raza> razas = mascotaDAO.findAllRazas();
            req.setAttribute("razas", razas);
            req.getRequestDispatcher("/WEB-INF/views/mascotas/formulario.jsp").forward(req, resp);
        } catch (Exception e) {
            resp.sendRedirect(req.getContextPath() + "/clientes?error=error_razas");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            int idCliente = Integer.parseInt(req.getParameter("idCliente"));
            int idRaza = Integer.parseInt(req.getParameter("idRaza"));
            String nombre = req.getParameter("nombre");
            String genero = req.getParameter("genero");
            int edad = Integer.parseInt(req.getParameter("edadAnos"));
            BigDecimal peso = new BigDecimal(req.getParameter("pesoKg"));
            String color = req.getParameter("color");

            Mascota m = new Mascota(idCliente, idRaza, nombre, genero, edad, peso, color);
            clienteService.registrarMascota(m);
            resp.sendRedirect(req.getContextPath() + "/clientes?action=ver&id=" + idCliente + "&msg=mascota_creada");
        } catch (Exception e) {
            req.setAttribute("errorMessage", "Error al registrar mascota: " + e.getMessage());
            req.getRequestDispatcher("/WEB-INF/views/mascotas/formulario.jsp").forward(req, resp);
        }
    }
}
