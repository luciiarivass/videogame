import 'dart:io';
import 'avatar.dart';
import 'dart:math';
import 'usuario.dart';

class App{
  List<String> habilidades = ["Fuego","Aire","Tierra","Agua"];
  menuInicial(){
    int? opcionElegida;
    do{
      stdout.writeln('''Elige una opción
      1 - Crear usuario
      2 - Log in''');
      opcionElegida = parsearOpcion();
    } while(_InicialrespuestaIncorrecta(opcionElegida));
    switch(opcionElegida){
      case 1:
        crearUsuario();
        break;
      case 2:
        login();
        break;
    }
  }

  menuLogueado(Usuario usuario) {
   int? opcionElegida;
    do{
      stdout.writeln("""Buenas ${usuario.nombre}! 
    1- Crear avatar
    2- Listar avatares""");
      opcionElegida = parsearOpcion();
    } while(_InicialrespuestaIncorrecta(opcionElegida));
    switch(opcionElegida){
      case 1:
        crearAvatar(usuario.idusuario);
        break;
      case 2:
        listarMisAvatares(usuario.idusuario);
        break;
    }
  }

  login() async {
    Usuario usuario = new Usuario();
    stdout.writeln('Introduce tu nombre de usuario');
    usuario.nombre = stdin.readLineSync();
    stdout.writeln('Introduce tu constraseña');
    usuario.password = stdin.readLineSync();
    var resultado = await usuario.loginUsuario();
    if(resultado == false){
      stdout.writeln('Tu nombre de usuario o contraseña son incorrectos');
      menuInicial();
    } else {
      menuLogueado(resultado);
    }
  }
  crearUsuario() async {
    Usuario usuario = new Usuario();
    stdout.writeln('Introduce un nombre de usuario');
    usuario.nombre = stdin.readLineSync();
    stdout.writeln('Introduce una constraseña');
    usuario.password = stdin.readLineSync();
    await usuario.insertarUsuario();
    menuInicial();
  }

  crearAvatar(id) async {
    Avatar avatar = new Avatar();
    stdout.writeln('Introduce un nombre para tu avatar');
    avatar.nombre = stdin.readLineSync();
    stdout.writeln('La habilidad de tu avatar es...');
    sleep(Duration(seconds: 1));
    int random = Random().nextInt(4);
    stdout.writeln(habilidades[random]);
    avatar.habilidad = habilidades[random];
    avatar.idusuario = id;
    await avatar.insertarAvatar();
    menuInicial();
  }

  listarMisAvatares(int? id) async{
    var listadoAvatar = await Avatar().allFromUsuario(id);
    for(Avatar elemento in listadoAvatar){
      stdout.writeln("${elemento.nombre} - ${elemento.habilidad}");
    }
    return listadoAvatar;
  }

bool _InicialrespuestaIncorrecta(var numero) => numero == null || numero != 1 && numero !=2;
int? parsearOpcion () => int.tryParse(stdin.readLineSync() ?? 'e');
}