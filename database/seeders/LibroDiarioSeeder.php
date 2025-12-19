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
        // Limpiar tabla de asientos antes de empezar (si se ejecuta individualmente)
        // LibroDiario::truncate(); // Comentado, se controlará desde el comando migrate:fresh
        
        $faker = \Faker\Factory::create();
        
        // --- 1. CONFIGURACIÓN DE FECHAS ---
        // Generar datos para los últimos 3 meses para que las gráficas se vean bonitas
        $startDate = Carbon::now()->subMonths(3);
        $endDate = Carbon::now();
        
        // --- 2. RECUPERAR CUENTAS CLAVE (BOLIVIA) ---
        $caja = $this->findAccount('1.1.1.01'); // Caja MN
        $banco = $this->findAccount('1.1.1.02') ?? $this->findAccount('1.1.1.03'); // Banco Nacional o Bisa
        
        $ventaServicios = $this->findAccount('4.1.1.01'); // Ingreso
        $debitoFiscal = $this->findAccount('2.1.2.01'); // Pasivo IVA
        $itGasto = $this->findAccount('5.1.1.02'); // Gasto IT
        $itPorPagar = $this->findAccount('2.1.2.02'); // Pasivo IT
        
        $materialEscritorio = $this->findAccount('5.1.1.05'); // Gasto
        $serviciosBasicos = $this->findAccount('5.1.1.04'); // Gasto
        $creditoFiscal = $this->findAccount('1.1.2.02'); // Activo IVA
        
        $muebles = $this->findAccount('1.2.1.01');
        $equipos = $this->findAccount('1.2.1.02');

        // Validar que existan las cuentas críticas
        if (!$caja || !$ventaServicios || !$debitoFiscal) {
            $this->command->error('Faltan cuentas críticas. Ejecute primero el BolivianAccountsSeeder.');
            return;
        }

        // --- 3. GENERACIÓN DE ASIENTOS ---
        $numeroAsiento = 1;

        // Generar 100 transacciones distribuidas en el tiempo
        for ($i = 0; $i < 100; $i++) {
            $fecha = $startDate->copy()->addDays(rand(0, 90));
            $tipoTransaccion = rand(1, 10); // Probabilidad
            
            // 60% Ventas, 30% Gastos, 10% Activos
            
            if ($tipoTransaccion <= 6) { 
                // === VENTA DE SERVICIOS (Facturada) ===
                // Asiento típico boliviano:
                // DEBE: Caja/Banco (100%)
                // DEBE: IT (3%)
                // HABER: Venta Servicios (87%)
                // HABER: Débito Fiscal IVA (13%)
                // HABER: IT por Pagar (3%)

                $montoTotal = $faker->randomFloat(2, 500, 15000);
                $descripcion = "Por venta de servicios Fact. Nro " . rand(1000, 9999);
                
                $montoIT = round($montoTotal * 0.03, 2);
                $montoIVA = round($montoTotal * 0.13, 2);
                $montoNeto = $montoTotal - $montoIVA; // 87%

                // Partidas
                $this->crearPartida($fecha, $numeroAsiento, $descripcion, $caja, $montoTotal, 0); // Caja
                $this->crearPartida($fecha, $numeroAsiento, $descripcion, $itGasto, $montoIT, 0); // Gasto IT
                
                $this->crearPartida($fecha, $numeroAsiento, $descripcion, $ventaServicios, 0, $montoNeto); // Ingreso Neto
                $this->crearPartida($fecha, $numeroAsiento, $descripcion, $debitoFiscal, 0, $montoIVA); // Pasivo IVA
                $this->crearPartida($fecha, $numeroAsiento, $descripcion, $itPorPagar, 0, $montoIT); // Pasivo IT

            } elseif ($tipoTransaccion <= 9) {
                // === GASTOS DE OPERACIÓN (Compras Facturadas) ===
                // DEBE: Gasto (87%)
                // DEBE: Crédito Fiscal IVA (13%)
                // HABER: Caja (100%)

                $montoTotal = $faker->randomFloat(2, 50, 2000);
                $cuentaGasto = (rand(0, 1) == 0) ? $materialEscritorio : $serviciosBasicos;
                $descGasto = ($cuentaGasto->id == $materialEscritorio->id) ? "Compra material escritorio" : "Pago luz y agua";
                $descripcion = $descGasto . " Fact. " . rand(100, 500);

                $montoIVA = round($montoTotal * 0.13, 2);
                $montoNeto = $montoTotal - $montoIVA;

                $this->crearPartida($fecha, $numeroAsiento, $descripcion, $cuentaGasto, $montoNeto, 0);
                $this->crearPartida($fecha, $numeroAsiento, $descripcion, $creditoFiscal, $montoIVA, 0);
                $this->crearPartida($fecha, $numeroAsiento, $descripcion, $caja, 0, $montoTotal);

            } else {
                // === COMPRA DE ACTIVO FIJO ===
                $montoTotal = $faker->randomFloat(2, 2000, 10000);
                $cuentaActivo = (rand(0, 1) == 0) ? $muebles : $equipos;
                $descripcion = "Compra de activo fijo según factura";

                $montoIVA = round($montoTotal * 0.13, 2);
                $montoNeto = $montoTotal - $montoIVA;

                $this->crearPartida($fecha, $numeroAsiento, $descripcion, $cuentaActivo, $montoNeto, 0);
                $this->crearPartida($fecha, $numeroAsiento, $descripcion, $creditoFiscal, $montoIVA, 0);
                $this->crearPartida($fecha, $numeroAsiento, $descripcion, $banco ?? $caja, 0, $montoTotal);
            }

            $numeroAsiento++;
        }
    }

    private function findAccount($codigo)
    {
        return PlanDeCuentas::where('codigo', $codigo)->first();
    }

    private function crearPartida($fecha, $asiento, $desc, $cuenta, $debe, $haber)
    {
        if (!$cuenta) return;

        LibroDiario::create([
            'fecha' => $fecha,
            'numero_asiento' => $asiento,
            'descripcion' => $desc,
            'codigo_cuenta' => $cuenta->codigo,
            'nombre_cuenta' => $cuenta->nombre,
            'debe' => $debe,
            'haber' => $haber,
            'estado' => true,
        ]);
    }
}
