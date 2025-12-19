<?php

namespace App\Filament\Resources\PlanDeCuentas\Pages;

use App\Filament\Resources\PlanDeCuentas\PlanDeCuentasResource;
use Filament\Actions\CreateAction;
use Filament\Resources\Pages\ListRecords;

class ListPlanDeCuentas extends ListRecords
{
    protected static string $resource = PlanDeCuentasResource::class;

    protected function getHeaderActions(): array
    {
        return [
            CreateAction::make(),
        ];
    }
}
