class CuentaPorCobrar {
  final double monto;
  final double saldoPendiente;
  final DateTime fechaUltimoPago;
  final DateTime fechaVencimiento;
  final String nombreCliente;

  CuentaPorCobrar({
    required this.monto,
    required this.saldoPendiente,
    required this.fechaUltimoPago,
    required this.fechaVencimiento,
    required this.nombreCliente,
  });

  factory CuentaPorCobrar.fromJson(Map<String, dynamic> json) {
    return CuentaPorCobrar(
      monto: (json['monto']).toDouble(),
      saldoPendiente: (json['saldo_pendiente']).toDouble(),
      fechaUltimoPago: DateTime.parse(json['fecha_ultimo_pago']),
      fechaVencimiento: DateTime.parse(json['fecha_vencimiento']),
      nombreCliente: json['nombre_cliente'],
    );
  }
}
