import 'Database.dart';
import 'habilidad.dart';
class Avatar{
  //Propiedades
  int? idavatar;
  String? _nombre;
  Habilidad? _habilidad;
  insertarAvatar() async {

  var conn = await Database().conexion();
  try{
  await conn.query("INSERT INTO avatares(nombre,idhabilidad)VALUES (?,?)",[_nombre,_habilidad]);
  print("avatar insertado correctamente");

  } catch(e){
    print(e);
  } finally {
  await conn.close();
  }
}
}