class CuentaPorPagar {
  final double monto;
  final double saldoPendiente;
  final DateTime fechaUltimoPago;
  final DateTime fechaVencimiento;
  final String nombreProveedor;

  CuentaPorPagar({
    required this.monto,
    required this.saldoPendiente,
    required this.fechaUltimoPago,
    required this.fechaVencimiento,
    required this.nombreProveedor,
  });

  factory CuentaPorPagar.fromJson(Map<String, dynamic> json) {
    return CuentaPorPagar(
      monto: (json['monto']).toDouble(),
      saldoPendiente: (json['saldo_pendiente']).toDouble(),
      fechaUltimoPago: DateTime.parse(json['fecha_ultimo_pago']),
      fechaVencimiento: DateTime.parse(json['fecha_vencimiento']),
      nombreProveedor: json['nombre_proveedor'],
    );
  }
}
