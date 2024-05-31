// ignore_for_file: unnecessary_string_interpolations
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:turbopaq_companion/Classes/sucursal.dart';
import 'package:turbopaq_companion/Pages/ventainfo.dart';
import 'package:intl/intl.dart';

class VentasPage extends StatelessWidget {
  final List<Venta> ventas;
  const VentasPage({super.key, required this.ventas});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: HexColor('#007BB2'),
        leading: Row(children: [Image.asset('assets/images/logo.png'),]),
        title: const Text('VENTAS', style: TextStyle(fontWeight: FontWeight.w900),),
      ),
      body: GroupedListView<Venta, DateTime>(
        useStickyGroupSeparators: false,
        elements: ventas,
        groupBy: (Venta venta) => DateTime(venta.fechaCreacion.year,
            venta.fechaCreacion.month, venta.fechaCreacion.day),
        groupSeparatorBuilder: (fecha) => Container(
          padding: const EdgeInsets.all(5),
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 100),
          decoration: BoxDecoration(
            color: HexColor('#007BB2'),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Text(
            '${DateFormat(
              'dd/MMM/yyyy',
            ).format(fecha)}'.toUpperCase(),
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
        itemBuilder: (context, Venta venta) => Card(
          elevation: 1.0,
          margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
          child: ListTile(
            tileColor: Theme.of(context).listTileTheme.tileColor,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => VentainfoPage(venta: venta),
                ),
              );
            },
            title: Text(venta.guia),
            subtitle: Text(
                'Paquetera: ${venta.paquetera}, Total: ${venta.total} MXN'),
          ),
        ),
        itemComparator: (Venta a, Venta b) =>
            a.fechaCreacion.compareTo(b.fechaCreacion),
        floatingHeader: false,
        order: GroupedListOrder.DESC,
      ),
    );
  }
}
