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
    } while(_InicialrespuestaIncorrecta2(opcionElegida));
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
    1- Crear avatar.
    2- Listar mis avatares.
    3- Jugar.""");
    
      opcionElegida = parsearOpcion();
    } while(_InicialrespuestaIncorrecta3(opcionElegida));
    switch(opcionElegida){
      case 1:
        crearAvatar(usuario.idusuario);
        break;
      case 2:
        listarMisAvatares(usuario.idusuario);
        break;
      case 3:
        menuJuego(usuario);
        break;
      default:
        stdout.writeln("Ha habido algún error, intentelo de nuevo...");
    }
  }
  menuJuego(Usuario usuario){
    stdout.writeln(""""Bienvenido al Juego de Hackeo del Sistema de Inteligencia Artificial.
    TIENES 3 VIDAS! Mucha suerte ${usuario.nombre}...""");
    do{
      stdout.writeln("Escoge uno de tus avatares para comenzar!");
      listarMisAvatares(usuario.idusuario);
      stdin.readLineSync()?? "e";
    }while();
    nivel1();

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

bool _InicialrespuestaIncorrecta2(var numero) => numero == null || numero != 1 && numero !=2;
bool _InicialrespuestaIncorrecta3(var numero) => numero == null || numero != 1 && numero !=2 && numero !=3;
int? parsearOpcion () => int.tryParse(stdin.readLineSync() ?? 'e');

nivel1(Avatar avatar){
int? opcionElegida;
do{
  stdout.writeln("""Bienvenido al primer nivel...
  Estás intentando acceder a un sistema de inteligencia artificial.
  Encuentras 3 puertas, debes acceder por una de ellas...
  1- ROJO
  2- AZUL
  3- VERDE""");
opcionElegida = parsearOpcion();
} while(_InicialrespuestaIncorrecta3(opcionElegida));
 switch(opcionElegida){
      case 1:
        sleep(Duration(seconds: 1));
        stdout.writeln("""Vaya... parece que te han pillado los guardias. 
        Pierdes una vida...""");
        avatar.vida -=1; 
        nivel1(avatar);
      break;
      case 2:
        sleep(Duration(seconds: 1));
         stdout.writeln("""Esta es la puerta correcta... 
         Pasas al nivel 2!""");
      break;
      case 3:
      sleep(Duration(seconds: 1));
       stdout.writeln("""Vaya... parece que ha habido una complicación...
       Necesitas resolver el puzzle para continuar.""");
        
      default:
        stdout.writeln("Parece que ha habido algún error...");
}

}
nivel2(){
}
nivel3(){

}
nivel4(){
  
}
nivel5(){
  
}
}
