class Cliente {
  final String nombreCliente;
  final String nit;
  final String telefono;

  Cliente({
    required this.nombreCliente,
    required this.nit,
    required this.telefono,
  });

  factory Cliente.fromJson(Map<String, dynamic> json) {
    return Cliente(
      nombreCliente: json['nombre_cliente'],
      nit: json['nit'],
      telefono: json['telefono'],
    );
  }
}
