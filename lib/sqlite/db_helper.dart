import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'dart:io' as io;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:online_store/models/order.dart';

class DBHelper {
  static Database _db;
  static const String DB_NAME = 'foods2.db';
  static const String TABLE = 'orderlist';
  static const String foodsID = 'foodsid';
  static const String foodsName = 'foodsname';
  static const String price = 'price';
  static const String size = 'size';
  static const String qty = 'qty';
  static const String description = 'description';
  static const String images = 'images';
  static const String totalPrice = 'totalprice';

  Future<Database> get db async {
    if (_db != null) {
/*     _db = await dropTable();
       print('dddddddddddddddddddrop table');*/
      return _db;
    } else {
     _db = await initDB();
      return _db;
    }
  }

  initDB() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, DB_NAME);
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }


  dropTable() async{

    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, DB_NAME);
    var db = await openDatabase(path, version: 1, onCreate: _onDropTable);
    return _db;
  }

  _onDropTable(Database db, int version) async {
    await db.execute(
        'DROP TABLE IF EXISTS $TABLE');
  }


  _onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE IF NOT EXISTS $TABLE($foodsID INTEGER PRIMARY KEY,$foodsName TEXT,$price REAL,$size TEXT,$description TEXT,$images TEXT,$qty INTEGER,$totalPrice REAL)');
    print('ssssssssssssssssssssss');
  }

  Future<Order> save(Order order) async {
    var dbClient = await db;
    order.foodsID = await dbClient.insert(TABLE, order.toMap());
    return order;
    /*
    await dbClient.transaction((txn) async {
      var query = "INSERT INTO $TABLE ($NAME) VALUES ('" + employee.name + "')";
      return await txn.rawInsert(query);
    });
    */
  }



  Future<List<Order>> getOrders() async {
    var dbClient = await db;
    List<Map> maps = await dbClient.query(TABLE, columns: [
      foodsID,
      foodsName,
      price,
      size,
      qty,
      description,
      images,
      totalPrice
    ]);
    //List<Map> maps = await dbClient.rawQuery("SELECT * FROM $TABLE");
    List<Order> orders = [];
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        orders.add(Order.fromMap(maps[i]));
      }
    }
    return orders;
  }



  Future<List<Order>> getByID(int id) async {
    var dbClient = await db;
    List<Map> maps = await dbClient.query(TABLE,
        columns: [foodsID, foodsName, price,size,qty,description,images,totalPrice],
        where: '$foodsID = ?',
        whereArgs: [id]);
//   var result = await dbClient.rawQuery('SELECT * FROM $tableNote WHERE $columnId = $id');
    List<Order> orders = [];

    print('mapsL============' + maps.length.toString());

    if (maps.length > 0) {



      for (int i = 0; i < maps.length; i++) {
        orders.add(Order.fromMap(maps[i]));
      }
    }
    return orders;
    }



  Future<int> delete(int id) async {
    var dbClient = await db;
    return await dbClient.delete(TABLE, where: '$foodsID = ?', whereArgs: [id]);
  }

  Future<int> deleteAll() async {
    var dbClient = await db;
    return await dbClient.rawDelete("Delete from orderlist");
  }

  Future<int> updateBySQL({int foodsID}) async {
    var dbClient = await db;
    return await dbClient.rawDelete("Update orderlist SET qty=qty+1,totalprice=(price*qty)+price where foodsid = " + foodsID.toString());
  }




  Future<int> update(Order orders) async {
    var dbClient = await db;
    return await dbClient.update(TABLE, orders.toMap(),
        where: '$foodsID = ?', whereArgs: [orders.foodsID]);
  }

  Future close() async {
    var dbClient = await db;
    dbClient.close();
  }
}
