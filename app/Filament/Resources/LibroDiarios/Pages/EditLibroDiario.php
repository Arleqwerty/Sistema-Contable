<?php

namespace App\Filament\Resources\LibroDiarios\Pages;

use App\Filament\Resources\LibroDiarios\LibroDiarioResource;
use Filament\Actions\DeleteAction;
use Filament\Resources\Pages\EditRecord;

class EditLibroDiario extends EditRecord
{
    protected static string $resource = LibroDiarioResource::class;

    protected function getHeaderActions(): array
    {
        return [
            DeleteAction::make(),
        ];
    }
}
