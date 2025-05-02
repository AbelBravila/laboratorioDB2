import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AgregarProveedorPage extends StatefulWidget {
  @override
  _AgregarProveedorPageState createState() => _AgregarProveedorPageState();
}

class _AgregarProveedorPageState extends State<AgregarProveedorPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _nitController = TextEditingController();
  final TextEditingController _telefonoController = TextEditingController();

  Future<void> _enviarCliente() async {
    final url = Uri.parse(
      'https://f05f-2800-98-1a08-fc1a-7c4a-74d6-15ed-528e.ngrok-free.app/api/Procedures/proveedores',
    );

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "nombre_proveedor": _nombreController.text,
        "nit": _nitController.text,
        "telefono": _telefonoController.text,
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("✅ Proveedor agregado correctamente")),
      );
      _nombreController.clear();
      _nitController.clear();
      _telefonoController.clear();
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("❌ Error al agregar Proveedor")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text("Agregar Proveedor"),
        backgroundColor: Colors.teal[700],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 5,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Icon(Icons.person_add, size: 80, color: Colors.teal[700]),
                  SizedBox(height: 20),
                  _buildInputField(
                    controller: _nombreController,
                    label: "Nombre del Proveedor",
                    icon: Icons.person,
                  ),
                  SizedBox(height: 15),
                  _buildInputField(
                    controller: _nitController,
                    label: "NIT",
                    icon: Icons.credit_card,
                  ),
                  SizedBox(height: 15),
                  _buildInputField(
                    controller: _telefonoController,
                    label: "Teléfono",
                    icon: Icons.phone,
                  ),
                  SizedBox(height: 25),
                  ElevatedButton.icon(
                    icon: Icon(Icons.save),
                    label: Text("Guardar Proveedor"),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                      backgroundColor: Colors.teal[700],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _enviarCliente();
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
  }) {
    return TextFormField(
      controller: controller,
      validator: (value) => value!.isEmpty ? "Campo obligatorio" : null,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
