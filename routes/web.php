<?php

use App\Http\Controllers\AuthController;
use App\Http\Controllers\RegisterController;
use App\Http\Controllers\LibroDiarioController;
use Illuminate\Support\Facades\Route;

Route::get('/', function () {
    return redirect()->route('login');
});

// Rutas públicas
Route::get('login', [AuthController::class, 'showLoginForm'])->name('login');
Route::post('login', [AuthController::class, 'login']);
Route::get('register', [RegisterController::class, 'showRegisterForm'])->name('register');
Route::post('register', [RegisterController::class, 'register']);

// Rutas protegidas
Route::middleware(['auth'])->group(function () {
    Route::get('/dashboard', function () {
        return view('dashboard');
    })->name('dashboard');

    // Rutas para Libros Diarios

    Route::get('/libro-diario', [LibroDiarioController::class, 'index'])->name('libro-diario.index');
    Route::get('/libro-diario/create', [LibroDiarioController::class, 'create'])->name('libro-diario.create');
    Route::post('/libro-diario', [LibroDiarioController::class, 'store'])->name('libro-diario.store');
    Route::get('/libro-diario/data', [LibroDiarioController::class, 'data'])->name('libro-diario.data');
    Route::get('/libro-diario/{numeroAsiento}', [LibroDiarioController::class, 'show'])->name('libro-diario.show');
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
            ->get();

        return view('dashboard', compact(
            'totalAsientos',
            'totalPartidas',
            'totalDebe',
            'totalHaber',
            'totalMovimientos',
            'ultimosAsientos'
        ));
    })->name('dashboard');
});
