class Proveedor {
  final String nombreProveedor;
  final String nit;
  final String telefono;

  Proveedor({
    required this.nombreProveedor,
    required this.nit,
    required this.telefono,
  });

  factory Proveedor.fromJson(Map<String, dynamic> json) {
    return Proveedor(
      nombreProveedor: json['nombre_proveedor'],
      nit: json['nit'],
      telefono: json['telefono'],
    );
  }
}
