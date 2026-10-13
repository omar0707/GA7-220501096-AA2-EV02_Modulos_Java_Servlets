package com.canstyling.servlet;

import com.canstyling.model.Cliente;
import com.canstyling.service.ClienteService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;
import java.util.Optional;

/**
 * Servlet para Gestion de Clientes y Propietarios de Mascotas.
 * Implementa acciones GET (listar, nuevo, editar) y POST (crear, actualizar, eliminar).
 */
@WebServlet(name = "ClienteServlet", urlPatterns = {"/clientes", "/clientes/*"})
public class ClienteServlet extends HttpServlet {

    private final ClienteService clienteService = new ClienteService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null) {
            action = "listar";
        }

        try {
            switch (action) {
                case "nuevo":
                    req.getRequestDispatcher("/WEB-INF/views/clientes/formulario.jsp").forward(req, resp);
                    break;
                case "editar":
                    int idEditar = Integer.parseInt(req.getParameter("id"));
                    Optional<Cliente> optCliente = clienteService.buscarPorId(idEditar);
                    if (optCliente.isPresent()) {
                        req.setAttribute("cliente", optCliente.get());
                        req.getRequestDispatcher("/WEB-INF/views/clientes/formulario.jsp").forward(req, resp);
                    } else {
                        resp.sendRedirect(req.getContextPath() + "/clientes?error=cliente_no_encontrado");
                    }
                    break;
                case "ver":
                    int idVer = Integer.parseInt(req.getParameter("id"));
                    Optional<Cliente> clienteVer = clienteService.buscarPorId(idVer);
                    if (clienteVer.isPresent()) {
                        req.setAttribute("cliente", clienteVer.get());
                        req.setAttribute("mascotas", clienteService.listarMascotasDeCliente(idVer));
                        req.getRequestDispatcher("/WEB-INF/views/clientes/detalle.jsp").forward(req, resp);
                    } else {
                        resp.sendRedirect(req.getContextPath() + "/clientes?error=cliente_no_encontrado");
                    }
                    break;
                case "listar":
                default:
                    List<Cliente> lista = clienteService.listarTodos();
                    req.setAttribute("clientes", lista);
                    req.getRequestDispatcher("/WEB-INF/views/clientes/listar.jsp").forward(req, resp);
                    break;
            }
        } catch (Exception e) {
            req.setAttribute("errorMessage", "Error al procesar la solicitud: " + e.getMessage());
            req.getRequestDispatcher("/WEB-INF/views/clientes/listar.jsp").forward(req, resp);
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
                String idStr = req.getParameter("idCliente");
                String tipoDoc = req.getParameter("tipoDocumento");
                String numDoc = req.getParameter("numeroDocumento");
                String nombres = req.getParameter("nombres");
                String apellidos = req.getParameter("apellidos");
                String correo = req.getParameter("correo");
                String direccion = req.getParameter("direccion");
                String ciudad = req.getParameter("ciudad");
                String telefono = req.getParameter("telefonoPrincipal");
                String tipoTel = req.getParameter("tipoTelefono");

                if (idStr == null || idStr.trim().isEmpty()) {
                    // Nuevo Cliente
                    Cliente nuevo = new Cliente(tipoDoc, numDoc, nombres, apellidos, correo, direccion, ciudad);
                    clienteService.registrarCliente(nuevo, telefono, tipoTel != null ? tipoTel : "WHATSAPP");
                    resp.sendRedirect(req.getContextPath() + "/clientes?msg=creado_ok");
                } else {
                    // Actualizar Cliente
                    int idCliente = Integer.parseInt(idStr);
                    Optional<Cliente> optExistente = clienteService.buscarPorId(idCliente);
                    if (optExistente.isPresent()) {
                        Cliente c = optExistente.get();
                        c.setTipoDocumento(tipoDoc);
                        c.setNumeroDocumento(numDoc);
                        c.setNombres(nombres);
                        c.setApellidos(apellidos);
                        c.setCorreo(correo);
                        c.setDireccion(direccion);
                        c.setCiudad(ciudad);
                        clienteService.actualizarCliente(c);
                        resp.sendRedirect(req.getContextPath() + "/clientes?msg=actualizado_ok");
                    }
                }
            } else if ("eliminar".equals(action)) {
                int idEliminar = Integer.parseInt(req.getParameter("id"));
                clienteService.eliminarCliente(idEliminar);
                resp.sendRedirect(req.getContextPath() + "/clientes?msg=eliminado_ok");
            }
        } catch (Exception e) {
            req.setAttribute("errorMessage", "Error: " + e.getMessage());
            req.getRequestDispatcher("/WEB-INF/views/clientes/formulario.jsp").forward(req, resp);
        }
    }
}
