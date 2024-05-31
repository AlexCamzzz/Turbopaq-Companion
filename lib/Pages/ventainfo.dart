import 'package:flutter/material.dart';
import 'package:turbopaq_companion/Classes/sucursal.dart';

class VentainfoPage extends StatelessWidget {
  final Venta venta;

  const VentainfoPage({super.key, required this.venta});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalles de venta'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Cliente: ${venta.nombreCliente}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            Text('Guia: ${venta.guia}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            Text('Total: ${venta.total} MXN', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            Text('Fecha: ${venta.fechaCreacion}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            Text('Piezas: ${venta.piezas.length}', style: const TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
