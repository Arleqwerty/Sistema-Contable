<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use App\Models\LibroDiario;
use App\Models\PlanDeCuentas;
use Carbon\Carbon;

class LibroDiarioSeeder extends Seeder
{
    public function run(): void
    {
        $faker = \Faker\Factory::create();
        
        // Obtener cuentas imputables
        $cuentas = PlanDeCuentas::where('es_imputable', true)->get();

        if ($cuentas->count() < 2) {
            $this->command->info('No hay suficientes cuentas imputables para crear asientos.');
            return;
        }

        // Crear 50 asientos ficticios
        $ultimoAsiento = LibroDiario::max('numero_asiento') ?? 0;

        for ($i = 1; $i <= 50; $i++) {
            $numeroAsiento = $ultimoAsiento + $i;
            $fecha = Carbon::now()->subDays(rand(0, 30)); // Fechas de este mes
            $monto = $faker->randomFloat(2, 100, 5000);
            
            // Seleccionar 2 cuentas al azar para Partida Doble
            $cuentaDebe = $cuentas->random();
            $cuentaHaber = $cuentas->where('id', '!=', $cuentaDebe->id)->random();

            $descripcion = $faker->sentence(4);

            // Partida al Debe
            LibroDiario::create([
                'fecha' => $fecha,
                'descripcion' => $descripcion,
                'numero_asiento' => $numeroAsiento,
                'codigo_cuenta' => $cuentaDebe->codigo,
                'nombre_cuenta' => $cuentaDebe->nombre,
                'debe' => $monto,
                'haber' => 0,
                'estado' => true,
            ]);

            // Partida al Haber
            LibroDiario::create([
                'fecha' => $fecha,
                'descripcion' => $descripcion,
                'numero_asiento' => $numeroAsiento,
                'codigo_cuenta' => $cuentaHaber->codigo,
                'nombre_cuenta' => $cuentaHaber->nombre,
                'debe' => 0,
                'haber' => $monto,
                'estado' => true,
            ]);
        }
    }
}
