<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\PlanDeCuentas;

class PlanDeCuentasSeeder extends Seeder
{
    public function run()
    {
        // 1. Activo
        $activo = PlanDeCuentas::create([
            'codigo' => '1',
            'nombre' => 'ACTIVO',
            'tipo' => 'activo',
            'nivel' => 1,
            'es_imputable' => false,
        ]);

        // 1.1 Activo Corriente
        $activoCorriente = PlanDeCuentas::create([
            'codigo' => '1.1',
            'nombre' => 'ACTIVO CORRIENTE',
            'tipo' => 'activo',
            'nivel' => 2,
            'parent_id' => $activo->id,
            'es_imputable' => false,
        ]);

        // 1.1.1 Disponibilidades
        $disponible = PlanDeCuentas::create([
            'codigo' => '1.1.1',
            'nombre' => 'DISPONIBILIDADES',
            'tipo' => 'activo',
            'nivel' => 3,
            'parent_id' => $activoCorriente->id,
            'es_imputable' => false,
        ]);

        PlanDeCuentas::create([
            'codigo' => '1.1.1.01',
            'nombre' => 'Caja Moneda Nacional',
            'tipo' => 'activo',
            'nivel' => 4,
            'parent_id' => $disponible->id,
            'es_imputable' => true,
        ]);

        PlanDeCuentas::create([
            'codigo' => '1.1.1.02',
            'nombre' => 'Banco Moneda Nacional',
            'tipo' => 'activo',
            'nivel' => 4,
            'parent_id' => $disponible->id,
            'es_imputable' => true,
        ]);

         // 2. Pasivo
         $pasivo = PlanDeCuentas::create([
            'codigo' => '2',
            'nombre' => 'PASIVO',
            'tipo' => 'pasivo',
            'nivel' => 1,
            'es_imputable' => false,
        ]);

        $pasivoCorriente = PlanDeCuentas::create([
            'codigo' => '2.1',
            'nombre' => 'PASIVO CORRIENTE',
            'tipo' => 'pasivo',
            'nivel' => 2,
            'parent_id' => $pasivo->id,
            'es_imputable' => false,
        ]);

        PlanDeCuentas::create([
            'codigo' => '2.1.1.01',
            'nombre' => 'Cuentas por Pagar',
            'tipo' => 'pasivo',
            'nivel' => 4,
            'parent_id' => $pasivoCorriente->id,
            'es_imputable' => true,
        ]);

        // 3. Patrimonio
        $patrimonio = PlanDeCuentas::create([
            'codigo' => '3',
            'nombre' => 'PATRIMONIO',
            'tipo' => 'patrimonio',
            'nivel' => 1,
            'es_imputable' => false,
        ]);
        
        PlanDeCuentas::create([
            'codigo' => '3.1.1.01',
            'nombre' => 'Capital Social',
            'tipo' => 'patrimonio',
            'nivel' => 4,
            'parent_id' => $patrimonio->id,
            'es_imputable' => true,
        ]);

         // 4. Ingreso
         $ingreso = PlanDeCuentas::create([
            'codigo' => '4',
            'nombre' => 'INGRESOS',
            'tipo' => 'ingreso',
            'nivel' => 1,
            'es_imputable' => false,
        ]);

        PlanDeCuentas::create([
            'codigo' => '4.1.1.01',
            'nombre' => 'Venta de Servicios',
            'tipo' => 'ingreso',
            'nivel' => 4,
            'parent_id' => $ingreso->id,
            'es_imputable' => true,
        ]);

        // 5. Gasto
        $gasto = PlanDeCuentas::create([
            'codigo' => '5',
            'nombre' => 'GASTOS',
            'tipo' => 'gasto',
            'nivel' => 1,
            'es_imputable' => false,
        ]);

        PlanDeCuentas::create([
            'codigo' => '5.1.1.01',
            'nombre' => 'Gastos Generales',
            'tipo' => 'gasto',
            'nivel' => 4,
            'parent_id' => $gasto->id,
            'es_imputable' => true,
        ]);
    }
}
