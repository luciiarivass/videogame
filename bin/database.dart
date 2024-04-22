import 'package:mysql1/mysql1.dart';

class Database {
  // Propiedades
  final String _host = 'localhost';
  final int _port = 3306;
  final String _user = 'root';

  // Métodos
  instalacion() async {
    var settings = ConnectionSettings(
      host: this._host, 
      port: this._port,
      user: this._user,
    );
    var conn = await MySqlConnection.connect(settings);
    try{
      await _crearDB(conn);
      await _crearTablaUsuarios(conn);
      await _crearTablaHabilidades(conn);
      await _crearTablaAvatares(conn);
      await conn.close();
    } catch(e){
      print(e);
      await conn.close();
    } 
  }

  Future<MySqlConnection> conexion() async {
    var settings = ConnectionSettings(
      host: this._host, 
      port: this._port,
      user: this._user,
      db: 'vgamedb'
    );
      
    return await MySqlConnection.connect(settings);
 
  }
  
  _crearDB (conn) async {
    await conn.query('CREATE DATABASE IF NOT EXISTS vgamedb');
    await conn.query('USE vgamedb');
    print('Conectado a vgamedb');
  }

  _crearTablaUsuarios(conn) async {
    await conn.query('''CREATE TABLE IF NOT EXISTS usuarios(
        idusuario INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
        nombre VARCHAR(50) NOT NULL UNIQUE,
        password VARCHAR(10) NOT NULL
    )''');
    print('Tabla usuarios creada');
  }

  _crearTablaHabilidades(conn) async {
    await conn.query('''CREATE TABLE IF NOT EXISTS habilidades(
        idhabilidad INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
        fuego VARCHAR(10) NOT NULL,
        aire VARCHAR(10) NOT NULL,
        tierra VARCHAR(10) NOT NULL,
        agua VARCHAR(10) NOT NULL
    )''');
    print('Tabla habilidades creada');
  }

  _crearTablaAvatares(conn) async {
    await conn.query('''CREATE TABLE IF NOT EXISTS avatares(
        idavatar INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
        nombre VARCHAR(50) NOT NULL,
        vida INT NOT NULL,
        idhabilidad INT NOT NULL,
        idusuario INT NOT NULL,
        FOREIGN KEY(idhabilidad) REFERENCES habilidades(idhabilidad),
        FOREIGN KEY(idusuario) REFERENCES usuarios(idusuario)
    )''');
    print('Tabla avatares creada');
  }
   
}