<%@ page import="java.util.*" %>
<%
    request.setCharacterEncoding("UTF-8");

    // Paso 1: Solicitar cantidad de puntajes
    String cantidadStr = request.getParameter("cantidad");
    Integer cantidad = null;

    if (cantidadStr != null) {
        try {
            cantidad = Integer.parseInt(cantidadStr);
            if (cantidad < 5 || cantidad > 15) cantidad = null;
        } catch (Exception e) {
            cantidad = null;
        }
    }

    if (cantidad == null) {
%>
        <h2>Ingresa la cantidad de puntajes (5 - 15)</h2>
        <form>
            <input type="number" name="cantidad" min="5" max="15" required>
            <button type="submit">Continuar</button>
        </form>
<%
        return;
    }

    // Paso 2: Capturar los puntajes
    int[] puntajes = new int[cantidad];
    boolean datosCompletos = true;

    for (int i = 0; i < cantidad; i++) {
        String p = request.getParameter("p" + i);

        if (p == null) {
            datosCompletos = false;
            break;
        }

        try {
            int valor = Integer.parseInt(p);
            if (valor < 0 || valor > 100) datosCompletos = false;
            puntajes[i] = valor;
        } catch (Exception e) {
            datosCompletos = false;
        }
    }

    if (!datosCompletos) {
%>
        <h2>Ingresa los puntajes (0 - 100)</h2>
        <form>
            <input type="hidden" name="cantidad" value="<%= cantidad %>">
            <% for (int i = 0; i < cantidad; i++) { %>
                Puntaje <%= (i+1) %>:
                <input type="number" name="p<%= i %>" min="0" max="100" required><br><br>
            <% } %>
            <button type="submit">Procesar</button>
        </form>
<%
        return;
    }

    // Paso 3: Procesar resultados (misma lógica que tu código)
    int mayor = 0;
    int menor = 999999;
    int total = 0;
    int mayoresA89 = 0;

    String aprobadosMsg = "";
    String reprobadosMsg = "";

    for (int i = 0; i < cantidad; i++) {
        int p = puntajes[i];

        if (p > mayor) mayor = p;
        if (p < menor) menor = p;

        total += p;

        if (p > 89) {
            mayoresA89++;
        } else if (p >= 60) {
            aprobadosMsg += "Puntaje " + (i+1) + " aprobado con: " + p + "<br>";
        }

        if (p < 60) {
            reprobadosMsg += "Puntaje " + (i+1) + " reprobado con: " + p + "<br>";
        }
    }

    double promedio = (double) total / cantidad;

    String opcionStr = request.getParameter("opcion");
    Integer opcion = null;

    if (opcionStr != null) {
        try { opcion = Integer.parseInt(opcionStr); } catch (Exception e) {}
    }
%>

<h2>Menú de opciones</h2>
<form>
    <% for (int i = 0; i < cantidad; i++) { %>
        <input type="hidden" name="p<%= i %>" value="<%= puntajes[i] %>">
    <% } %>
    <input type="hidden" name="cantidad" value="<%= cantidad %>">

    <button name="opcion" value="1">Ver resumen general</button>
    <button name="opcion" value="2">Ver aprobados</button>
    <button name="opcion" value="3">Ver reprobados</button>
</form>

<hr>

<%
    if (opcion != null) {
        switch (opcion) {
            case 1:
%>
                <h3>Resumen General</h3>
                <p>Puntaje mayor: <%= mayor %></p>
                <p>Puntaje menor: <%= menor %></p>
                <p>Promedio general: <%= promedio %></p>
                <p>Mayores o iguales a 90: <%= mayoresA89 %></p>
<%
                break;

            case 2:
%>
                <h3>Aprobados</h3>
                <p><%= aprobadosMsg %></p>
<%
                break;

            case 3:
%>
                <h3>Reprobados</h3>
                <p><%= reprobadosMsg %></p>
<%
                break;
        }
    }
%>
