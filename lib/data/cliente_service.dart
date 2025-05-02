import 'dart:convert';
import 'package:hello_world/models/Cliente.dart';
import 'package:hello_world/models/Proveedor.dart';
import 'package:hello_world/models/producto.dart';
import 'package:http/http.dart' as http;

class ClienteService {
  final String url =
      'https://bf88-2800-98-1a08-fc1a-7c4a-74d6-15ed-528e.ngrok-free.app/api/Vistas/vista-clientes';

  Future<List<Cliente>> obtenerClientes() async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => Cliente.fromJson(json)).toList();
    } else {
      throw Exception('Error al cargar los clientes');
    }
  }
}

class ProveedorService {
  final String url =
      'https://bf88-2800-98-1a08-fc1a-7c4a-74d6-15ed-528e.ngrok-free.app/api/Vistas/vista-proveedores';

  Future<List<Proveedor>> obtenerProveedores() async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => Proveedor.fromJson(json)).toList();
    } else {
      throw Exception('Error al cargar los proveedores');
    }
  }
}

class ProductoService {
  final String url =
      'https://bf88-2800-98-1a08-fc1a-7c4a-74d6-15ed-528e.ngrok-free.app/api/Vistas/vista-productos';

  Future<List<Producto>> obtenerProducto() async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => Producto.fromJson(json)).toList();
    } else {
      throw Exception('Error al cargar los productos');
    }
  }
}
