import 'package:flutter/material.dart';
import 'package:hello_world/data/cliente_service.dart';
import 'package:hello_world/models/Cliente.dart';

class clientes extends StatefulWidget {
  @override
  State<clientes> createState() => _ClientesState();
}

class _ClientesState extends State<clientes> {
  late Future<List<Cliente>> _clientes;

  @override
  void initState() {
    super.initState();
    _clientes = ClienteService().obtenerClientes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Clientes")),
      body: FutureBuilder<List<Cliente>>(
        future: _clientes,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("No hay clientes"));
          } else {
            final clientes = snapshot.data!;
            return ListView.builder(
              itemCount: clientes.length,
              itemBuilder: (context, index) {
                final cliente = clientes[index];
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
                      cliente.nombreCliente,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('NIT: ${cliente.nit}'),
                        Text('Teléfono: ${cliente.telefono}'),
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
