import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:turbopaq_companion/Classes/sucursal.dart';
import 'package:turbopaq_companion/Pages/corteinfo.dart';
import 'package:turbopaq_companion/main.dart';
import 'helpers.dart';

class CajaPage extends StatefulWidget {
  final List<Corte> cortes;
  const CajaPage({super.key, required this.cortes});

  @override
  // ignore: library_private_types_in_public_api
  _CajaPageState createState() => _CajaPageState();
}

class _CajaPageState extends State<CajaPage> {
  late Corte seleccionado;

  @override
  void initState() {
    super.initState();
    seleccionado = widget.cortes.last; // Default to the last Corte
  }

  String dia() {
    if (isSameDay(seleccionado.fecha, DateTime.now())) {
      return "Hoy";
    } else {
      return DateFormat('dd - MMM - yyyy').format(seleccionado.fecha);
    }
  }

  @override
  Widget build(BuildContext context) {
    MainApp.data?.actualizarDineroEnCaja();
    String dinero = MainApp.data!.dineroEnCaja.toString();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: HexColor('#007BB2'),
        leading: Row(children: [Image.asset('assets/images/logo.png'),]),
        title: Text('Caja | ${dia()} | \$$dinero', style: const TextStyle(fontWeight: FontWeight.w900),),
        actions: <Widget>[
          IconButton(
            icon: const Icon(FontAwesomeIcons.calendar),
            onPressed: () async {
              final List<DateTime> selectedDates =
                  (await showCalendarDatePicker2Dialog(
                context: context,
                config: CalendarDatePicker2WithActionButtonsConfig(
                  disabledDayTextStyle: const TextStyle(
                    color: Colors.white,
                  ),
                  closeDialogOnCancelTapped: true,
                  calendarType: CalendarDatePicker2Type.single,
                  selectableDayPredicate: (date) => widget.cortes
                      .any((corte) => isSameDay(corte.fecha, date)),
                ),
                dialogSize: const Size(325, 400),
                value: [seleccionado.fecha],
              ))!
                      .cast<DateTime>();
              setState(() {
                seleccionado = widget.cortes.firstWhere(
                    (corte) => isSameDay(corte.fecha, selectedDates[0]));
              });
            },
            tooltip: 'Seleccionar Corte',
          ),
        ],
      ),
      body: CorteinfoPage(
        corte: seleccionado,
      ),
    );
  }
}

class CorteItem extends StatelessWidget {
  final Corte corte;

  const CorteItem({super.key, required this.corte});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Fecha: ${DateFormat('dd - MMM - yyyy').format(corte.fecha)}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text('Saldo Inicial: \$${corte.saldoInicial.toStringAsFixed(2)}'),
            Text('Saldo Final: \$${corte.saldoFinal.toStringAsFixed(2)}'),
            Text('Cantidad de Movimientos: ${corte.cantidadMovimientos}'),
            // Puedes añadir más detalles o incluso una lista de movimientos aquí
          ],
        ),
      ),
    );
  }
}
