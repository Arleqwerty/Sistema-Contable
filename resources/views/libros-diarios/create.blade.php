@extends('adminlte::page')

@section('title', 'Nuevo Asiento - Sistema Contable')

@section('content_header')
    <h1>Nuevo Asiento Contable</h1>
@stop

@section('content')
    <div class="card">
        <div class="card-header">
            <h3 class="card-title">Registrar Asiento en Libro Diario</h3>
        </div>
        <form id="form-asiento">
            @csrf
            <div class="card-body">
                <!-- Datos generales -->
                <div class="row">
                    <div class="col-md-3">
                        <div class="form-group">
                            <label for="fecha">Fecha *</label>
                            <input type="date" class="form-control" id="fecha" name="fecha" 
                                   value="{{ date('Y-m-d') }}" required>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="form-group">
                            <label for="numero_asiento">N° Asiento</label>
                            <input type="text" class="form-control" value="{{ $proximoAsiento }}" readonly>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <label for="descripcion">Descripción *</label>
                            <input type="text" class="form-control" id="descripcion" name="descripcion" 
                                   placeholder="Descripción del asiento contable" required>
                        </div>
                    </div>
                </div>

                <!-- Partidas contables -->
                <div class="row">
                    <div class="col-12">
                        <h5>Partidas Contables</h5>
                        <div class="table-responsive">
                            <table class="table table-bordered" id="tabla-partidas">
                                <thead class="table-dark">
                                    <tr>
                                        <th width="15%">Código Cuenta *</th>
                                        <th width="35%">Nombre Cuenta *</th>
                                        <th width="20%">Debe (Bs.) *</th>
                                        <th width="20%">Haber (Bs.) *</th>
                                        <th width="10%">Acciones</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <!-- Partidas se agregarán aquí dinámicamente -->
                                </tbody>
                                <tfoot>
                                    <tr>
                                        <td colspan="2" class="text-right"><strong>Totales:</strong></td>
                                        <td><strong id="total-debe">Bs. 0.00</strong></td>
                                        <td><strong id="total-haber">Bs. 0.00</strong></td>
                                        <td></td>
                                    </tr>
                                    <tr id="fila-balance" style="display: none;">
                                        <td colspan="2" class="text-right"><strong>Diferencia:</strong></td>
                                        <td colspan="3" class="text-center">
                                            <strong id="diferencia" class="text-danger">Bs. 0.00</strong>
                                        </td>
                                    </tr>
                                </tfoot>
                            </table>
                        </div>
                        <button type="button" class="btn btn-success btn-sm" id="btn-agregar-partida">
                            <i class="fas fa-plus"></i> Agregar Partida
                        </button>
                    </div>
                </div>
            </div>
            <div class="card-footer">
                <button type="submit" class="btn btn-primary">
                    <i class="fas fa-save"></i> Guardar Asiento
                </button>
                <a href="{{ route('libro-diario.index') }}" class="btn btn-secondary">
                    <i class="fas fa-arrow-left"></i> Volver
                </a>
            </div>
        </form>
    </div>
@stop

@section('css')
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css">
@stop

@section('js')
    <script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    
    <script>
    $(document).ready(function() {
        let contadorPartidas = 0;

        // Agregar partida inicial (2 partidas mínimo)
        agregarPartida();
        agregarPartida();

        // Función para agregar partida
        function agregarPartida() {
            contadorPartidas++;
            const nuevaFila = `
                <tr id="partida-${contadorPartidas}">
                    <td>
                        <input type="text" class="form-control" name="partidas[${contadorPartidas}][codigo_cuenta]" 
                               placeholder="Ej: 1101" required>
                    </td>
                    <td>
                        <input type="text" class="form-control" name="partidas[${contadorPartidas}][nombre_cuenta]" 
                               placeholder="Ej: Caja" required>
                    </td>
                    <td>
                        <input type="number" class="form-control debe" name="partidas[${contadorPartidas}][debe]" 
                               step="0.01" min="0" value="0" required>
                    </td>
                    <td>
                        <input type="number" class="form-control haber" name="partidas[${contadorPartidas}][haber]" 
                               step="0.01" min="0" value="0" required>
                    </td>
                    <td>
                        ${contadorPartidas > 2 ? 
                            `<button type="button" class="btn btn-danger btn-sm btn-eliminar" data-id="${contadorPartidas}">
                                <i class="fas fa-trash"></i>
                            </button>` : 
                            '<span class="text-muted">Mínimo</span>'
                        }
                    </td>
                </tr>
            `;
            $('#tabla-partidas tbody').append(nuevaFila);
            actualizarTotales();
        }

        // Eliminar partida
        $(document).on('click', '.btn-eliminar', function() {
            const id = $(this).data('id');
            $(`#partida-${id}`).remove();
            actualizarTotales();
        });

        // Actualizar totales
        function actualizarTotales() {
            let totalDebe = 0;
            let totalHaber = 0;

            $('.debe').each(function() {
                totalDebe += parseFloat($(this).val()) || 0;
            });

            $('.haber').each(function() {
                totalHaber += parseFloat($(this).val()) || 0;
            });

            $('#total-debe').text('Bs. ' + totalDebe.toFixed(2));
            $('#total-haber').text('Bs. ' + totalHaber.toFixed(2));

            // Mostrar diferencia si no coinciden
            const diferencia = Math.abs(totalDebe - totalHaber);
            if (diferencia > 0.01) {
                $('#fila-balance').show();
                $('#diferencia').text('Bs. ' + diferencia.toFixed(2));
            } else {
                $('#fila-balance').hide();
            }
        }

        // Eventos para actualizar totales
        $(document).on('input', '.debe, .haber', actualizarTotales);

        // Agregar nueva partida
        $('#btn-agregar-partida').click(agregarPartida);

        // Enviar formulario
        $('#form-asiento').submit(function(e) {
            e.preventDefault();

            // Validar mínimo 2 partidas
            if (contadorPartidas < 2) {
                Swal.fire('Error', 'Debe haber al menos 2 partidas contables', 'error');
                return;
            }

            const formData = new FormData(this);

            Swal.fire({
                title: '¿Guardar asiento?',
                text: "¿Está seguro de guardar este asiento contable?",
                icon: 'question',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: 'Sí, guardar',
                cancelButtonText: 'Cancelar'
            }).then((result) => {
                if (result.isConfirmed) {
                    $.ajax({
                        url: '{{ route("libro-diario.store") }}',
                        type: 'POST',
                        data: formData,
                        processData: false,
                        contentType: false,
                        success: function(response) {
                            if (response.success) {
                                Swal.fire({
                                    icon: 'success',
                                    title: '¡Éxito!',
                                    text: response.message,
                                    confirmButtonText: 'Aceptar'
                                }).then(() => {
                                    window.location.href = '{{ route("libro-diario.index") }}';
                                });
                            } else {
                                Swal.fire('Error', response.message, 'error');
                            }
                        },
                        error: function(xhr) {
                            const error = xhr.responseJSON;
                            Swal.fire('Error', error?.message || 'Error al guardar el asiento', 'error');
                        }
                    });
                }
            });
        });
    });
    </script>
@stop