import 'package:flutter/material.dart';
import 'package:sqflite_flutter/database_helper.dart';

void main() => runApp(Principal());

class Principal extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: 'Ejemplo con SQFLite',
      home: Clientes(),
    );
  }
}

class Clientes extends StatelessWidget{

  final DBHelper = DataBaseHelper.instancia;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Ejemplo SQFLite'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            RaisedButton(
              child: Text('Insertar'),
              onPressed: (){_insertar();},
            ),
            RaisedButton(
              child: Text('Actualizar'),
              onPressed: (){_actualizar();},
            ),
            RaisedButton(
              child: Text('Eliminar'),
              onPressed: (){_eliminar();},
            ),
            RaisedButton(
              child: Text('Consultar'),
              onPressed: (){_consultar();},
            ),
          ],
        ),
      ),
    );
  }

  /* METOOS*/
  void _insertar() async {
    Map<String,dynamic> row = {
      'nomCliente' : 'Rubensin',
      'edadCliente' : 35
    };

    final id = await DBHelper.insertar(row);
    print('Registro Insertado id: $id');
  }

  void _actualizar() async{
    Map<String, dynamic> row = {
      'idCliente' : 1,
      'nomCliente' : 'Rubensin Zaid',
      'edadCliente' : 1
    };
    
    final rowsAffected = await DBHelper.actualizar(row);
    print('Se actualizaron $rowsAffected registros');
  }

  void _eliminar() async{
    // Asumimos que solo hay un registro
    final id = await DBHelper.noRegistros();
    final rowsDeleted = await DBHelper.eliminar(id);
    print('Se borró el registro $id');
  }

  void _consultar() async{
    final allRows = await DBHelper.listarTodos();
    print('Reguistros:');
    allRows.forEach((row) => print(row));
  }
}