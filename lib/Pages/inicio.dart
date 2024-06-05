// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:turbopaq_companion/Classes/requesthttp.dart';
import 'package:turbopaq_companion/main.dart';

class InicioPage extends StatefulWidget {
  const InicioPage({super.key});

  @override
  _InicioPageState createState() => _InicioPageState();
}

class _InicioPageState extends State<InicioPage> {
  static List<String> prediccion = [
    "ACTUALIZA PARA PREDECIR",
    "ACTUALIZA PARA PREDECIR"
  ];
  static Requester requester = Requester();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final String mes = MainApp.data!.mesActual();
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: isLoading
                ? null
                : () async {
                    setState(() {
                      isLoading = true;
                    });
                    List<double> datos = await requester.realizarPrediccion();
                    List<String> pred = [];
                    pred.add(datos[0].toStringAsFixed(0));
                    pred.add(datos[1].toStringAsFixed(2));
                    setState(() {
                      prediccion = pred;
                      isLoading = false;
                    });
                  },
            icon: const Icon(FontAwesomeIcons.arrowsRotate),
          ),
        ],
        backgroundColor: HexColor('#007BB2'),
        leading: Image.asset('assets/images/logo.png'),
        title: const Text(
          'TURBOPAQ',
          style: TextStyle(
            fontWeight: FontWeight.w900,
            color: Colors.black,
          ),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Text(
              'VENTAS PRONOSTICADAS $mes',
              style: const TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: HexColor('ffb100'),
              ),
              padding: const EdgeInsets.all(10),
              child: isLoading
                  ? const CircularProgressIndicator()
                  : Text(
                      prediccion[0],
                      style: const TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 20,
                      ),
                    ),
            ),
            const SizedBox(height: 20),
            Text(
              'INGRESOS ESPERADOS $mes',
              style: const TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: HexColor('ffb100'),
              ),
              padding: const EdgeInsets.all(10),
              child: isLoading
                  ? const CircularProgressIndicator()
                  : Text(
                      "\$${prediccion[1]}",
                      style: const TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 20,
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
