<?php

namespace App\Filament\Resources\PlanDeCuentas;

use App\Filament\Resources\PlanDeCuentas\Pages\CreatePlanDeCuentas;
use App\Filament\Resources\PlanDeCuentas\Pages\EditPlanDeCuentas;
use App\Filament\Resources\PlanDeCuentas\Pages\ListPlanDeCuentas;
use App\Filament\Resources\PlanDeCuentas\Schemas\PlanDeCuentasForm;
use App\Filament\Resources\PlanDeCuentas\Tables\PlanDeCuentasTable;
use App\Models\PlanDeCuentas;
use BackedEnum;
use Filament\Resources\Resource;
use Filament\Schemas\Schema;
use Filament\Support\Icons\Heroicon;
use Filament\Tables\Table;

class PlanDeCuentasResource extends Resource
{
    protected static ?string $model = PlanDeCuentas::class;

    protected static string|BackedEnum|null $navigationIcon = Heroicon::OutlinedRectangleStack;

    protected static ?string $recordTitleAttribute = 'nombre';

    public static function form(Schema $schema): Schema
    {
        return PlanDeCuentasForm::configure($schema);
    }

    public static function table(Table $table): Table
    {
        return PlanDeCuentasTable::configure($table);
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
            'index' => ListPlanDeCuentas::route('/'),
            'create' => CreatePlanDeCuentas::route('/create'),
            'edit' => EditPlanDeCuentas::route('/{record}/edit'),
        ];
    }
}
