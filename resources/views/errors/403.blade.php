<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Acceso Denegado</title>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
    <link rel="stylesheet" href="{{ asset('vendor/adminlte/dist/css/adminlte.min.css') }}">
    <link rel="stylesheet" href="{{ asset('vendor/fontawesome-free/css/all.min.css') }}">
</head>
<body class="hold-transition login-page">
<div class="login-box">
    <div class="card card-outline card-danger">
        <div class="card-header text-center">
            <a href="/" class="h1"><b>Error</b> 403</a>
        </div>
        <div class="card-body">
            <div class="text-center mb-4">
                <i class="fas fa-ban fa-3x text-danger"></i>
            </div>
            <p class="login-box-msg text-danger font-weight-bold">
                NO ERES ADMIN O NO TIENES PERMISOS DE ACCESO
            </p>
            <p class="text-center">
                Lo sentimos, no tienes autorización para ver esta página.
            </p>
            
            <div class="social-auth-links text-center mt-2 mb-3">
                <a href="{{ route('dashboard') }}" class="btn btn-block btn-primary">
                    <i class="fas fa-home mr-2"></i> Volver al Inicio
                </a>
                <a href="{{ route('logout') }}" onclick="event.preventDefault(); document.getElementById('logout-form').submit();" class="btn btn-block btn-secondary">
                    <i class="fas fa-sign-out-alt mr-2"></i> Cerrar Sesión
                </a>
                <form id="logout-form" action="{{ route('logout') }}" method="POST" class="d-none">
                    @csrf
                </form>
            </div>
        </div>
    </div>
</div>
</body>
</html>
