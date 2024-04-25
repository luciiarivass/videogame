import 'Database.dart';
import 'package:mysql1/mysql1.dart';
class Avatar{
  //Propiedades
  int? idavatar;
  int? idusuario;
  String? nombre;
  String? habilidad;
  int vida = 3;

Avatar();
    
  Avatar.fromMap(ResultRow map) {
    idavatar = map['idavatar'];
    idusuario = map['idusuario'];
    nombre = map['nombre']; 
    habilidad = map["habilidad"];
  }

  insertarAvatar() async {

  var conn = await Database().conexion();
  try{
  await conn.query("INSERT INTO avatares(nombre,habilidad,idusuario,vida)VALUES (?,?,?,?)",[nombre,habilidad,idusuario,vida=3]);
  print("avatar insertado correctamente");

  } catch(e){
    print(e);
  } finally {
  await conn.close();
  }
}
 allFromUsuario(int? id) async{
    var conn = await Database().conexion();
    
    try{
      var resultado = await conn.query('SELECT * FROM avatares WHERE idusuario = ?',[id]);
      List<Avatar> avatares = resultado.map((row) => Avatar.fromMap(row)).toList();
      return avatares;
    } catch(e) {
      print(e);
    } finally {
      await conn.close();
    }
  }
  getAvatar(id)async{
    var conn = await Database().conexion();
    try{
      var resultado = await conn.query('SELECT * FROM avatares WHERE idavatar = ?',[id]);
      Avatar avatares = Avatar.fromMap(resultado.first);
      return avatares;
    } catch(e) {
      print(e);
    } finally {
      await conn.close();
    }
  }
}

