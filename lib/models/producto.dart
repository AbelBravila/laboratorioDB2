class Producto {
  final String nombreProducto;
  final String descripcionProducto;
  final double precioCompra;
  final double precioVenta;
  final int cantidad;
  final String url;

  Producto({
    required this.nombreProducto,
    required this.descripcionProducto,
    required this.precioCompra,
    required this.precioVenta,
    required this.cantidad,
    required this.url,
  });

  factory Producto.fromJson(Map<String, dynamic> json) {
    return Producto(
      nombreProducto: json['nombre_producto'],
      descripcionProducto: json['descripcion_producto'],
      precioCompra: json['precio_compra'].toDouble(),
      precioVenta: json['precio_venta'].toDouble(),
      cantidad: json['cantidad'],
      url: json['url'],
    );
  }
}
