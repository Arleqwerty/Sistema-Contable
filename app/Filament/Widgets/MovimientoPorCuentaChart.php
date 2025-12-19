<?php

namespace App\Filament\Widgets;

use Filament\Widgets\ChartWidget;
use Illuminate\Support\Facades\DB;
use App\Models\LibroDiario;

class MovimientoPorCuentaChart extends ChartWidget
{
    protected ?string $heading = 'Top 5 Cuentas con Mayor Movimiento (Bs.)';
    protected static ?int $sort = 2;

    protected function getData(): array
    {
        // Agrupar por nombre de cuenta y sumar debe + haber
        $data = LibroDiario::select('nombre_cuenta', DB::raw('SUM(debe + haber) as total_movimiento'))
            ->where('estado', true)
            ->groupBy('nombre_cuenta')
            ->orderByDesc('total_movimiento')
            ->limit(5)
            ->get();

        return [
            'datasets' => [
                [
                    'label' => 'Total Movido (Debe + Haber)',
                    'data' => $data->pluck('total_movimiento')->toArray(),
                    'backgroundColor' => [
                        'rgba(54, 162, 235, 0.5)',
                        'rgba(255, 99, 132, 0.5)',
                        'rgba(255, 206, 86, 0.5)',
                        'rgba(75, 192, 192, 0.5)',
                        'rgba(153, 102, 255, 0.5)',
                    ],
                    'borderColor' => [
                        'rgb(54, 162, 235)',
                        'rgb(255, 99, 132)',
                        'rgb(255, 206, 86)',
                        'rgb(75, 192, 192)',
                        'rgb(153, 102, 255)',
                    ],
                    'borderWidth' => 1,
                ],
            ],
            'labels' => $data->pluck('nombre_cuenta')->toArray(),
        ];
    }

    protected function getType(): string
    {
        return 'bar';
    }
}
