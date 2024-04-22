import 'package:mysql1/mysql1.dart';
import 'Database.dart';
class Usuario{

  int? _idusuario;
  String? _nombre;
  String? _password;

// Constructor
 
Usuario();
Usuario.fromMap(ResultRow map){

    this._idusuario = map["idusuario"];
    this._nombre = map["nombre"];
    this._password = map["password"];

    }

//getters y setters
String? get nombre {
return this._nombre;
} 

set nombre(String? texto) => _nombre = texto;


String? get password {
return _password;
} 

set password (String? texto) => _password = texto;

int? get idusuario {
return _idusuario;
} 

set idusuario (int? numero) => _idusuario = numero;

//metodos

insertarUsuario() async {

  var conn = await Database().conexion();
  try{
  await conn.query("INSERT INTO usuarios(nombre,password)VALUES (?,?)",[_nombre,_password]);
  print("Usuario insertado correctamente");
  } catch(e){
    print(e);
  } finally {
  await conn.close();
  }
}


all()async{
  var conn = await Database().conexion();
  try{
  var listado = await conn.query("SELECT * FROM usuarios");
  List<Usuario> usuarios = listado.map((row) => Usuario.fromMap(row)).toList();
  return usuarios;
} catch(e){
    print(e);
}finally{
  await conn.close();
}

}


loginUsuario() async{
  var conn = await Database().conexion();
  try {
    var resultado = await conn.query("SELECT * FROM usuarios WHERE nombre = ?",[this._nombre]);
    Usuario usuario = Usuario.fromMap(resultado.first);
  if(this._password == usuario.password){
    return usuario;
  } else return false;
 
  }catch(e){
  print(e);
  return false;
  }finally{
  await conn.close();
}
}
}
