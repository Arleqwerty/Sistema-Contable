<!DOCTYPE html>
<html>
<head>
    <title>Libro Diario</title>
    <style>
        body { font-family: sans-serif; font-size: 12px; }
        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        th, td { border: 1px solid #ddd; padding: 8px; text-align: left; }
        th { background-color: #f2f2f2; }
        .text-right { text-align: right; }
        .header { text-align: center; margin-bottom: 20px; }
    </style>
</head>
<body>
    <div class="header">
        <h2>Libro Diario</h2>
        <p>Fecha de emisión: {{ date('d/m/Y') }}</p>
    </div>

    <table>
        <thead>
            <tr>
                <th>Asiento</th>
                <th>Fecha</th>
                <th>Descripción</th>
                <th>Partidas</th>
                <th class="text-right">Debe</th>
                <th class="text-right">Haber</th>
            </tr>
        </thead>
        <tbody>
            @foreach($asientos as $asiento)
            <tr>
                <td>{{ $asiento->numero_asiento }}</td>
                <td>{{ \Carbon\Carbon::parse($asiento->fecha)->format('d/m/Y') }}</td>
                <td>{{ $asiento->descripcion }}</td>
                <td>{{ $asiento->total_partidas }}</td>
                <td class="text-right">{{ number_format($asiento->total_debe, 2) }}</td>
                <td class="text-right">{{ number_format($asiento->total_haber, 2) }}</td>
            </tr>
            @endforeach
        </tbody>
        <tfoot>
            <tr>
                <td colspan="4" class="text-right"><strong>Totales Generales:</strong></td>
                <td class="text-right"><strong>{{ number_format($asientos->sum('total_debe'), 2) }}</strong></td>
                <td class="text-right"><strong>{{ number_format($asientos->sum('total_haber'), 2) }}</strong></td>
            </tr>
        </tfoot>
    </table>
</body>
</html>
