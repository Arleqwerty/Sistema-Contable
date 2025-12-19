<?php

namespace App\Filament\Resources\LibroDiarios;

use App\Filament\Resources\LibroDiarios\Pages\CreateLibroDiario;
use App\Filament\Resources\LibroDiarios\Pages\EditLibroDiario;
use App\Filament\Resources\LibroDiarios\Pages\ListLibroDiarios;
use App\Filament\Resources\LibroDiarios\Schemas\LibroDiarioForm;
use App\Filament\Resources\LibroDiarios\Tables\LibroDiariosTable;
use App\Models\LibroDiario;
use BackedEnum;
use Filament\Resources\Resource;
use Filament\Schemas\Schema;
use Filament\Support\Icons\Heroicon;
use Filament\Tables\Table;

class LibroDiarioResource extends Resource
{
    protected static ?string $model = LibroDiario::class;

    protected static string|BackedEnum|null $navigationIcon = Heroicon::OutlinedRectangleStack;

    protected static ?string $recordTitleAttribute = 'descripcion';

    public static function form(\Filament\Schemas\Schema $schema): \Filament\Schemas\Schema
    {
        return LibroDiarioForm::configure($schema);
    }

    public static function table(Table $table): Table
    {
        return LibroDiariosTable::configure($table);
    }

    public static function getRelations(): array
    {
        return [
            //
        ];
    }

    public static function getPages(): array
    {
        return [
            'index' => ListLibroDiarios::route('/'),
            'create' => CreateLibroDiario::route('/create'),
            'edit' => EditLibroDiario::route('/{record}/edit'),
        ];
    }
}
