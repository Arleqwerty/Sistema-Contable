<?php

namespace App\Http\Controllers;

use App\Models\LibroDiario;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class LibroDiarioController extends Controller
{
    // Mostrar listado de libros diarios
    public function index()
    {
        return view('libros-diarios.index');
    }

    public function pdf(Request $request)
    {
        $asientos = LibroDiario::where('estado', true)
        ->selectRaw('
            numero_asiento,
            fecha,
            descripcion,
            COUNT(*) as total_partidas,
            SUM(debe) as total_debe,
            SUM(haber) as total_haber
        ')
        ->when($request->fecha_inicio, function ($query, $fecha) {
            return $query->where('fecha', '>=', $fecha);
        })
        ->when($request->fecha_fin, function ($query, $fecha) {
            return $query->where('fecha', '<=', $fecha);
        })
        ->groupBy('numero_asiento', 'fecha', 'descripcion')
        ->orderBy('numero_asiento', 'desc')
        ->get();

        $pdf = \Barryvdh\DomPDF\Facade\Pdf::loadView('libros-diarios.pdf', compact('asientos'));
        return $pdf->stream('libro-diario.pdf');
    }

    // Mostrar formulario de creación
    public function create()
    {
        // Obtener el próximo número de asiento
        $ultimoAsiento = LibroDiario::max('numero_asiento');
        $proximoAsiento = $ultimoAsiento ? $ultimoAsiento + 1 : 1;
        
        // Obtener cuentas imputables para el select
        $cuentas = \App\Models\PlanDeCuentas::where('es_imputable', true)
            ->orderBy('codigo')
            ->get();

        return view('libros-diarios/create', compact('proximoAsiento', 'cuentas'));
    }

    // Guardar nuevo asiento contable
    public function store(Request $request)
    {
        try {
            DB::beginTransaction();

            $validated = $request->validate([
                'fecha' => 'required|date',
                'descripcion' => 'required|string|max:255',
                'partidas' => 'required|array|min:2',
                'partidas.*.codigo_cuenta' => 'required|string|max:20',
                'partidas.*.nombre_cuenta' => 'required|string|max:100',
                'partidas.*.debe' => 'required|numeric|min:0',
                'partidas.*.haber' => 'required|numeric|min:0',
            ]);

            // Calcular totales
            $totalDebe = 0;
            $totalHaber = 0;

            foreach ($request->partidas as $partida) {
                $totalDebe += $partida['debe'];
                $totalHaber += $partida['haber'];
            }

            // Validar que debe = haber
            if (round($totalDebe, 2) !== round($totalHaber, 2)) {
                return response()->json([
                    'success' => false,
                    'message' => 'El total del Debe ('.number_format($totalDebe, 2).') no coincide con el total del Haber ('.number_format($totalHaber, 2).')'
                ], 422);
            }

            // Obtener número de asiento
            $ultimoAsiento = LibroDiario::max('numero_asiento');
            $numeroAsiento = $ultimoAsiento ? $ultimoAsiento + 1 : 1;

            // Guardar cada partida
            foreach ($request->partidas as $partida) {
                LibroDiario::create([
                    'fecha' => $request->fecha,
                    'descripcion' => $request->descripcion,
                    'numero_asiento' => $numeroAsiento,
                    'codigo_cuenta' => $partida['codigo_cuenta'],
                    'nombre_cuenta' => $partida['nombre_cuenta'],
                    'debe' => $partida['debe'],
                    'haber' => $partida['haber'],
                    'estado' => true
                ]);
            }

            DB::commit();

            return response()->json([
                'success' => true,
                'message' => 'Asiento contable guardado correctamente',
                'numero_asiento' => $numeroAsiento
            ]);

        } catch (\Exception $e) {
            DB::rollBack();
            return response()->json([
                'success' => false,
                'message' => 'Error al guardar el asiento: ' . $e->getMessage()
            ], 500);
        }
    }

    // Datos para DataTable
    public function data(Request $request)
    {
        // Generar ETag basado en la última modificación de la tabla
        $lastModified = LibroDiario::max('updated_at');
        $etag = md5($lastModified ?? '0');

        if ($request->header('If-None-Match') === $etag) {
           return response()->noContent(304);
        }

        $asientos = LibroDiario::where('estado', true)
        ->selectRaw('
            numero_asiento,
            fecha,
            descripcion,
            COUNT(*) as total_partidas,
            SUM(debe) as total_debe,
            SUM(haber) as total_haber
        ')
        ->groupBy('numero_asiento', 'fecha', 'descripcion')
        ->orderBy('numero_asiento', 'desc')
        ->get();

        return response()->json([
            'data' => $asientos
        ])->setEtag($etag);
    }

    // Detalle de un asiento específico
    public function show($numeroAsiento)
    {
        $partidas = LibroDiario::where('numero_asiento', $numeroAsiento)
                              ->orderBy('debe', 'desc')
                              ->get();

        return response()->json([
            'data' => $partidas
        ]);
    }
}