import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class InicioPage extends StatelessWidget {
  const InicioPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: HexColor('#007BB2'),
        leading: Row(
          children: [
            Image.asset('assets/images/logo.png'),
          ],
        ),
        title: const Text(
          'TURBOPAQ',
          style: TextStyle(fontWeight: FontWeight.w900),
        ),
      ),
      body: const Center(
        child: Column(
          children: [
            Expanded(
              child: Card(
                color: Colors.indigo,
                child: Center(
                  child: Text('FUTURAS VENTAS',style: TextStyle(fontWeight: FontWeight.w900),),
                ),
              ),
            ),
            Expanded(
              child: const Card(
                color: Colors.indigo,
                child: Center(
                  child: Text('INGRESOS ESPERADOS', style: TextStyle(fontWeight: FontWeight.w900,)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
