# Sistema Contable Simple - Proyecto de Israel Pamuri

## 1. Introducción y Objetivos
Este proyecto consiste en el desarrollo de un **Sistema Contable Simple** pero robusto, diseñado para gestionar el **Libro Diario** y el **Plan de Cuentas** de una organización pequeña o mediana. 
El objetivo principal fue crear una herramienta dual que permitiera:
1.  **Gestión Administrativa Avanzada**: Un panel potente para el contador/administrador (usando Filament).
2.  **Consulta Rápida para Usuarios**: Una interfaz ligera y rápida para usuarios operativos (usando AdminLTE).

El sistema prioriza la **integridad de los datos** (partidas que cuadran Debe/Haber) y la **usabilidad** (búsquedas rápidas, reportes PDF y dashboards visuales).

---

## 2. Arquitectura Utilizada

El sistema está construido sobre **Laravel 12** (última versión), aprovechando su arquitectura MVC (Modelo-Vista-Controlador).

### Tecnologías y Paquetes Clave:
*   **FilamentPHP (v4.3 - Bleeding Edge)**: Utilizado para el Panel Administrativo (`/admin`). Provee t ablas dinámicas, formularios complejos (Repeaters) y gráficos interactivos sin escribir toneladas de HTML/JS.
*   **AdminLTE (v3.15)**: Utilizado para el Panel de Usuario Normal. Provee una interfaz clásica, ligera y familiar basada en Bootstrap 4/5.
*   **DomPDF**: Motor de generación de reportes PDF.
*   **PostgreSQL**: Base de datos relacional robusta (seleccionada por su manejo estricto de tipos y agrupación).
*   **DataTables + Ajax**: Para la visualización de datos en tiempo real en el panel de usuario.

### Estructura de Carpetas (MVC Tradicional + Filament):
*   `app/Models`: Modelos de datos (`LibroDiario`, `PlanDeCuentas`, `User`).
*   `app/Http/Controllers`: Lógica para el panel de usuario (`LibroDiarioController`).
*   `app/Filament/Resources`: Lógica para el panel administrativo (Resources, Pages, Widgets).
*   `resources/views`: Vistas Blade para AdminLTE y PDFs.

---

## 3. Matriz de Roles y Permisos

Hemos implementado un sistema de roles simple pero estricto:

| Rol | Email (Ejemplo) | Acceso a `/admin` (Filament) | Acceso a Panel Usuario (AdminLTE) | Permisos |
| :--- | :--- | :--- | :--- | :--- |
| **Admin** | `admin@admin.com` | ✅ SÍ | ✅ SÍ | Control total. Puede crear/editar/borrar Asientos y Cuentas. Ve Dashboard con métricas financieras. |
| **Usuario** | `user@test.com` | ❌ NO (Error 403) | ✅ SÍ | Solo lectura. Puede ver el Libro Diario (actualizado en tiempo real) y exportar PDFs. |

**Seguridad Implementada:**
*   Middleware `auth` para todas las rutas.
*   Implementación de interfaz `FilamentUser` en el modelo `User` para bloquear nativamente el acceso al panel admin mediante el método `canAccessPanel()`.
*   Página de Error **403 Personalizada** para usuarios curiosos que intentan entrar donde no deben.

---

## 4. Dashboard y Gráficos (Filament)

El panel administrativo cuenta con un Dashboard financiero en tiempo real:

1.  **Tarjetas de Resumen (StatsOverview)**:
    *   **Total Asientos**: Conteo total de registros agrupados.
    *   **Total Debe / Haber**: Sumas globales en moneda local (Bs.).
    *   *Nota*: Se implementó lógica para formatear dinero automáticamente.

2.  **Gráfico de Tendencia (LineChart)**:
    *   Muestra la evolución de los registros por día.
    *   Útil para detectar días con actividad contable inusual.

---

## 5. Reportes PDF

Se implementó un generador de reportes en `LibroDiarioController::pdf`.
*   **Lógica**: Filtra los asientos visibles (`estado = true`) y permite filtrar por rango de fechas (Inicio - Fin).
*   **Diseño**: Tabla limpia con cabeceras de asiento y detalles, calculando totales automáticos al pie del reporte.
*   **Tecnología**: Renderizado de vista Blade convertida a binario PDF mediante `barryvdh/dompdf`.

---

## 6. Dificultades Encontradas y Soluciones

Durante el desarrollo nos enfrentamos a desafíos técnicos interesantes:

### A. El problema del "Agrupamiento" en PostgreSQL
*   **Problema**: El Libro Diario guarda "partidas" (líneas), pero queríamos ver "Asientos" (grupos). PostgreSQL es muy estricto con `GROUP BY`.
*   **Solución 1 (Fallida)**: Intentamos agrupar la consulta SQL directamente en Filament. Falló porque Filament intenta ordenar por `ID` automáticamente, lo cual choca con `GROUP BY`.
*   **Solución Final**: Optamos por la funcionalidad nativa de **Agrupación Visual** de Filament (`->defaultGroup('numero_asiento')`). Es más estable y permite ver los subtotales sin romper la base de datos.

### B. Incompatibilidad de Versiones (Filament v4)
*   **Problema**: Errores `Class not found: EditAction` y `Class not found: Form`.
*   **Causa**: Descubrimos que el proyecto usa **Filament v4** (bleeding edge), donde cambiaron los namespaces de `Tables\Actions` a `Actions` y la clase `Form` se renombró a `Schema`.
*   **Solución**: Actualizamos todos los `Resources` y `Tables` para usar los nuevos namespaces (`Filament\Schemas\Schema`, `Filament\Actions\EditAction`).

### C. Rendimiento de la Vista de Usuario
*   **Problema**: El usuario quería ver cambios en tiempo real. Polling cada 1 segundo saturaba el servidor local (respuesta de 3s).
*   **Solución**: Implementamos **ETags (HTTP 304)**. El navegador pregunta "¿Hay cambios?", y si no los hay, el servidor responde en 5ms sin enviar datos. Además, ajustamos el intervalo a 5 segundos para un equilibrio perfecto.

---

## 7. Conclusiones y Mejoras Futuras

El sistema cumple con todos los requisitos funcionales de robustez contable y facilidad de uso. Es seguro, rápido y visualmente agradable.

**Posibles mejoras:**
*   Implementar un sistema de "Cierre de Gestión" que bloquee ediciones previas a una fecha.
*   Agregar exportación a Excel (además de PDF).
*   Implementar un módulo de "Libro Mayor" automatizado.

---

## 8. Anexos: Fragmentos de Código Clave

### A. ETag para Optimización (Controller)
```php
public function data(Request $request)
{
    $lastModified = LibroDiario::max('updated_at');
    $etag = md5($lastModified ?? '0');

    if ($request->header('If-None-Match') === $etag) {
       return response()->noContent(304);
    }
    // ... query normal ...
    return response()->json(['data' => $asientos])->setEtag($etag);
}
```

### B. Seguridad de Acceso (Modelo User)
```php
public function canAccessPanel(Panel $panel): bool
{
    return $this->role === 'admin';
}
```

---
*Documentación generada por Israel Pamuri - Diciembre 2025*
