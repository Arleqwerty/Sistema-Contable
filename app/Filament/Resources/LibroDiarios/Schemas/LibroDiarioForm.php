<?php

namespace App\Filament\Resources\LibroDiarios\Schemas;

use Filament\Forms\Components\DatePicker;
use Filament\Forms\Components\TextInput;
use Filament\Forms\Components\Toggle;
use Filament\Schemas\Schema;

class LibroDiarioForm
{
    public static function configure(Schema $schema): Schema
    {
        return $schema
            ->components([
                DatePicker::make('fecha')
                    ->required(),
                TextInput::make('descripcion')
                    ->required(),
                TextInput::make('numero_asiento')
                    ->required()
                    ->numeric(),
                TextInput::make('codigo_cuenta')
                    ->required(),
                TextInput::make('nombre_cuenta')
                    ->required(),
                TextInput::make('debe')
                    ->required()
                    ->numeric()
                    ->default(0),
                TextInput::make('haber')
                    ->required()
                    ->numeric()
                    ->default(0),
                Toggle::make('estado')
                    ->required(),
            ]);
    }
}
