import 'package:mongo_dart/mongo_dart.dart';
import './sucursal.dart';

Future<BusinessData?> fetchSucursal(String id) async {
  const connectionUri = "mongodb+srv://Administrador:Sekhi2409@paquetelleguexpress.l2stpfa.mongodb.net/Paquetelleguexpress";
  Db db;
  db = await Db.create(connectionUri);
  
  await db.open();


  var collection = db.collection('Sucursales');

  var document = await collection.findOne(where.eq('_id', ObjectId.fromHexString(id)));


  await db.close();

  if (document != null) {
        return BusinessData.fromMap(document);
  } else {
    return null;
  }
}
