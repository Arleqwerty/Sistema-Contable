<?php

namespace App\Filament\Resources\LibroDiarios\Tables;

use Filament\Actions\BulkActionGroup;
use Filament\Actions\DeleteAction;
use Filament\Actions\DeleteBulkAction;
use Filament\Actions\EditAction;
use Filament\Tables\Columns\IconColumn;
use Filament\Tables\Columns\TextColumn;
use Filament\Tables\Table;
use App\Filament\Resources\LibroDiarios\Pages\EditLibroDiario;

class LibroDiariosTable
{
    public static function configure(Table $table): Table
    {
        return $table
            ->defaultGroup('numero_asiento')
            ->groups([
                \Filament\Tables\Grouping\Group::make('numero_asiento')
                    ->label('Asiento N°')
                    ->collapsible(),
            ])
            ->columns([
                TextColumn::make('fecha')
                    ->date()
                    ->sortable(),
                TextColumn::make('descripcion')
                    ->searchable(),
                TextColumn::make('numero_asiento')
                    ->numeric()
                    ->sortable()
                    ->toggleable(isToggledHiddenByDefault: true),
                TextColumn::make('codigo_cuenta')
                    ->searchable(),
                TextColumn::make('nombre_cuenta')
                    ->searchable(),
                TextColumn::make('debe')
                    ->numeric()
                    ->summarize(\Filament\Tables\Columns\Summarizers\Sum::make()->money('BOB')),
                TextColumn::make('haber')
                    ->numeric()
                    ->summarize(\Filament\Tables\Columns\Summarizers\Sum::make()->money('BOB')),
                \Filament\Tables\Columns\ToggleColumn::make('estado')
                    ->label('Visible')
                    ->onColor('success')
                    ->offColor('danger')
                    ->afterStateUpdated(function ($record, $state) {
                        \App\Models\LibroDiario::where('numero_asiento', $record->numero_asiento)
                            ->update(['estado' => $state]);
                    }),
            ])
            ->filters([
                //
            ])
            ->actions([
                EditAction::make(),
                DeleteAction::make(),
            ])
            ->bulkActions([
                BulkActionGroup::make([
                    DeleteBulkAction::make(),
                ]),
            ]);
    }
}
