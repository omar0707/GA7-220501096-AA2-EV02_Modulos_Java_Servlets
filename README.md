# Evidencia GA7-220501096-AA2-EV02: Modulos de Software Codificados y Probados (Java Web Servlets & JSP)

**Programa de Formacion:** Analisis y Desarrollo de Software (ADSO)  
**Ficha:** 3186645  
**Aprendiz:** Omar Ulpiano Molina Malaver  
**Instructor:** Adonay Sanchez Vertel  
**Centro de Formacion:** Centro Agropecuario y de Biotecnologia El Porvenir (SENA - Regional Cordoba / Monteria)  
**Proyecto:** Sistema de Gestion para Peluqueria Canina - *CanStyling*  
**Fecha:** Septiembre de 2026  

---

## 1. Descripcion de la Evidencia

La presente evidencia corresponde al desarrollo del **modulo web dinamico** del proyecto formativo *CanStyling*, implementando la arquitectura **Modelo-Vista-Controlador (MVC)** basada en tecnologias estandar de **Java Web**:
* **Controladores:** Servlets de Java (`HttpServlet`) manejando el ciclo de vida de peticiones HTTP con metodos `doGet()` y `doPost()`.
* **Vistas:** Paginas **JSP (JavaServer Pages)** articuladas con la libreria de etiquetas estandar **JSTL (Jakarta Standard Tag Library)**, HTML5 semantico y CSS responsivo.
* **Modelo y Acceso a Datos:** Entidades JavaBeans y capa DAO conectada a MySQL mediante JDBC con `PreparedStatement`.
* **Filtros de Red (Web Filters):** Seguridad perimetral (`AuthenticationFilter`) y codificacion de caracteres (`EncodingFilter`).

---

## 2. Estructura del Proyecto Web

```
GA7-220501096-AA2-EV02_Modulos_Java_Servlets/
│
├── pom.xml                                        # Empaquetado WAR y dependencias Servlet/JSTL
├── .env                                           # Configuracion local de base de datos
├── .gitignore                                     # Exclusion de credenciales y artefactos temporales
├── README.md                                      # Sustentacion tecnica de la evidencia
│
└── src/
    └── main/
        ├── java/com/canstyling/
        │   ├── servlet/                           # Controladores HTTP (Servlets)
        │   │   ├── AuthServlet.java               # Login tradicional y Passwordless con OTP (GET/POST)
        │   │   ├── ClienteServlet.java            # CRUD de Propietarios y telefonos (GET/POST)
        │   │   ├── MascotaServlet.java            # Fichas caninas y API JSON auxiliar (GET/POST)
        │   │   ├── CitaServlet.java               # Agenda de turnos, estados y Anti-IDOR (GET/POST)
        │   │   └── AlbumPublicoServlet.java       # Visualizacion publica de fotos por Token UUID (GET)
        │   ├── filter/                            # Interceptores de Peticiones
        │   │   ├── AuthenticationFilter.java      # Control de acceso a modulos administrativos
        │   │   └── EncodingFilter.java            # Garantia de codificacion UTF-8
        │   ├── config/                            # DatabaseConnection Singleton y EnvConfig
        │   ├── model/                             # Entidades JavaBeans (Cliente, Mascota, Cita, OTP)
        │   ├── dao/ & dao/impl/                   # Capa de persistencia JDBC con PreparedStatement
        │   ├── service/                           # Logica de negocio, calculo de turnos y seguridad
        │   └── util/                              # Criptografia, Tokens Anti-IDOR y Hashing
        │
        └── webapp/                                # Raiz Web (Vistas y Assets)
            ├── index.jsp                          # Landing de bienvenida y accesos directos
            ├── assets/
            │   ├── css/styles.css                 # Diseño visual CanStyling (Grid, Badges, Botones)
            │   └── js/main.js                     # Interactividad (Tabs OTP y carga dinamica de mascotas)
            └── WEB-INF/
                ├── web.xml                        # Descriptor de despliegue y control de sesiones
                └── views/
                    ├── login.jsp                  # Formulario con pestañas: Contraseña y Codigo OTP
                    ├── album.jsp                  # Album digital Anti-IDOR (Antes / Despues)
                    ├── includes/                  # Fragmentos modulares (header, navbar, footer)
                    ├── citas/                     # Vistas de agenda (listar, agendar, completar)
                    ├── clientes/                  # Vistas de directorio (listar, formulario, detalle)
                    └── mascotas/                  # Formulario de registro de ficha canina
```

---

## 3. Matriz de Servlets y Metodos HTTP Implementados

| Servlet | Patron URL | Metodo GET (`doGet`) | Metodo POST (`doPost`) |
| :--- | :--- | :--- | :--- |
| **`AuthServlet`** | `/login`, `/auth`, `/logout` | Renderiza formulario de acceso / Cierra sesion HTTP | Procesa login con clave (BCrypt) o valida codigo OTP (Passwordless) |
| **`ClienteServlet`** | `/clientes`, `/clientes/*` | Lista clientes, abre formulario nuevo/editar y ficha | Guarda cliente nuevo con multi-telefono, actualiza o elimina |
| **`MascotaServlet`** | `/mascotas`, `/mascotas/*` | Formulario de raza/mascota o API JSON `api_por_cliente` | Registra nueva mascota vinculada al cliente |
| **`CitaServlet`** | `/citas`, `/citas/*` | Lista citas con filtros por estado o formulario agendar | Crea cita generando **Token Anti-IDOR** o finaliza servicio |
| **`AlbumPublicoServlet`** | `/album` | Valida Token UUID y renderiza comparativa Antes/Despues | N/A (Acceso idempotente de solo lectura) |

---

## 4. Implementacion de Directrices de Seguridad

1. **Proteccion Anti-IDOR (Insecure Direct Object References)**:
   * Los clientes consultan las fotos de sus mascotas a traves de `/album?token=[UUID-ALEATORIO]`.
   * Si un usuario intenta acceder modificando IDs numericos correlativos (`id=1`, `id=2`), el sistema no respondera con datos ajenos, protegiendo la privacidad de los propietarios.
2. **Autenticacion en Dos Factores / Passwordless OTP**:
   * Los usuarios pueden ingresar mediante codigo OTP de 6 digitos con vigencia de 5 minutos, cooldown de 60 segundos y limite de 3 intentos fallidos.
3. **Filtros Web de Seguridad (`WebFilter`)**:
   * Las rutas sensibles de administracion (`/clientes/*`, `/mascotas/*`) son interceptadas por `AuthenticationFilter.java` verificando la sesion activa.
4. **Proteccion contra Inyeccion SQL**:
   * La totalidad de las consultas que alimentan los Servlets emplean `PreparedStatement` parametrizados.

---

## 5. Guia de Ejecucion y Pruebas

### Opcion 1: En Servidor de Aplicaciones (Apache Tomcat 10+ / Eclipse / IntelliJ)
1. Importe el proyecto en su IDE favorito como proyecto Maven Web.
2. Configure el servidor **Apache Tomcat 10.x** (compatible con Jakarta Servlet 5.0/6.0).
3. Despliegue el artefacto `canstyling-web.war`.
4. Acceda desde su navegador web a: `http://localhost:8080/canstyling-web/`.

### Opcion 2: Flujo de Pruebas de Usuario Recomendado
1. **Inicio:** Ingrese a la raiz del sitio para visualizar el banner de bienvenida y accesos rapidos.
2. **Login OTP:** Vaya a *Iniciar Sesion* -> pestaña *Codigo OTP*, ingrese `admin@canstyling.com` o el correo de un cliente, solicite el codigo de 6 digitos y valide el acceso.
3. **Agendar Cita:** En la seccion *Citas*, haga clic en *Agendar Nueva Cita*, seleccione cliente, mascota (se carga dinamicamente via AJAX/Fetch) y servicio.
4. **Ver Album:** Al crearse la cita, copie el enlace con el Token UUID generado y pruebelo en una pestaña de incognito para verificar que se muestra la comparativa visual de "Antes y Despues" de forma segura.
