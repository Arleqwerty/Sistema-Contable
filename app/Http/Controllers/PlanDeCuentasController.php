<?php

namespace App\Http\Controllers;

use App\Models\PlanDeCuentas;
use Illuminate\Http\Request;
use Illuminate\Validation\Rule;

class PlanDeCuentasController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index(Request $request)
    {
        $query = PlanDeCuentas::query();

        if ($request->filled('search')) {
            $search = $request->input('search');
            $query->where('codigo', 'like', "%{$search}%")
                  ->orWhere('nombre', 'like', "%{$search}%");
        }

        $cuentas = $query->orderBy('codigo', 'asc')->paginate(15);

        return view('plan-de-cuentas.index', compact('cuentas'));
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        $cuentasPadre = PlanDeCuentas::where('es_imputable', false)
            ->orderBy('codigo')
            ->get();
            
        return view('plan-de-cuentas.create', compact('cuentasPadre'));
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        $validated = $request->validate([
            'codigo' => 'required|string|unique:plan_de_cuentas,codigo',
            'nombre' => 'required|string|max:255',
            'tipo' => 'required|in:activo,pasivo,patrimonio,ingreso,gasto,costo',
            'level' => 'nullable|integer', // 'nivel' in DB
            'parent_id' => 'nullable|exists:plan_de_cuentas,id',
            'es_imputable' => 'boolean',
        ]);

        // Auto calculate level based on length of code or parent?
        // For simplicity, let's assume level is passed or calculated.
        // If parent exists, level = parent->nivel + 1.
        if (!empty($validated['parent_id'])) {
            $parent = PlanDeCuentas::find($validated['parent_id']);
            $validated['nivel'] = $parent->nivel + 1;
        } else {
            $validated['nivel'] = 1;
        }

        // Check format of Code vs Parent? (Simplified for now)

        PlanDeCuentas::create($validated);

        return redirect()->route('plan-de-cuentas.index')
            ->with('success', 'Cuenta creada exitosamente.');
    }

    /**
     * Display the specified resource.
     */
    public function show(PlanDeCuentas $planDeCuentas)
    {
        return view('plan-de-cuentas.show', compact('planDeCuentas'));
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit($id)
    {
        $cuenta = PlanDeCuentas::findOrFail($id);
        $cuentasPadre = PlanDeCuentas::where('es_imputable', false)
            ->where('id', '!=', $id) // Avoid self-parenting
            ->orderBy('codigo')
            ->get();

        return view('plan-de-cuentas.edit', compact('cuenta', 'cuentasPadre'));
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, $id)
    {
        $cuenta = PlanDeCuentas::findOrFail($id);

        $validated = $request->validate([
            'codigo' => ['required', 'string', Rule::unique('plan_de_cuentas')->ignore($cuenta->id)],
            'nombre' => 'required|string|max:255',
            'tipo' => 'required|in:activo,pasivo,patrimonio,ingreso,gasto,costo',
            'parent_id' => 'nullable|exists:plan_de_cuentas,id',
            'es_imputable' => 'boolean',
        ]);

        if (!empty($validated['parent_id'])) {
            $parent = PlanDeCuentas::find($validated['parent_id']);
            $validated['nivel'] = $parent->nivel + 1;
        } else {
            $validated['nivel'] = 1; // Assuming root
        }
        
        // Handle checkbox boolean
        $validated['es_imputable'] = $request->has('es_imputable');

        $cuenta->update($validated);

        return redirect()->route('plan-de-cuentas.index')
            ->with('success', 'Cuenta actualizada exitosamente.');
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy($id)
    {
        $cuenta = PlanDeCuentas::findOrFail($id);
        
        if ($cuenta->children()->exists()) {
            return back()->with('error', 'No se puede eliminar una cuenta que tiene subcuentas.');
        }

        // Optional: Check if used in LibroDiario entries
        // if ($cuenta->asientos()->exists()) ...

        $cuenta->delete();

        return redirect()->route('plan-de-cuentas.index')
            ->with('success', 'Cuenta eliminada exitosamente.');
    }
}
