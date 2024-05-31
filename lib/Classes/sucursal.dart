class BusinessData {
  List<Venta> ventas;
  List<dynamic> empleados;
  List<Corte> cortes;
  List<Usuario> usuarios;
  List<Horario> horarios;
  String nombreSucursal;
  String licencia;
  String telefono;
  double dineroEnCaja;
  dynamic emailApp;
  dynamic corteDeCajaSeleccionado;

  BusinessData({
    required this.ventas,
    required this.empleados,
    required this.cortes,
    required this.usuarios,
    required this.horarios,
    required this.nombreSucursal,
    required this.licencia,
    required this.telefono,
    required this.dineroEnCaja,
    required this.emailApp,
    required this.corteDeCajaSeleccionado,
  });

  factory BusinessData.fromMap(Map<String, dynamic> map) {
    return BusinessData(
      ventas: List<Venta>.from(map['Ventas'].map((x) => Venta.fromMap(x))),
      empleados: map['Empleados'],
      cortes: List<Corte>.from(map['Cortes'].map((x) => Corte.fromMap(x))),
      usuarios:
          List<Usuario>.from(map['Usuarios'].map((x) => Usuario.fromMap(x))),
      horarios:
          List<Horario>.from(map['Horarios'].map((x) => Horario.fromMap(x))),
      nombreSucursal: map['NombreSucursal'],
      licencia: map['Licencia'],
      telefono: map['Telefono'],
      dineroEnCaja: map['DineroEnCaja'],
      emailApp: map['EmailApp'],
      corteDeCajaSeleccionado: map['CorteDeCajaSeleccionado'],
    );
  }

  void actualizarDineroEnCaja(){
    dineroEnCaja = cortes.last.saldoFinal;
  }
}

List<DateTime> fechasCortes(List<Corte> cortes) {
  List<DateTime> fechas = [];
  for (Corte c in cortes) {
    fechas.add(c.fecha);
  }
  return fechas;
}

class Venta {
  String nombreCliente;
  String guia;
  String celular;
  String paquetera;
  String metodoPago;
  String costoCotizado;
  double total;
  List<Pieza> piezas;
  DateTime fechaCreacion;
  String status;
  bool piezasAjustadas;

  Venta({
    required this.nombreCliente,
    required this.guia,
    required this.celular,
    required this.paquetera,
    required this.metodoPago,
    required this.costoCotizado,
    required this.total,
    required this.piezas,
    required this.fechaCreacion,
    required this.status,
    required this.piezasAjustadas,
  });

  factory Venta.fromMap(Map<String, dynamic> map) {
    DateTime fechalocal = map['FechaCreacion'];

    return Venta(
      nombreCliente: map['NombreCliente'],
      guia: map['Guia'],
      celular: map['Celular'],
      paquetera: map['Paquetera'],
      metodoPago: map['MetodoPago'],
      costoCotizado: map['CostoCotizado'],
      total: map['Total'],
      piezas: List<Pieza>.from(map['Piezas'].map((x) => Pieza.fromMap(x))),
      fechaCreacion: fechalocal.toLocal(),
      status: map['Status'],
      piezasAjustadas: map['PiezasAjustadas'],
    );
  }

  String fechaString() {
    String str = "";

    str += fechaCreacion.day.toString();
    switch (fechaCreacion.month) {
      case 1:
        str += "-ENE-";
        break;
      case 2:
        str += "-FEB-";
        break;
      case 3:
        str += "-MAR-";
        break;
      case 4:
        str += "-ABR-";
        break;
      case 5:
        str += "-MAY-";
        break;
      case 6:
        str += "-JUN-";
        break;
      case 7:
        str += "-JUL-";
        break;
      case 8:
        str += "-AGO-";
        break;
      case 9:
        str += "-SEP-";
        break;
      case 10:
        str += "-OCT-";
        break;
      case 11:
        str += "-NOV-";
        break;
      case 12:
        str += "-DIC-";
        break;
    }
    str += fechaCreacion.year.toString();

    return str;
  }
}

class Pieza {
  String guia;
  dynamic alto;
  dynamic largo;
  dynamic ancho;
  dynamic peso;
  int noPieza;
  double pesoVolumetrico;
  bool ajustada;

  Pieza({
    required this.guia,
    this.alto,
    this.largo,
    this.ancho,
    this.peso,
    required this.noPieza,
    required this.pesoVolumetrico,
    required this.ajustada,
  });

  factory Pieza.fromMap(Map<String, dynamic> map) {
    return Pieza(
      guia: map['Guia'],
      alto: map['Alto'],
      largo: map['Largo'],
      ancho: map['Ancho'],
      peso: map['Peso'],
      noPieza: map['NoPieza'],
      pesoVolumetrico: double.parse(map['PesoVolumetrico'].toString()),
      ajustada: map['Ajustada'],
    );
  }
}

class Corte {
  DateTime fecha;
  double saldoInicial;
  double saldoFinal;
  int cantidadMovimientos;
  List<Movimiento> movimientos;

  Corte({
    required this.fecha,
    required this.saldoInicial,
    required this.saldoFinal,
    required this.cantidadMovimientos,
    required this.movimientos,
  });

  factory Corte.fromMap(Map<String, dynamic> map) {
    return Corte(
      fecha: map['FechaSerialized'],
      saldoInicial: map['SaldoInicial'],
      saldoFinal: map['SaldoFinal'],
      cantidadMovimientos: map['CantidadMovimientos'],
      movimientos: List<Movimiento>.from(
          map['Movimientos'].map((x) => Movimiento.fromMap(x))),
    );
  }
}

class Movimiento {
  String tipo;
  String descripcion;
  String metodo;
  double monto;
  DateTime fecha;

  Movimiento({
    required this.tipo,
    required this.descripcion,
    required this.metodo,
    required this.monto,
    required this.fecha,
  });

  factory Movimiento.fromMap(Map<String, dynamic> map) {
    DateTime fechalocal = map['Fecha'];

    return Movimiento(
      tipo: map['Tipo'],
      descripcion: map['Descripcion'],
      metodo: map['MetodoDePago'],
      monto: map['Monto'],
      fecha: fechalocal.toLocal(),
    );
  }
}

class Usuario {
  int userIndex;
  String userID;
  String nombreUsuario;
  String contrasena;
  String rol;

  Usuario({
    required this.userIndex,
    required this.userID,
    required this.nombreUsuario,
    required this.contrasena,
    required this.rol,
  });

  factory Usuario.fromMap(Map<String, dynamic> map) {
    return Usuario(
      userIndex: map['UserIndex'],
      userID: map['UserID'],
      nombreUsuario: map['NombreUsuario'],
      contrasena: map['Contraseña'],
      rol: map['Rol'],
    );
  }
}

class Horario {
  DateTime apertura;
  DateTime salida;
  DateTime dia;

  Horario({
    required this.apertura,
    required this.salida,
    required this.dia,
  });

  factory Horario.fromMap(Map<String, dynamic> map) {
    return Horario(
      apertura: map['Apertura'],
      salida: map['Salida'],
      dia: DateTime.now(),
    );
  }
}
