import 'package:hello_world/models/Cliente.dart';
import 'package:hello_world/models/Proveedor.dart';
import 'package:hello_world/data/cliente_service.dart';
import 'package:hello_world/screens/vw_clientes.dart'; // Vista
import 'package:hello_world/screens/vw_proveedores.dart';
import 'package:hello_world/screens/vw_producto.dart'; // Vista
import 'package:hello_world/screens/vw_cuentascobrar.dart'; // Vista
import 'package:hello_world/screens/vw_cuentaspagar.dart';
import 'package:hello_world/screens/AgregarProductoPage.dart'; // Vista
import 'package:hello_world/screens/AgregarClientePage.dart'; // Vista
import 'package:hello_world/screens/AgregarProveedorPage.dart'; // Vista
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: StockInventarioPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class StockInventarioPage extends StatelessWidget {
  final List<_MenuItem> items = [
    _MenuItem("Productos", Icons.inventory_2_outlined),
    _MenuItem("Agregar productos", Icons.outbox),
    _MenuItem("Clientes", Icons.people),
    _MenuItem("Agregar Clientes", Icons.add_circle_outline),
    _MenuItem("Proveedores", Icons.business),
    _MenuItem("Agregar Proveedores", Icons.add_business),
    _MenuItem("Cuentas por Pagar", Icons.account_balance),
    _MenuItem("Cuentas por Cobrar", Icons.account_balance_wallet),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Stock e Inventario"),
        backgroundColor: Colors.black87,
      ),
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Container(
            color: Colors.grey[800],
            padding: EdgeInsets.all(8),
            width: double.infinity,
            child: Center(
              child: Text(
                "- Zapateria el Pie Grande -",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          Expanded(
            child: GridView.count(
              padding: EdgeInsets.all(8),
              crossAxisCount: 2,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              children:
                  items
                      .map(
                        (item) => Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[900],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: InkWell(
                            onTap: () {
                              final key = item.label.toLowerCase().replaceAll(
                                " ",
                                "",
                              );
                              if (routeMap.containsKey(key)) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => routeMap[key]!(),
                                  ),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Pantalla aún no implementada',
                                    ),
                                  ),
                                );
                              }
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(item.icon, size: 40, color: Colors.white),
                                SizedBox(height: 8),
                                Text(
                                  item.label,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                      .toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class _MenuItem {
  final String label;
  final IconData icon;

  _MenuItem(this.label, this.icon);
}

final Map<String, Widget Function()> routeMap = {
  "productos": () => VwProducto(),
  "agregarproductos": () => AgregarProductoPage(),
  "clientes": () => clientes(),
  "agregarclientes": () => AgregarClientePage(),
  "proveedores": () => VwProveedores(),
  "agregarproveedores": () => AgregarProveedorPage(),
  "cuentasporpagar": () => VwCuentaspagar(),
  "cuentasporcobrar": () => cuentascobrar(),
};
