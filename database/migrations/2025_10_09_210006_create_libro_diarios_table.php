<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up()
    {
        Schema::create('libro_diarios', function (Blueprint $table) {
            $table->id();
            $table->date('fecha');
            $table->string('descripcion');
            $table->integer('numero_asiento');
            $table->string('codigo_cuenta', 20);
            $table->string('nombre_cuenta', 100);
            $table->decimal('debe', 15, 2)->default(0);
            $table->decimal('haber', 15, 2)->default(0);
            $table->boolean('estado')->default(true);
            $table->timestamps();

            // Índices
            $table->index(['numero_asiento']);
            $table->index(['fecha']);
            $table->index(['codigo_cuenta']);
        });
    }

    public function down()
    {
        Schema::dropIfExists('libro_diarios');
    }
};