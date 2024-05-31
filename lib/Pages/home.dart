import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:turbopaq_companion/Classes/sucursal.dart';
import 'package:turbopaq_companion/Pages/inicio.dart';
import 'package:turbopaq_companion/Theme/Tema.dart';
import 'package:turbopaq_companion/main.dart';
import 'caja.dart';
import 'ventas.dart';
import '../Classes/mongohandling.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

Color? color = light.iconTheme.color;

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  static late Future<BusinessData?>? sucursalFuture;

  @override
  void initState() {
    super.initState();
    sucursalFuture = fetchSucursal('65ce5862f25ddef040197194');
  }

  static List<GButton> tabs = [
    GButton(
      icon: Icons.home,
      text: 'Inicio',
      iconColor: color,
    ),
    GButton(
      icon: FontAwesomeIcons.cashRegister,
      text: 'Caja',
      iconColor: color,
    ),
    GButton(
      icon: FontAwesomeIcons.rectangleList,
      text: 'Ventas',
      iconColor: color,
    ),
    GButton(
      icon: Icons.settings,
      text: 'Configuración',
      iconColor: color,
    ),
  ];

  static List<Widget> _pages(List<Corte> cortes, List<Venta> v) {
    return [
      const InicioPage(),
      CajaPage(cortes: cortes),
      VentasPage(ventas: v),
      const Center(child: Text('Página de Configuración')),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Scaffold(
          body: FutureBuilder<BusinessData?>(
            future: sucursalFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                print(snapshot.stackTrace);
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data == null) {
                return const Center(child: Text('Sucursal not found'));
              } else {
                BusinessData sucursal = snapshot.data!;
                MainApp.data = snapshot.data!;
                // Use sucursal data as needed
                return _pages(sucursal.cortes, sucursal.ventas)[_selectedIndex];
              }
            },
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: GNav(
                activeColor: Colors.indigo.shade50, // Choose an appropriate color
                tabBackgroundColor: HexColor('007BB2'),
                gap: 10,
                padding: const EdgeInsets.all(10),
                selectedIndex: _selectedIndex,
                onTabChange: _onItemTapped,
                tabs: tabs,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
