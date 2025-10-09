<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class LibroDiario extends Model
{
    use HasFactory;

    protected $table = 'libro_diarios';

    protected $fillable = [
        'fecha',
        'descripcion',
        'numero_asiento',
        'codigo_cuenta',
        'nombre_cuenta', 
        'debe',
        'haber',
        'estado'
    ];

    protected $casts = [
        'fecha' => 'date',
        'debe' => 'decimal:2',
        'haber' => 'decimal:2',
    ];

    // Scope para asientos activos
    public function scopeActivos($query)
    {
        return $query->where('estado', true);
    }

    // Obtener total debe por asiento
    public static function getTotalDebe($numero_asiento)
    {
        return self::where('numero_asiento', $numero_asiento)
                   ->sum('debe');
    }

    // Obtener total haber por asiento  
    public static function getTotalHaber($numero_asiento)
    {
        return self::where('numero_asiento', $numero_asiento)
                   ->sum('haber');
    }
}