<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class PlanDeCuentas extends Model
{
    use HasFactory;

    protected $fillable = [
        'codigo',
        'nombre',
        'tipo',
        'nivel',
        'parent_id',
        'es_imputable'
    ];

    public function parent()
    {
        return $this->belongsTo(PlanDeCuentas::class, 'parent_id');
    }

    public function children()
    {
        return $this->hasMany(PlanDeCuentas::class, 'parent_id');
    }
}
