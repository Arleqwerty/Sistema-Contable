<?php

namespace App\Filament\Widgets;

use Filament\Widgets\StatsOverviewWidget;
use Filament\Widgets\StatsOverviewWidget\Stat;

class StatsOverview extends StatsOverviewWidget
{
    protected function getStats(): array
    {
        return [
            Stat::make('Total Asientos', \App\Models\LibroDiario::distinct('numero_asiento')->count()),
            Stat::make('Total Debe', 'Bs. ' . number_format(\App\Models\LibroDiario::sum('debe'), 2)),
            Stat::make('Total Haber', 'Bs. ' . number_format(\App\Models\LibroDiario::sum('haber'), 2)),
        ];
    }
}
