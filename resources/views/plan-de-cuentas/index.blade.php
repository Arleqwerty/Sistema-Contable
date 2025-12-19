@extends('adminlte::page')

@section('title', 'Plan de Cuentas')

@section('content_header')
    <h1>Plan de Cuentas</h1>
@stop

@section('content')
<div class="card">
    <div class="card-header">
        <h3 class="card-title">Listado de Cuentas</h3>
        <div class="card-tools">
            <a href="{{ route('plan-de-cuentas.create') }}" class="btn btn-primary btn-sm">
                <i class="fas fa-plus"></i> Nueva Cuenta
            </a>
        </div>
    </div>
    <div class="card-body">
        @if(session('success'))
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                {{ session('success') }}
                <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
        @endif
        @if(session('error'))
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                {{ session('error') }}
                <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
        @endif

        <form action="{{ route('plan-de-cuentas.index') }}" method="GET" class="mb-3">
            <div class="input-group input-group-sm" style="width: 300px;">
                <input type="text" name="search" class="form-control" placeholder="Buscar por código o nombre" value="{{ request('search') }}">
                <div class="input-group-append">
                    <button type="submit" class="btn btn-default">
                        <i class="fas fa-search"></i>
                    </button>
                </div>
            </div>
        </form>

        <table class="table table-bordered table-striped table-hover">
            <thead>
                <tr>
                    <th>Código</th>
                    <th>Nombre</th>
                    <th>Tipo</th>
                    <th>Nivel</th>
                    <th>Padre</th>
                    <th>Acciones</th>
                </tr>
            </thead>
            <tbody>
                @forelse($cuentas as $cuenta)
                <tr>
                    <td>{{ $cuenta->codigo }}</td>
                    <td>{{ $cuenta->nombre }}</td>
                    <td><span class="badge badge-info">{{ ucfirst($cuenta->tipo) }}</span></td>
                    <td>{{ $cuenta->nivel }}</td>
                    <td>{{ $cuenta->parent ? $cuenta->parent->codigo . ' - ' . $cuenta->parent->nombre : '-' }}</td>
                    <td>
                        <a href="{{ route('plan-de-cuentas.edit', $cuenta->id) }}" class="btn btn-warning btn-xs">
                            <i class="fas fa-edit"></i>
                        </a>
                        <form action="{{ route('plan-de-cuentas.destroy', $cuenta->id) }}" method="POST" style="display:inline-block;" onsubmit="return confirm('¿Está seguro de eliminar esta cuenta?');">
                            @csrf
                            @method('DELETE')
                            <button type="submit" class="btn btn-danger btn-xs">
                                <i class="fas fa-trash"></i>
                            </button>
                        </form>
                    </td>
                </tr>
                @empty
                <tr>
                    <td colspan="6" class="text-center">No hay cuentas registradas.</td>
                </tr>
                @endforelse
            </tbody>
        </table>
    </div>
    <div class="card-footer clearfix">
        {{ $cuentas->links('pagination::bootstrap-4') }}
    </div>
</div>
@stop
