@extends('adminlte::page')

@section('title', 'Nueva Cuenta')

@section('content_header')
    <h1>Nueva Cuenta Contable</h1>
@stop

@section('content')
<div class="card card-primary">
    <div class="card-header">
        <h3 class="card-title">Registrar Cuenta</h3>
    </div>
    <form action="{{ route('plan-de-cuentas.store') }}" method="POST">
        @csrf
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
                <input type="text" class="form-control" id="codigo" name="codigo" placeholder="Ej: 1.1.01" value="{{ old('codigo') }}" required>
            </div>
            <div class="form-group">
                <label for="nombre">Nombre de la Cuenta</label>
                <input type="text" class="form-control" id="nombre" name="nombre" placeholder="Ej: Caja Moneda Nacional" value="{{ old('nombre') }}" required>
            </div>
            <div class="form-group">
                <label for="tipo">Tipo de Cuenta</label>
                <select class="form-control" id="tipo" name="tipo" required>
                    <option value="">Seleccione...</option>
                    <option value="activo" {{ old('tipo') == 'activo' ? 'selected' : '' }}>Activo</option>
                    <option value="pasivo" {{ old('tipo') == 'pasivo' ? 'selected' : '' }}>Pasivo</option>
                    <option value="patrimonio" {{ old('tipo') == 'patrimonio' ? 'selected' : '' }}>Patrimonio</option>
                    <option value="ingreso" {{ old('tipo') == 'ingreso' ? 'selected' : '' }}>Ingreso</option>
                    <option value="gasto" {{ old('tipo') == 'gasto' ? 'selected' : '' }}>Gasto</option>
                    <option value="costo" {{ old('tipo') == 'costo' ? 'selected' : '' }}>Costo</option>
                </select>
            </div>
            <div class="form-group">
                <label for="parent_id">Cuenta Padre (Opcional)</label>
                <select class="form-control select2" id="parent_id" name="parent_id">
                    <option value="">Ninguna (Cuenta Principal)</option>
                    @foreach($cuentasPadre as $padre)
                        <option value="{{ $padre->id }}" {{ old('parent_id') == $padre->id ? 'selected' : '' }}>
                            {{ $padre->codigo }} - {{ $padre->nombre }}
                        </option>
                    @endforeach
                </select>
            </div>
            <div class="form-check">
                <input type="checkbox" class="form-check-input" id="es_imputable" name="es_imputable" value="1" {{ old('es_imputable', 1) ? 'checked' : '' }}>
                <label class="form-check-label" for="es_imputable">Es Imputable (Se pueden registrar asientos)</label>
            </div>
        </div>
        <div class="card-footer">
            <button type="submit" class="btn btn-primary">Guardar</button>
            <a href="{{ route('plan-de-cuentas.index') }}" class="btn btn-secondary">Cancelar</a>
        </div>
    </form>
</div>
@stop

@section('js')
    <script>
        $(document).ready(function() {
            // Initialize Select2 if available
            //$('.select2').select2();
        });
    </script>
@stop
