<?php

use App\Http\Controllers\AuthController;
use App\Http\Controllers\RegisterController;
use App\Http\Controllers\LibroDiarioController;
use Illuminate\Support\Facades\Route;

Route::get('/', function () {
    return auth()->check() ? redirect()->route('dashboard') : redirect()->route('login');
});

// Rutas públicas
Route::get('login', [AuthController::class, 'showLoginForm'])->name('login');
Route::post('login', [AuthController::class, 'login']);
Route::get('register', [RegisterController::class, 'showRegisterForm'])->name('register');
Route::post('register', [RegisterController::class, 'register']);
Route::post('logout', [AuthController::class, 'logout'])->name('logout');

// Rutas protegidas
Route::middleware(['auth'])->group(function () {
    Route::get('/dashboard', function () {
        return view('dashboard');
    })->name('dashboard');

    // Rutas para Libros Diarios

    Route::get('/libro-diario', [LibroDiarioController::class, 'index'])->name('libro-diario.index');
    Route::get('/libro-diario/create', [LibroDiarioController::class, 'create'])->name('libro-diario.create');
    Route::post('/libro-diario', [LibroDiarioController::class, 'store'])->name('libro-diario.store');
    Route::get('/libro-diario/pdf', [LibroDiarioController::class, 'pdf'])->name('libro-diario.pdf');
    Route::get('/libro-diario/data', [LibroDiarioController::class, 'data'])->name('libro-diario.data');
    Route::get('/libro-diario/{numeroAsiento}', [LibroDiarioController::class, 'show'])->name('libro-diario.show');
    
    // Rutas para Plan de Cuentas
    Route::resource('plan-de-cuentas', \App\Http\Controllers\PlanDeCuentasController::class);

    // Ruta del dashboard con datos reales
    Route::get('/dashboard', function () {
        // Obtener estadísticas del libro diario
        $totalAsientos = \App\Models\LibroDiario::distinct('numero_asiento')->count('numero_asiento');
        $totalPartidas = \App\Models\LibroDiario::count();
        $totalDebe = \App\Models\LibroDiario::sum('debe');
        $totalHaber = \App\Models\LibroDiario::sum('haber');
        $totalMovimientos = $totalDebe + $totalHaber;

        // Obtener últimos 5 asientos
        $ultimosAsientos = \App\Models\LibroDiario::selectRaw('
        numero_asiento,
        fecha,
        descripcion,
        COUNT(*) as total_partidas,
        SUM(debe) as total_debe,
        SUM(haber) as total_haber
    ')
            ->groupBy('numero_asiento', 'fecha', 'descripcion')
            ->orderBy('numero_asiento', 'desc')
            ->limit(5)
            ->limit(5)
            ->get();

        // Datos para la gráfica (Últimos 7 días)
        $balanceDiario = \App\Models\LibroDiario::selectRaw('DATE(fecha) as fecha_dia, SUM(debe) as total_debe, SUM(haber) as total_haber')
            ->where('estado', true)
            ->where('fecha', '>=', now()->subDays(7))
            ->groupBy('fecha_dia')
            ->orderBy('fecha_dia')
            ->get();

        $chartLabels = $balanceDiario->pluck('fecha_dia')->map(fn($date) => \Carbon\Carbon::parse($date)->format('d/m'))->toArray();
        $chartData = $balanceDiario->map(fn($item) => $item->total_debe + $item->total_haber)->toArray();

        return view('dashboard', compact(
            'totalAsientos',
            'totalPartidas',
            'totalDebe',
            'totalHaber',
            'totalMovimientos',
            'totalMovimientos',
            'ultimosAsientos',
            'chartLabels',
            'chartData'
        ));
    })->name('dashboard');
});
