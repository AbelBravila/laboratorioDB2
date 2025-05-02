class Producto {
  final String nombre_producto;
  final int cantidad;
  final double precioVenta;
  final double precioCompra;

  Producto({
    required this.nombre_producto,
    required this.cantidad,
    required this.precioVenta,
    required this.precioCompra,
  });

  factory Producto.fromJson(Map<String, dynamic> json) {
    return Producto(
      nombre_producto: json['nombre_producto'],
      cantidad: json['cantidad'],
      precioVenta: json['precio_venta'].toDouble(),
      precioCompra: json['precio_compra'].toDouble(),
    );
  }
}
