@extends('adminlte::page')

@section('title', 'Editar Cuenta')

@section('content_header')
    <h1>Editar Cuenta Contable</h1>
@stop

@section('content')
<div class="card card-warning">
    <div class="card-header">
        <h3 class="card-title">Editar Cuenta: {{ $cuenta->codigo }}</h3>
    </div>
    <form action="{{ route('plan-de-cuentas.update', $cuenta->id) }}" method="POST">
        @csrf
        @method('PUT')
        <div class="card-body">
            @if($errors->any())
                <div class="alert alert-danger">
                    <ul>
                        @foreach($errors->all() as $error)
                            <li>{{ $error }}</li>
                        @endforeach
                    </ul>
                </div>
            @endif

            <div class="form-group">
                <label for="codigo">Código</label>
                <input type="text" class="form-control" id="codigo" name="codigo" value="{{ old('codigo', $cuenta->codigo) }}" required>
            </div>
            <div class="form-group">
                <label for="nombre">Nombre de la Cuenta</label>
                <input type="text" class="form-control" id="nombre" name="nombre" value="{{ old('nombre', $cuenta->nombre) }}" required>
            </div>
            <div class="form-group">
                <label for="tipo">Tipo de Cuenta</label>
                <select class="form-control" id="tipo" name="tipo" required>
                    <option value="activo" {{ old('tipo', $cuenta->tipo) == 'activo' ? 'selected' : '' }}>Activo</option>
                    <option value="pasivo" {{ old('tipo', $cuenta->tipo) == 'pasivo' ? 'selected' : '' }}>Pasivo</option>
                    <option value="patrimonio" {{ old('tipo', $cuenta->tipo) == 'patrimonio' ? 'selected' : '' }}>Patrimonio</option>
                    <option value="ingreso" {{ old('tipo', $cuenta->tipo) == 'ingreso' ? 'selected' : '' }}>Ingreso</option>
                    <option value="gasto" {{ old('tipo', $cuenta->tipo) == 'gasto' ? 'selected' : '' }}>Gasto</option>
                    <option value="costo" {{ old('tipo', $cuenta->tipo) == 'costo' ? 'selected' : '' }}>Costo</option>
                </select>
            </div>
            <div class="form-group">
                <label for="parent_id">Cuenta Padre (Opcional)</label>
                <select class="form-control" id="parent_id" name="parent_id">
                    <option value="">Ninguna (Cuenta Principal)</option>
                    @foreach($cuentasPadre as $padre)
                        <option value="{{ $padre->id }}" {{ old('parent_id', $cuenta->parent_id) == $padre->id ? 'selected' : '' }}>
                            {{ $padre->codigo }} - {{ $padre->nombre }}
                        </option>
                    @endforeach
                </select>
            </div>
            <div class="form-check">
                <input type="checkbox" class="form-check-input" id="es_imputable" name="es_imputable" value="1" {{ old('es_imputable', $cuenta->es_imputable) ? 'checked' : '' }}>
                <label class="form-check-label" for="es_imputable">Es Imputable (Se pueden registrar asientos)</label>
            </div>
        </div>
        <div class="card-footer">
            <button type="submit" class="btn btn-primary">Actualizar</button>
            <a href="{{ route('plan-de-cuentas.index') }}" class="btn btn-secondary">Cancelar</a>
        </div>
    </form>
</div>
@stop
