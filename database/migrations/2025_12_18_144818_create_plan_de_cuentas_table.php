<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('plan_de_cuentas', function (Blueprint $table) {
            $table->id();
            $table->string('codigo')->unique();
            $table->string('nombre');
            $table->enum('tipo', ['activo', 'pasivo', 'patrimonio', 'ingreso', 'gasto', 'costo'])->comment('Tipo de cuenta');
            $table->integer('nivel')->default(1);
            $table->foreignId('parent_id')->nullable()->constrained('plan_de_cuentas')->onDelete('set null');
            $table->boolean('es_imputable')->default(true)->comment('Si se pueden registrar asientos en esta cuenta');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('plan_de_cuentas');
    }
};
