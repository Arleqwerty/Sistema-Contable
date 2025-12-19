@extends('adminlte::page')

@section('title', 'Libro Diario - Sistema Contable')

@section('content_header')
    <h1>Libro Diario</h1>
@stop

@section('content')
    <div class="card">
        <div class="card-header">
            <h3 class="card-title">Listado de Asientos Contables</h3>
            <div class="card-tools">
                <a href="{{ route('libro-diario.pdf') }}" class="btn btn-danger mr-2" target="_blank">
                    <i class="fas fa-file-pdf"></i> Exportar PDF
                </a>
                <a href="{{ route('libro-diario.create') }}" class="btn btn-primary">
                    <i class="fas fa-plus"></i> Nuevo Asiento
                </a>
            </div>
        </div>
        <div class="card-body">
            <div class="table-responsive">
                <table id="libro-diario" class="table table-striped table-bordered table-hover">
                    <thead class="table-dark">
                        <tr>
                            <th>N° Asiento</th>
                            <th>Fecha</th>
                            <th>Descripción</th>
                            <th>Partidas</th>
                            <th>Total Debe</th>
                            <th>Total Haber</th>
                            <th>Acciones</th>
                        </tr>
                    </thead>
                    <tbody>
                        <!-- DataTables llenará esto -->
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <!-- Modal para ver detalle -->
    <div class="modal fade" id="modalDetalle" tabindex="-1">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Detalle del Asiento</h5>
                    <button type="button" class="close" data-dismiss="modal">
                        <span>&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <table class="table table-bordered" id="tablaDetalle">
                        <thead>
                            <tr>
                                <th>Código</th>
                                <th>Cuenta</th>
                                <th>Debe</th>
                                <th>Haber</th>
                            </tr>
                        </thead>
                        <tbody></tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
@stop

@section('css')
    <link rel="stylesheet" href="https://cdn.datatables.net/1.13.6/css/jquery.dataTables.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css">
@stop

@section('js')
    <script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
    <script src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    
    <script>
    $(document).ready(function() {
        // DataTable principal
        var table = $('#libro-diario').DataTable({
            ajax: '{{ route("libro-diario.data") }}',
            columns: [
                { data: 'numero_asiento' },
                { 
                    data: 'fecha',
                    render: function(data) {
                        return new Date(data).toLocaleDateString('es-ES');
                    }
                },
                { data: 'descripcion' },
                { data: 'total_partidas' },
                { 
                    data: 'total_debe',
                    render: function(data) {
                        return 'Bs. ' + parseFloat(data).toFixed(2);
                    }
                },
                { 
                    data: 'total_haber',
                    render: function(data) {
                        return 'Bs. ' + parseFloat(data).toFixed(2);
                    }
                },
                {
                    data: 'numero_asiento',
                    render: function(data) {
                        return `
                            <button class="btn btn-info btn-sm btn-detalle" data-asiento="${data}">
                                <i class="fas fa-eye"></i>
                            </button>
                        `;
                    },
                    orderable: false
                }
            ],
            language: {
                url: "//cdn.datatables.net/plug-ins/1.13.6/i18n/es-ES.json"
            }
        });

        // Recargar tabla automáticamente cada 5 segundos para actualizaciones en tiempo real
        setInterval(function() {
            table.ajax.reload(null, false); // null = callback, false = keep paging
        }, 5000);

        // Ver detalle del asiento
        $(document).on('click', '.btn-detalle', function() {
            var numeroAsiento = $(this).data('asiento');
            
            $.ajax({
                url: '/libro-diario/' + numeroAsiento,
                type: 'GET',
                success: function(response) {
                    var tbody = $('#tablaDetalle tbody');
                    tbody.empty();
                    
                    response.data.forEach(function(partida) {
                        tbody.append(`
                            <tr>
                                <td>${partida.codigo_cuenta}</td>
                                <td>${partida.nombre_cuenta}</td>
                                <td>Bs. ${parseFloat(partida.debe).toFixed(2)}</td>
                                <td>Bs. ${parseFloat(partida.haber).toFixed(2)}</td>
                            </tr>
                        `);
                    });
                    
                    $('#modalDetalle').modal('show');
                }
            });
        });
    });
    </script>
@stop