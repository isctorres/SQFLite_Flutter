import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';



class DataBaseHelper{

  static final nombreBD  = "CUSTOMERSDB";
  static final versionBD = 1;
  static final nombreTBL = "tbl_clientes";


  /*INSTANCIA SINGLETON DEL LA BD*/
  DataBaseHelper._privateConstructor();
  static final DataBaseHelper instancia = DataBaseHelper._privateConstructor();

  static Database _database;
  Future<Database> get database async{
    if( _database != null ) return _database;
    _database = await _initDataBase();
    return _database;
  }

  Future<Database> _initDataBase() async{
    Directory carpeta = await getApplicationDocumentsDirectory();
    String ruta = join(carpeta.path, nombreBD);
    return await openDatabase(
        ruta,
        version: versionBD,
        onCreate: _crearTabla
    );
  }

  Future _crearTabla(Database db, int version) async {
    await db.execute("CREATE TABLE $nombreTBL (idCliente INTEGER PRIMARY KEY, nomCliente VARCHAR(50), edadCliente INTEGER)");
  }

  Future<int> insertar(Map<String, dynamic> row) async{
    Database db = await instancia.database;
    return await db.insert(nombreTBL, row);
  }

  Future<int> actualizar(Map<String, dynamic> row) async{
    Database db = await instancia.database;
    int id = row['idCliente'];
    return await db.update(nombreTBL, row, where: 'idCliente = ?', whereArgs: [id]);
  }

  Future<int> eliminar(int id) async{
    Database db = await instancia.database;
    return await db.delete(nombreTBL, where: 'idCliente = ?', whereArgs: [id] );
  }

  Future<List<Map<String, dynamic>>> listarTodos() async{
    Database db = await instancia.database;
    return await db.query(nombreTBL);
  }

  Future<int> noRegistros() async{
    Database db = await instancia.database;
    return Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM $nombreTBL'));
  }
}