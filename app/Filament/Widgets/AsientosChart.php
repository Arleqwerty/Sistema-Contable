<?php

namespace App\Filament\Widgets;

use Filament\Widgets\ChartWidget;

class AsientosChart extends ChartWidget
{
    protected ?string $heading = 'Asientos Chart';

    protected function getData(): array
    {
        $data = \App\Models\LibroDiario::selectRaw('DATE(fecha) as date, count(distinct numero_asiento) as count')
            ->groupBy('date')
            ->orderBy('date')
            ->limit(7)
            ->pluck('count', 'date')
            ->toArray();

        return [
            'datasets' => [
                [
                    'label' => 'Asientos por día',
                    'data' => array_values($data),
                ],
            ],
            'labels' => array_keys($data),
        ];
    }

    protected function getType(): string
    {
        return 'line';
    }
}
