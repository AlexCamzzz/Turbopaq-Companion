import 'package:flutter/material.dart';
import 'package:turbopaq_companion/Classes/sucursal.dart';
import 'package:turbopaq_companion/main.dart';

class CorteinfoPage extends StatelessWidget {
  final Corte corte;

  const CorteinfoPage({super.key, required this.corte});

  @override
  Widget build(BuildContext context) {
    BusinessData? sucursal = MainApp.data;
    sucursal?.actualizarDineroEnCaja();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Dinero en caja: ${sucursal!.dineroEnCaja.toString()}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text('Saldo Inicial: \$${corte.saldoInicial.toStringAsFixed(2)}'),
            Text('Saldo Final: \$${corte.saldoFinal.toStringAsFixed(2)}'),
            Text('Cantidad de Movimientos: ${corte.cantidadMovimientos}'),
            const SizedBox(height: 16.0),
            const Text('Movimientos:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Expanded(
              child: ListView.builder(
                itemCount: corte.movimientos.length,
                itemBuilder: (context, index) {
                  final movimiento = corte.movimientos[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 5.0), // Adjust vertical spacing as needed
                    child: ListTile(
                      title: Text(movimiento.descripcion),
                      subtitle:
                          Text('${movimiento.tipo} - ${movimiento.metodo}'),
                      trailing:
                          Text('\$${movimiento.monto.toStringAsFixed(2)}', style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 15),),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
