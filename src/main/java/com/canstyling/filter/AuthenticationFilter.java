package com.canstyling.filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

/**
 * Filtro de Seguridad que protege rutas administrativas contra accesos no autorizados.
 */
@WebFilter(filterName = "AuthenticationFilter", urlPatterns = {"/clientes/*", "/mascotas/*", "/admin/*"})
public class AuthenticationFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse resp = (HttpServletResponse) response;

        HttpSession session = req.getSession(false);
        boolean logueado = (session != null && (session.getAttribute("usuarioLogueado") != null || session.getAttribute("usuarioLogueadoEmail") != null));

        if (logueado) {
            chain.doFilter(request, response);
        } else {
            resp.sendRedirect(req.getContextPath() + "/login?error=requiere_autenticacion");
        }
    }
}
