import 'package:flutter/material.dart';
import 'package:hello_world/data/cliente_service.dart';
import 'package:hello_world/models/Proveedor.dart';

class VwProveedores extends StatefulWidget {
  const VwProveedores({super.key});

  @override
  State<VwProveedores> createState() => _ProveedoresState();
}

class _ProveedoresState extends State<VwProveedores> {
  late Future<List<Proveedor>> _proveedores;

  @override
  void initState() {
    super.initState();
    _proveedores = ProveedorService().obtenerProveedores();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Proveedores")),
      body: FutureBuilder<List<Proveedor>>(
        future: _proveedores,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("No hay proveedores"));
          } else {
            final proveedores = snapshot.data!;
            return ListView.builder(
              itemCount: proveedores.length,
              itemBuilder: (context, index) {
                final Proveedor = proveedores[index];
                return Card(
                  color: Colors.grey[200],
                  elevation: 3,
                  margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.blueAccent,
                      child: Icon(Icons.person, color: Colors.white),
                    ),
                    title: Text(
                      Proveedor.nombreProveedor,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('NIT: ${Proveedor.nit}'),
                        Text('Teléfono: ${Proveedor.telefono}'),
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
