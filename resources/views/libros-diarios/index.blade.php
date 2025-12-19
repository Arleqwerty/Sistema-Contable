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
                <button type="button" class="btn btn-danger mr-2" data-toggle="modal" data-target="#modalPDF">
                    <i class="fas fa-file-pdf"></i> Exportar PDF
                </button>
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

    <!-- Modal Exportar PDF -->
    <div class="modal fade" id="modalPDF" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header bg-danger">
                    <h5 class="modal-title w-100 text-center">Exportar Reporte PDF</h5>
                    <button type="button" class="close" data-dismiss="modal">
                        <span>&times;</span>
                    </button>
                </div>
                <form action="{{ route('libro-diario.pdf') }}" method="GET" target="_blank">
                    <div class="modal-body">
                        <div class="form-group">
                            <label>Seleccione el Rango de Tiempo:</label>
                            <select class="form-control" id="rango_tiempo" name="rango">
                                <option value="dia">Día (Hoy)</option>
                                <option value="semana">Semana (Actual)</option>
                                <option value="mes" selected>Mes (Actual)</option>
                                <option value="anual">Anual (Actual)</option>
                                <option value="personalizado">Personalizado</option>
                            </select>
                        </div>
                        
                        <div class="row" id="fechas_container" style="display: none;">
                            <div class="col-6">
                                <div class="form-group">
                                    <label>Fecha Inicio</label>
                                    <input type="date" class="form-control" name="fecha_inicio" id="fecha_inicio">
                                </div>
                            </div>
                            <div class="col-6">
                                <div class="form-group">
                                    <label>Fecha Fin</label>
                                    <input type="date" class="form-control" name="fecha_fin" id="fecha_fin">
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer justify-content-between">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancelar</button>
                        <button type="submit" class="btn btn-danger">
                            <i class="fas fa-download"></i> Generar PDF
                        </button>
                    </div>
                </form>
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
        // Lógica del Modal de PDF
        $('#rango_tiempo').change(function() {
            var rango = $(this).val();
            var hoy = new Date();
            var inicio, fin;

            // Funciones auxiliares para fechas
            var formatDate = function(d) {
                return d.toISOString().split('T')[0];
            };

            if (rango === 'personalizado') {
                $('#fechas_container').show();
                $('#fecha_inicio').prop('required', true);
                $('#fecha_fin').prop('required', true);
            } else {
                $('#fechas_container').hide();
                $('#fecha_inicio').prop('required', false);
                $('#fecha_fin').prop('required', false);

                if (rango === 'dia') {
                    inicio = new Date(); // Hoy
                    fin = new Date();
                } else if (rango === 'semana') {
                    var day = hoy.getDay() || 7; 
                    if(day !== 1) hoy.setHours(-24 * (day - 1));
                    inicio = hoy;
                    fin = new Date(); 
                } else if (rango === 'mes') {
                    inicio = new Date(hoy.getFullYear(), hoy.getMonth(), 1);
                    fin = new Date(hoy.getFullYear(), hoy.getMonth() + 1, 0);
                } else if (rango === 'anual') {
                    inicio = new Date(hoy.getFullYear(), 0, 1);
                    fin = new Date(hoy.getFullYear(), 11, 31);
                }

                if (inicio && fin) {
                    $('#fecha_inicio').val(formatDate(inicio));
                    $('#fecha_fin').val(formatDate(fin));
                }
            }
        });

        $('#rango_tiempo').trigger('change');

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

        // Recargar tabla automáticamente cada 5 segundos
        setInterval(function() {
            table.ajax.reload(null, false);
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