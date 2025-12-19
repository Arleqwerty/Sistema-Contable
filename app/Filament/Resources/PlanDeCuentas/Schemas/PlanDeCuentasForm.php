<?php

namespace App\Filament\Resources\PlanDeCuentas\Schemas;

use Filament\Forms\Components\TextInput;
use Filament\Forms\Components\Toggle;
use Filament\Schemas\Schema;

class PlanDeCuentasForm
{
    public static function configure(Schema $schema): Schema
    {
        return $schema
            ->components([
                TextInput::make('codigo')
                    ->required(),
                TextInput::make('nombre')
                    ->required(),
                TextInput::make('tipo')
                    ->required(),
                TextInput::make('nivel')
                    ->required()
                    ->numeric()
                    ->default(1),
                TextInput::make('parent_id')
                    ->numeric(),
                Toggle::make('es_imputable')
                    ->required(),
            ]);
    }
}
