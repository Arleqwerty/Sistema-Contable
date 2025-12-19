@extends('adminlte::page')

@section('title', 'Dashboard - Sistema Contable')

@section('content_header')
    <h1>Panel de Control - Sistema Contable</h1>
@stop

@section('content')
    <!-- Estadísticas del sistema contable -->
    <div class="row">
        <div class="col-lg-3 col-6">
            <div class="small-box bg-info">
                <div class="inner">
                    <h3>{{ $totalAsientos }}</h3>
                    <p>Asientos Contables</p>
                </div>
                <div class="icon">
                    <i class="fas fa-file-invoice-dollar"></i>
                </div>
                <a href="{{ route('libro-diario.index') }}" class="small-box-footer">Ver detalles <i class="fas fa-arrow-circle-right"></i></a>
            </div>
        </div>
        
        <div class="col-lg-3 col-6">
            <div class="small-box bg-success">
                <div class="inner">
                    <h3>{{ $totalPartidas }}</h3>
                    <p>Total Partidas</p>
                </div>
                <div class="icon">
                    <i class="fas fa-chart-line"></i>
                </div>
                <a href="{{ route('libro-diario.index') }}" class="small-box-footer">Más info <i class="fas fa-arrow-circle-right"></i></a>
            </div>
        </div>
        
        <div class="col-lg-3 col-6">
            <div class="small-box bg-warning">
                <div class="inner">
                    <h3>Bs. {{ number_format($totalMovimientos, 2) }}</h3>
                    <p>Total Movimientos</p>
                </div>
                <div class="icon">
                    <i class="fas fa-balance-scale"></i>
                </div>
                <a href="{{ route('libro-diario.index') }}" class="small-box-footer">Ver detalle <i class="fas fa-arrow-circle-right"></i></a>
            </div>
        </div>
        
        <div class="col-lg-3 col-6">
            <div class="small-box bg-danger">
                <div class="inner">
                    <h3>{{ Auth::user()->created_at->format('d/m/Y') }}</h3>
                    <p>Usuario Activo</p>
                </div>
                <div class="icon">
                    <i class="fas fa-user-check"></i>
                </div>
                <a href="#" class="small-box-footer">Perfil <i class="fas fa-arrow-circle-right"></i></a>
            </div>
        </div>
    </div>

    <!-- Información rápida -->
    <div class="row">
        <div class="col-md-6">
            <div class="card">
                <div class="card-header">
                    <h3 class="card-title">Acciones Rápidas</h3>
                </div>
                <div class="card-body">
                    <div class="row">
                        <div class="col-12 mb-2">
                            <a href="{{ route('libro-diario.create') }}" class="btn btn-primary btn-block">
                                <i class="fas fa-plus-circle"></i> Nuevo Asiento Contable
                            </a>
                        </div>
                        <div class="col-12 mb-2">
                            <a href="{{ route('libro-diario.index') }}" class="btn btn-success btn-block">
                                <i class="fas fa-book"></i> Ver Libro Diario
                            </a>
                        </div>

                    </div>
                </div>
            </div>
        </div>

        <div class="col-md-6">
            <div class="card">
                <div class="card-header">
                    <h3 class="card-title">Resumen Contable</h3>
                </div>
                <div class="card-body">
                    <p><strong>Asientos registrados:</strong> {{ $totalAsientos }}</p>
                    <p><strong>Partidas contables:</strong> {{ $totalPartidas }}</p>
                    <p><strong>Total Debe:</strong> Bs. {{ number_format($totalDebe, 2) }}</p>
                    <p><strong>Total Haber:</strong> Bs. {{ number_format($totalHaber, 2) }}</p>
                    <p><strong>Usuario:</strong> {{ Auth::user()->name }}</p>
                    <p><strong>Fecha:</strong> {{ now()->format('d/m/Y H:i') }}</p>
                </div>
            </div>
        </div>
    </div>

    <!-- Últimos asientos -->
    <div class="row mt-4">
        <div class="col-12">
            <div class="card">
                <div class="card-header">
                    <h3 class="card-title">Últimos Asientos Registrados</h3>
                </div>
                <div class="card-body">
                    @if($ultimosAsientos->count() > 0)
                        <div class="table-responsive">
                            <table class="table table-bordered table-hover">
                                <thead>
                                    <tr>
                                        <th>N° Asiento</th>
                                        <th>Fecha</th>
                                        <th>Descripción</th>
                                        <th>Partidas</th>
                                        <th>Total</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    @foreach($ultimosAsientos as $asiento)
                                    <tr>
                                        <td>{{ $asiento->numero_asiento }}</td>
                                        <td>{{ $asiento->fecha->format('d/m/Y') }}</td>
                                        <td>{{ Str::limit($asiento->descripcion, 50) }}</td>
                                        <td>{{ $asiento->total_partidas }}</td>
                                        <td>Bs. {{ number_format($asiento->total_debe, 2) }}</td>
                                    </tr>
                                    @endforeach
                                </tbody>
                            </table>
                        </div>
                    @else
                        <p class="text-muted text-center">No hay asientos contables registrados aún.</p>
                    @endif
                </div>
            </div>
        </div>
    </div>
    <!-- Gráfico de Balance Diario -->
    <div class="row mt-4">
        <div class="col-12">
            <div class="card card-primary">
                <div class="card-header">
                    <h3 class="card-title">Movimiento Financiero (Últimos 7 días)</h3>
                </div>
                <div class="card-body">
                    <canvas id="balanceChart" style="min-height: 250px; height: 250px; max-height: 250px; max-width: 100%;"></canvas>
                </div>
            </div>
        </div>
    </div>
@stop

@section('js')
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script>
        document.addEventListener('DOMContentLoaded', function () {
            var ctx = document.getElementById('balanceChart').getContext('2d');
            var chart = new Chart(ctx, {
                type: 'line',
                data: {
                    labels: {!! json_encode($chartLabels) !!},
                    datasets: [{
                        label: 'Total Movido (Bs)',
                        backgroundColor: 'rgba(60,141,188,0.9)',
                        borderColor: 'rgba(60,141,188,0.8)',
                        pointRadius: false,
                        pointColor: '#3b8bba',
                        pointStrokeColor: 'rgba(60,141,188,1)',
                        pointHighlightFill: '#fff',
                        pointHighlightStroke: 'rgba(60,141,188,1)',
                        data: {!! json_encode($chartData) !!}
                    }]
                },
                options: {
                    maintainAspectRatio: false,
                    responsive: true,
                    legend: {
                        display: true
                    },
                    scales: {
                        xAxes: [{
                            gridLines: {
                                display: false,
                            }
                        }],
                        yAxes: [{
                            gridLines: {
                                display: false,
                            }
                        }]
                    }
                }
            });
        });
    </script>
@stop