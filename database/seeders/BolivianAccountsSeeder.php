<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\PlanDeCuentas;

class BolivianAccountsSeeder extends Seeder
{
    public function run()
    {
        // === ACTIVO ===
        // Recuperar '1.1.1 Disponibilidades' si existe, o buscar '1.1 Activo Corriente'
        $disponible = PlanDeCuentas::where('codigo', '1.1.1')->first();
        if ($disponible) {
            PlanDeCuentas::firstOrCreate(['codigo' => '1.1.1.03'], [
                'nombre' => 'Banco Bisa M.N.',
                'tipo' => 'activo',
                'nivel' => 4,
                'parent_id' => $disponible->id,
                'es_imputable' => true,
            ]);
        }

        // Crear/Recuperar '1.1.2 Exigible'
        $activoCorriente = PlanDeCuentas::where('codigo', '1.1')->first();
        if ($activoCorriente) {
            $exigible = PlanDeCuentas::firstOrCreate(['codigo' => '1.1.2'], [
                'nombre' => 'EXIGIBLE',
                'tipo' => 'activo',
                'nivel' => 3,
                'parent_id' => $activoCorriente->id,
                'es_imputable' => false,
            ]);

            PlanDeCuentas::firstOrCreate(['codigo' => '1.1.2.01'], [
                'nombre' => 'Cuentas por Cobrar Clientes',
                'tipo' => 'activo',
                'nivel' => 4,
                'parent_id' => $exigible->id,
                'es_imputable' => true,
            ]);
            
            PlanDeCuentas::firstOrCreate(['codigo' => '1.1.2.02'], [
                'nombre' => 'Crédito Fiscal IVA',
                'tipo' => 'activo',
                'nivel' => 4,
                'parent_id' => $exigible->id,
                'es_imputable' => true,
            ]);

            PlanDeCuentas::firstOrCreate(['codigo' => '1.1.2.03'], [
                'nombre' => 'Anticipo al personal',
                'tipo' => 'activo',
                'nivel' => 4,
                'parent_id' => $exigible->id,
                'es_imputable' => true,
            ]);
        }
        
        // Activo No Corriente
        $activo = PlanDeCuentas::where('codigo', '1')->first();
        if ($activo) {
             $activoNoCorriente = PlanDeCuentas::firstOrCreate(['codigo' => '1.2'], [
                'nombre' => 'ACTIVO NO CORRIENTE',
                'tipo' => 'activo',
                'nivel' => 2,
                'parent_id' => $activo->id,
                'es_imputable' => false,
            ]);

            $bienesUso = PlanDeCuentas::firstOrCreate(['codigo' => '1.2.1'], [
                'nombre' => 'BIENES DE USO',
                'tipo' => 'activo',
                'nivel' => 3,
                'parent_id' => $activoNoCorriente->id,
                'es_imputable' => false,
            ]);

            PlanDeCuentas::firstOrCreate(['codigo' => '1.2.1.01'], [
                'nombre' => 'Muebles y Enseres',
                'tipo' => 'activo',
                'nivel' => 4,
                'parent_id' => $bienesUso->id,
                'es_imputable' => true,
            ]);
            
             PlanDeCuentas::firstOrCreate(['codigo' => '1.2.1.02'], [
                'nombre' => 'Equipos de Computación',
                'tipo' => 'activo',
                'nivel' => 4,
                'parent_id' => $bienesUso->id,
                'es_imputable' => true,
            ]);
        }


        // === PASIVO ===
        $pasivoCorriente = PlanDeCuentas::where('codigo', '2.1')->first();
        if ($pasivoCorriente) {
            // Obligaciones Fiscales
            $fiscales = PlanDeCuentas::firstOrCreate(['codigo' => '2.1.2'], [
                'nombre' => 'OBLIGACIONES FISCALES',
                'tipo' => 'pasivo',
                'nivel' => 3,
                'parent_id' => $pasivoCorriente->id,
                'es_imputable' => false,
            ]);

            PlanDeCuentas::firstOrCreate(['codigo' => '2.1.2.01'], [
                'nombre' => 'Débito Fiscal IVA',
                'tipo' => 'pasivo',
                'nivel' => 4,
                'parent_id' => $fiscales->id,
                'es_imputable' => true,
            ]);

            PlanDeCuentas::firstOrCreate(['codigo' => '2.1.2.02'], [
                'nombre' => 'Impuesto a las Transacciones (IT) por Pagar',
                'tipo' => 'pasivo',
                'nivel' => 4,
                'parent_id' => $fiscales->id,
                'es_imputable' => true,
            ]);

            PlanDeCuentas::firstOrCreate(['codigo' => '2.1.2.03'], [
                'nombre' => 'IUE por Pagar',
                'tipo' => 'pasivo',
                'nivel' => 4,
                'parent_id' => $fiscales->id,
                'es_imputable' => true,
            ]);
            
            PlanDeCuentas::firstOrCreate(['codigo' => '2.1.2.04'], [
                'nombre' => 'RC-IVA por Pagar',
                'tipo' => 'pasivo',
                'nivel' => 4,
                'parent_id' => $fiscales->id,
                'es_imputable' => true,
            ]);

            // Obligaciones Laborales
            $laborales = PlanDeCuentas::firstOrCreate(['codigo' => '2.1.3'], [
                'nombre' => 'OBLIGACIONES LABORALES',
                'tipo' => 'pasivo',
                'nivel' => 3,
                'parent_id' => $pasivoCorriente->id,
                'es_imputable' => false,
            ]);

             PlanDeCuentas::firstOrCreate(['codigo' => '2.1.3.01'], [
                'nombre' => 'Sueldos y Salarios por Pagar',
                'tipo' => 'pasivo',
                'nivel' => 4,
                'parent_id' => $laborales->id,
                'es_imputable' => true,
            ]);
            
            PlanDeCuentas::firstOrCreate(['codigo' => '2.1.3.02'], [
                'nombre' => 'Aportes Laborales por Pagar (AFP)',
                'tipo' => 'pasivo',
                'nivel' => 4,
                'parent_id' => $laborales->id,
                'es_imputable' => true,
            ]);
            
            PlanDeCuentas::firstOrCreate(['codigo' => '2.1.3.03'], [
                'nombre' => 'Aportes Patronales por Pagar (CNS)',
                'tipo' => 'pasivo',
                'nivel' => 4,
                'parent_id' => $laborales->id,
                'es_imputable' => true,
            ]);
        }

        // === PATRIMONIO ===
        $patrimonio = PlanDeCuentas::where('codigo', '3')->first();
        if ($patrimonio) {
            PlanDeCuentas::firstOrCreate(['codigo' => '3.1.1.02'], [
                'nombre' => 'Ajuste de Capital',
                'tipo' => 'patrimonio',
                'nivel' => 4,
                'parent_id' => $patrimonio->id, // Asumiendo estructura simple
                'es_imputable' => true,
            ]);
             PlanDeCuentas::firstOrCreate(['codigo' => '3.1.1.03'], [
                'nombre' => 'Resultados Acumulados',
                'tipo' => 'patrimonio',
                'nivel' => 4,
                'parent_id' => $patrimonio->id,
                'es_imputable' => true,
            ]);
        }

        // === GASTOS ===
        $gasto = PlanDeCuentas::where('codigo', '5')->first();
        if ($gasto) {
            $gtosOperativos = PlanDeCuentas::firstOrCreate(['codigo' => '5.1'], [
                'nombre' => 'GASTOS DE OPERACIÓN',
                'tipo' => 'gasto',
                'nivel' => 2,
                'parent_id' => $gasto->id,
                'es_imputable' => false,
            ]);

             PlanDeCuentas::firstOrCreate(['codigo' => '5.1.1.02'], [
                'nombre' => 'Impuesto a las Transacciones (IT)',
                'tipo' => 'gasto',
                'nivel' => 4,
                'parent_id' => $gtosOperativos->id,
                'es_imputable' => true,
            ]);
            
            PlanDeCuentas::firstOrCreate(['codigo' => '5.1.1.03'], [
                'nombre' => 'Sueldos y Salarios',
                'tipo' => 'gasto',
                'nivel' => 4,
                'parent_id' => $gtosOperativos->id,
                'es_imputable' => true,
            ]);
            
            PlanDeCuentas::firstOrCreate(['codigo' => '5.1.1.04'], [
                'nombre' => 'Servicios Básicos (Luz, Agua)',
                'tipo' => 'gasto',
                'nivel' => 4,
                'parent_id' => $gtosOperativos->id,
                'es_imputable' => true,
            ]);
            
            PlanDeCuentas::firstOrCreate(['codigo' => '5.1.1.05'], [
                'nombre' => 'Material de Escritorio',
                'tipo' => 'gasto',
                'nivel' => 4,
                'parent_id' => $gtosOperativos->id,
                'es_imputable' => true,
            ]);
        }
    }
}
