import 'package:flutter/material.dart';
import 'package:hello_world/data/cliente_service.dart';
import 'package:hello_world/models/producto.dart';

class VwProducto extends StatefulWidget {
  @override
  State<VwProducto> createState() => _ProductosState();
}

class _ProductosState extends State<VwProducto> {
  late Future<List<Producto>> _productos;

  @override
  void initState() {
    super.initState();
    _productos = ProductoService().obtenerProducto();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Productos")),
      backgroundColor: Colors.grey[100],
      body: FutureBuilder<List<Producto>>(
        future: _productos,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("No hay productos"));
          } else {
            final productos = snapshot.data!;
            return ListView.builder(
              itemCount: productos.length,
              itemBuilder: (context, index) {
                final producto = productos[index];
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 4,
                  child: ListTile(
                    contentPadding: EdgeInsets.all(10),
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        producto.url,
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                      ),
                    ),
                    title: Text(
                      producto.nombreProducto,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(producto.descripcionProducto),
                        Text(
                          "Compra: Q${producto.precioCompra}  |  Venta: Q${producto.precioVenta}",
                        ),
                        Text("Cantidad: ${producto.cantidad}"),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
