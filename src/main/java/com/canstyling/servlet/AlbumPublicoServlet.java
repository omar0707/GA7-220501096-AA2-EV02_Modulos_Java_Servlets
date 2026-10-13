package com.canstyling.servlet;

import com.canstyling.model.Cita;
import com.canstyling.service.CitaService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.Optional;

/**
 * Servlet Publico para Visualizacion del Album Digital de la Mascota.
 * Aplica diseño de seguridad Anti-IDOR: El cliente solo puede consultar el servicio
 * mediante un Token UUID impredecible (ej. /album?token=e4b2d18a-78f9-4c12-98ab-34cd56ef7890).
 */
@WebServlet(name = "AlbumPublicoServlet", urlPatterns = {"/album", "/album-digital"})
public class AlbumPublicoServlet extends HttpServlet {

    private final CitaService citaService = new CitaService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String token = req.getParameter("token");

        if (token == null || token.trim().isEmpty()) {
            req.setAttribute("tokenInvalido", true);
            req.getRequestDispatcher("/WEB-INF/views/album.jsp").forward(req, resp);
            return;
        }

        try {
            Optional<Cita> optCita = citaService.consultarAlbumPorToken(token.trim());
            if (optCita.isPresent()) {
                req.setAttribute("cita", optCita.get());
                req.setAttribute("tokenInvalido", false);
            } else {
                req.setAttribute("tokenInvalido", true);
            }
        } catch (Exception e) {
            req.setAttribute("tokenInvalido", true);
            req.setAttribute("errorMessage", "Error al consultar el álbum: " + e.getMessage());
        }

        req.getRequestDispatcher("/WEB-INF/views/album.jsp").forward(req, resp);
    }
}
