import 'package:flutter/material.dart';
import 'package:hello_world/data/cliente_service.dart';
import 'package:hello_world/models/CuentaPorCobrar.dart';
import 'package:intl/intl.dart';

class cuentascobrar extends StatefulWidget {
  @override
  State<cuentascobrar> createState() => _CuentasCobrarState();
}

class _CuentasCobrarState extends State<cuentascobrar> {
  late Future<List<CuentaPorCobrar>> _cuentas;

  @override
  void initState() {
    super.initState();
    _cuentas = CuentasPorCobrarService().obtenerCuentas();
  }

  String formatDate(DateTime date) {
    return DateFormat('dd/MM/yyyy').format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Cuentas por Cobrar")),
      backgroundColor: Colors.grey[100],
      body: FutureBuilder<List<CuentaPorCobrar>>(
        future: _cuentas,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("No hay cuentas por cobrar"));
          } else {
            final cuentas = snapshot.data!;
            return ListView.builder(
              itemCount: cuentas.length,
              itemBuilder: (context, index) {
                final cuenta = cuentas[index];
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 4,
                  child: ListTile(
                    title: Text(
                      cuenta.nombreCliente,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Monto: Q${cuenta.monto.toStringAsFixed(2)}"),
                        Text(
                          "Saldo pendiente: Q${cuenta.saldoPendiente.toStringAsFixed(2)}",
                        ),
                        Text(
                          "Último pago: ${formatDate(cuenta.fechaUltimoPago)}",
                        ),
                        Text(
                          "Vencimiento: ${formatDate(cuenta.fechaVencimiento)}",
                        ),
                      ],
                    ),
                    leading: Icon(
                      Icons.money_off,
                      color: const Color.fromARGB(255, 38, 247, 1),
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
