import 'dart:io';

import 'usuario.dart';

class App{
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

  menuLogueado(resultado){

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
bool _InicialrespuestaIncorrecta(var numero) => numero == null || numero != 1 && numero !=2;
int? parsearOpcion () => int.tryParse(stdin.readLineSync() ?? 'e');
}