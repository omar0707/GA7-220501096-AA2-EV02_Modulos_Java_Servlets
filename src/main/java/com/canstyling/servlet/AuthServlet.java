package com.canstyling.servlet;

import com.canstyling.model.CodigoOTP;
import com.canstyling.model.Usuario;
import com.canstyling.service.AuthService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.Optional;

/**
 * Servlet para Gestion de Autenticacion, Login con Contraseña y Login Passwordless con OTP.
 * Cumple con los requerimientos de manejo de metodos GET y POST.
 */
@WebServlet(name = "AuthServlet", urlPatterns = {"/auth", "/login", "/logout"})
public class AuthServlet extends HttpServlet {

    private final AuthService authService = new AuthService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String servletPath = req.getServletPath();

        if ("/logout".equals(servletPath) || "logout".equals(req.getParameter("action"))) {
            HttpSession session = req.getSession(false);
            if (session != null) {
                session.invalidate();
            }
            resp.sendRedirect(req.getContextPath() + "/login?msg=sesion_cerrada");
            return;
        }

        // Mostrar formulario de login
        req.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null) {
            action = "login_password";
        }

        try {
            switch (action) {
                case "login_password":
                    procesarLoginPassword(req, resp);
                    break;
                case "solicitar_otp":
                    procesarSolicitudOtp(req, resp);
                    break;
                case "verificar_otp":
                    procesarVerificacionOtp(req, resp);
                    break;
                default:
                    resp.sendRedirect(req.getContextPath() + "/login?error=accion_invalida");
            }
        } catch (Exception e) {
            req.setAttribute("errorMessage", e.getMessage());
            req.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(req, resp);
        }
    }

    private void procesarLoginPassword(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        String correo = req.getParameter("correo");
        String password = req.getParameter("password");

        if (correo == null || password == null || correo.trim().isEmpty() || password.trim().isEmpty()) {
            req.setAttribute("errorMessage", "Debe ingresar correo y contraseña.");
            req.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(req, resp);
            return;
        }

        Optional<Usuario> usuarioOpt = authService.loginConPassword(correo, password);
        if (usuarioOpt.isPresent()) {
            Usuario u = usuarioOpt.get();
            HttpSession session = req.getSession(true);
            session.setAttribute("usuarioLogueado", u);
            session.setAttribute("rolUsuario", u.getNombreRol());
            session.setAttribute("nombreUsuario", u.getNombreCompleto());
            resp.sendRedirect(req.getContextPath() + "/citas");
        } else {
            req.setAttribute("errorMessage", "Credenciales incorrectas o usuario inactivo.");
            req.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(req, resp);
        }
    }

    private void procesarSolicitudOtp(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        String correo = req.getParameter("correo_otp");
        if (correo == null || correo.trim().isEmpty()) {
            req.setAttribute("errorMessageOtp", "Ingrese su correo electrónico.");
            req.setAttribute("activeTab", "otp");
            req.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(req, resp);
            return;
        }

        CodigoOTP otp = authService.solicitarOtpLogin(correo);
        req.setAttribute("correoOtpEnviado", correo);
        req.setAttribute("otpGeneradoSimulado", otp.getCodigoPlano()); // Simulacion visual para propositos academicos
        req.setAttribute("stepOtp", "verificar");
        req.setAttribute("activeTab", "otp");
        req.setAttribute("successMessageOtp", "Código de seguridad de 6 dígitos generado con éxito. Vigencia: 5 minutos.");
        req.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(req, resp);
    }

    private void procesarVerificacionOtp(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        String correo = req.getParameter("correo_otp_hidden");
        String codigoIngresado = req.getParameter("codigo_otp");

        boolean ok = authService.verificarOtpLogin(correo, codigoIngresado);
        if (ok) {
            HttpSession session = req.getSession(true);
            session.setAttribute("usuarioLogueadoEmail", correo);
            session.setAttribute("rolUsuario", "CLIENTE_VERIFICADO");
            session.setAttribute("nombreUsuario", correo);
            resp.sendRedirect(req.getContextPath() + "/citas?msg=auth_otp_ok");
        } else {
            req.setAttribute("correoOtpEnviado", correo);
            req.setAttribute("stepOtp", "verificar");
            req.setAttribute("activeTab", "otp");
            req.setAttribute("errorMessageOtp", "Código OTP incorrecto, expirado o límite de intentos excedido.");
            req.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(req, resp);
        }
    }
}
