<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up()
    {
        Schema::create('libros_diarios', function (Blueprint $table) {
            $table->id();
            $table->string('asiento'); // Número o código del asiento
            $table->date('fecha');
            $table->enum('definicion', ['Activo', 'Pasivo', 'Patrimonio']);
            $table->string('cuenta');
            $table->decimal('debe', 15, 2)->default(0); // 15 dígitos, 2 decimales
            $table->decimal('haber', 15, 2)->default(0); // 15 dígitos, 2 decimales
            $table->foreignId('user_id')->constrained()->onDelete('cascade');
            $table->timestamps();
            
            // Índices para mejor performance
            $table->index('asiento');
            $table->index('fecha');
            $table->index('definicion');
        });
    }

    public function down()
    {
        Schema::dropIfExists('libros_diarios');
    }
};