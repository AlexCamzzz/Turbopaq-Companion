import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:turbopaq_companion/main.dart';

class Requester {
  Requester();

  Future<List<double>> realizarPrediccion() async {
    List<String> datos = MainApp.data!.generarJsonsPrediccion();
    List<dynamic> meses = jsonDecode(datos[0]);
    List<dynamic> ventas = jsonDecode(datos[1]);
    double promedio = double.parse(datos[2]);



  final response = await http.post(
    Uri.parse('https://rgc03cyf8c.execute-api.us-east-1.amazonaws.com/Predicciones'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=utf-8',
    },
    body: jsonEncode({
      'meses': meses,
      'ventas': ventas,
      'promedio': promedio,
    }),
  );

  if (response.statusCode == 200) {
    List<double> resultados = [];
    Map<String, dynamic> data = jsonDecode(response.body);
    double ventasEsperadas = data['ventasEsperadas'];
    double ingresosEsperados = data['ingresosEsperados'];
    resultados.add(ventasEsperadas);
    resultados.add(ingresosEsperados);

    return resultados;
  } else {
    throw Exception('Error al realizar la predicción: ${response.statusCode}');
  }
}
}
