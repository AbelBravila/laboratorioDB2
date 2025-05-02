import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AgregarProductoPage extends StatefulWidget {
  @override
  _AgregarProductoPageState createState() => _AgregarProductoPageState();
}

class _AgregarProductoPageState extends State<AgregarProductoPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _descripcionController = TextEditingController();
  final TextEditingController _urlController = TextEditingController();

  Future<void> _enviarProducto() async {
    final url = Uri.parse(
      'https://f05f-2800-98-1a08-fc1a-7c4a-74d6-15ed-528e.ngrok-free.app/api/Procedures/productos',
    ); // Cambia por tu URL real

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "nombre_producto": _nombreController.text,
        "descripccion_producto": _descripcionController.text,
        "url": _urlController.text,
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("✅ Producto agregado correctamente")),
      );
      _nombreController.clear();
      _descripcionController.clear();
      _urlController.clear();
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("❌ Error al agregar producto")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text("Agregar Producto"),
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
                  Icon(Icons.add_box, size: 80, color: Colors.teal[700]),
                  SizedBox(height: 20),
                  _buildInputField(
                    controller: _nombreController,
                    label: "Nombre del producto",
                    icon: Icons.shopping_bag,
                  ),
                  SizedBox(height: 15),
                  _buildInputField(
                    controller: _descripcionController,
                    label: "Descripción",
                    icon: Icons.description,
                  ),
                  SizedBox(height: 15),
                  _buildInputField(
                    controller: _urlController,
                    label: "URL de imagen",
                    icon: Icons.image,
                  ),
                  SizedBox(height: 25),
                  ElevatedButton.icon(
                    icon: Icon(Icons.save),
                    label: Text("Guardar Producto"),
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
                        _enviarProducto();
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
