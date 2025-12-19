<?php

namespace App\Filament\Resources\LibroDiarios\Pages;

use App\Filament\Resources\LibroDiarios\LibroDiarioResource;
use Filament\Actions\CreateAction;
use Filament\Resources\Pages\ListRecords;

class ListLibroDiarios extends ListRecords
{
    protected static string $resource = LibroDiarioResource::class;

    protected function getHeaderActions(): array
    {
        return [
            CreateAction::make(),
        ];
    }
}
