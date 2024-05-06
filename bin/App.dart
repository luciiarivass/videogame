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

  menuLogueado(Usuario usuario) async {
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
        await crearAvatar(usuario.idusuario);
        await menuLogueado(usuario);
        break;
      case 2:
        await listarMisAvatares(usuario.idusuario);
        await menuLogueado(usuario);
        break;
      case 3:
        await menuJuego(usuario);
        break;
      default:
        stdout.writeln("Ha habido algún error, intentelo de nuevo...");
    }
  }
  menuJuego(Usuario usuario,) async {
    int? opcionElegida;
    stdout.writeln("""Bienvenido al Juego de Hackeo del Sistema de Inteligencia Artificial.
    TIENES 3 VIDAS! Mucha suerte ${usuario.nombre}...""");
        do{
      stdout.writeln("""Elige con que personaje comenzar:
      """);
      await listarMisAvatares(usuario.idusuario);
      opcionElegida = parsearOpcion();
    } while(opcionElegida == null);
  
    Avatar avatar = await escogerAvatar(opcionElegida);
    nivel1(avatar,usuario);
    
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
    menuLogueado(id);
  }

  listarMisAvatares(int? id) async{
    var listadoAvatar = await Avatar().allFromUsuario(id);
    for(Avatar elemento in listadoAvatar){
      stdout.writeln("${elemento.idavatar} - ${elemento.nombre} - ${elemento.habilidad}");
    }
    return listadoAvatar;
  }

bool _InicialrespuestaIncorrecta2(var numero) => numero == null || numero != 1 && numero !=2;
bool _InicialrespuestaIncorrecta3(var numero) => numero == null || numero != 1 && numero !=2 && numero !=3;
int? parsearOpcion () => int.tryParse(stdin.readLineSync() ?? 'e');

nivel1(Avatar avatar, Usuario usuario) async {
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
        nivel1(avatar,usuario);
      break;
      case 2:
        sleep(Duration(seconds: 1));
         stdout.writeln("""Esta es la puerta correcta... 
         Pasas al nivel 2!""");
         nivel2(avatar,usuario);
      break;
      case 3:
      sleep(Duration(seconds: 1));
       stdout.writeln("""Vaya... parece que ha habido una complicación...
       Necesitas resolver el puzzle para continuar.
       Tienes solo una oportunidad...""");
       await getRandomPuzzle(avatar);
       nivel2(avatar,usuario);
       break;
      default:
        stdout.writeln("Parece que ha habido algún error...");
  }
  looseGame(avatar,usuario);
}
nivel2(Avatar avatar,Usuario usuario){
  String? opcionElegida;
  int oportunidades = 4;
  
do{
  oportunidades--;
  if(oportunidades == 0) break;
  stdout.writeln("""Segundo nivel...
  Estás intentando autenticarte en el sistema...
  Acierta las claves de acceso:
  Debes descifrar los siguientes anagramas:
  1 . PRISA""");
opcionElegida = stdin.readLineSync()?? "e";
} while(opcionElegida != "paris"  && opcionElegida != "PARIS" );
 if(oportunidades == 0) {
  stdout.writeln("""Parece que has perdido tus 3 intentos... 
  Te daré una pista, son Nombres de ciudades.""");
 } else {
  do{
  oportunidades--;
  if(oportunidades == 0) break; // MIRAR
  stdout.writeln("""
  Debes descifrar el último anagrama para autenticarte:
  2 . AMOR""");
opcionElegida = stdin.readLineSync()?? "e";
} while(opcionElegida != "ROMA"  && opcionElegida != "roma" );
looseGame(avatar,usuario);
 }
}
nivel3(Avatar avatar,Usuario usuario){

stdout.writeln("""Tercer nivel...
Necesitas desactivar el cortafuegos para continuar, debes adivinar
la clave de acceso. Mucha suerte ${avatar.nombre}!""");

looseGame(avatar,usuario);
 }
nivel4(){
  
}
nivel5(){
  
}
 juegonivel3(Avatar avatar){
  String? respuesta;
    List <String> palabras = ["virus","spam","hacker","host","clase","privado","server","logico","teclado"];
    Random random = Random();
    String palabraSecreta = palabras[random.nextInt(palabras.length)];
    String palabraJuego = "_" * palabraSecreta.length;
    int oportunidad = 10;
    stdout.writeln("""Instrucciones:
    - Para descifrar la palabra tienes 10 intentos, debes introducir distintas letras,
    y cada letra es un intento.
    - Cuando descifre una letra se irá mostrando en cada intento.
    - Si pierdes los 10 intentos se le quitará una vida.
    Las palabras a descifrar son...
    """);
    sleep(Duration(seconds: 1));
    stdout.writeln("$palabras");
    do{
      oportunidad --;
      stdout.writeln("""
    - Palabra : $palabraJuego
    - Te quedan $oportunidad oportunidades""");
    respuesta = stdin.readLineSync();
    if(respuesta == palabraSecreta){
      stdout.writeln("Enhorabuena has acertado! Pasas al último nivel.");
    }

    }while(respuesta != palabraSecreta);

     if (oportunidad == 0){
      avatar.vida-=1;
      stdout.writeln("Pierdes una vida! Te quedan ${avatar.vida} vidas.");
    }

  }
getRandomPuzzle(Avatar avatar){
  int oportunidad = 1;
  String? respuesta;
  var puzzle  = {
    1 : """Cinco máquinas son capaces de redactar 5 artículos en cinco minutos.
           Con este ritmo de producción,¿cuánto tiempo necesitan 100 máquinas para elaborar 100 artículos?""",
    2 : "¿Cuál es el resultado de 3+3x3+3?",
    3 : "¿Qué número corresponde para seguir la serie? 1, 3, 6, 10, 15, 21 …",
    4 : "¿Cuántas ½ sandías encontramos en 3 sandías y media?",
    5 : """Para tratar de resolver sin calculadora,
           ¿por cuánto hay que multiplicar 21978 para que el resultado sea 87912?""",
    6 : """En un número de tres dígitos, el del medio es 4 veces más grande que el tercero,
           y el primero es tres unidades menos que el segundo. ¿De qué número se trata?""",
    };
    int random = Random().nextInt(6);
    switch(random){
      case 1: 
      do{
        stdout.writeln(puzzle[1]);
        respuesta = stdin.readLineSync()?? "e";
        oportunidad --;
      }while(respuesta != "5" );
      break;
      case 2:
      do{
        stdout.writeln(puzzle[2]);
        respuesta = stdin.readLineSync()?? "e";
        oportunidad --;
      }while(respuesta != "15");
      break;
      case 3:
      do{
        stdout.writeln(puzzle[3]);
        respuesta = stdin.readLineSync()?? "e";
        oportunidad --;
      }while(respuesta != "28");
      break;
      case 4:
      do{
        stdout.writeln(puzzle[4]);
        respuesta = stdin.readLineSync()?? "e";
        oportunidad --;
      }while(respuesta != "7");
      break;
      case 5:
      do{
        stdout.writeln(puzzle[5]);
        respuesta = stdin.readLineSync()?? "e";
        oportunidad --;
      }while(respuesta != "4");
      break;
      case 6:
      do{
        stdout.writeln(puzzle[6]);
        respuesta = stdin.readLineSync()?? "e";
        oportunidad --;
      }while(respuesta != "141");
      break;
    }
    if (oportunidad == 0){
      avatar.vida-=1;
      stdout.writeln("Pierdes una vida! Te quedan ${avatar.vida} vidas.");
    }
}
escogerAvatar(id)async{
  
    return await Avatar().getAvatar(id);
}
looseGame(Avatar avatar, Usuario usuario)async{
  int? opcionElegida;
  if(avatar.vida==0){
    do{
    stdout.writeln(""""
  Vaya... Parece que has perdido todas tus vidas
  1 - Intentar de nuevo
  2 - Volver al menú Inicial
  3- Salir""");
    opcionElegida = parsearOpcion();
    } while(_InicialrespuestaIncorrecta3(opcionElegida));
   }
   switch(opcionElegida){
      case 1:
        await menuJuego(usuario);
        break;
      case 2:
        await menuInicial();
        break;
      case 3:
        stdout.writeln("Adios ${usuario.nombre}!");
        break;
    }
}
}
