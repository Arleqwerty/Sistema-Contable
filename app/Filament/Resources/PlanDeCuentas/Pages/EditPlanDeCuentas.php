<?php

namespace App\Filament\Resources\PlanDeCuentas\Pages;

use App\Filament\Resources\PlanDeCuentas\PlanDeCuentasResource;
use Filament\Actions\DeleteAction;
use Filament\Resources\Pages\EditRecord;

class EditPlanDeCuentas extends EditRecord
{
    protected static string $resource = PlanDeCuentasResource::class;

    protected function getHeaderActions(): array
    {
        return [
            DeleteAction::make(),
        ];
    }
}
