import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'dart:io' as io;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:online_store/models/order.dart';

class DBHelper {
  static Database _db;
  static const String DB_NAME = 'foods5.db';
  static const String TABLE = 'orderlist';
  static const String foodsID = 'foodsid';
  static const String foodsName = 'foodsname';
  static const String price = 'price';
  static const String size = 'size';
  static const String qty = 'qty';
  static const String description = 'description';
  static const String images = 'images';
  static const String totalPrice = 'totalprice';
  static const String taste = 'taste';
  static const String comment = 'comme';

  Future<Database> get db async {
    if (_db != null) {
      // _db = await dropTable();
      //  initDB();

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

  dropTable() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, DB_NAME);
    var db = await openDatabase(path, version: 1, onCreate: _onDropTable);
    return _db;
  }

  _onUpgrade(Database db, int oldVersion, int newVersion) {
    if (oldVersion < newVersion) {
      db.execute('ALTER TABLE orderlist ADD COLUMN taste TEXT;');
    }
  }

  _onDropTable(Database db, int version) async {
    await db.execute('DROP TABLE IF EXISTS $TABLE');
  }

  _onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE IF NOT EXISTS $TABLE($foodsID INTEGER PRIMARY KEY,$foodsName TEXT,$price REAL,$size TEXT,$description TEXT,$images TEXT,$qty INTEGER,$totalPrice REAL,$taste TEXT,$comment TEXT)');
  }

  Future<Order> save(Order order) async {
    print("===SAVE=====");
    var dbClient = await db;
    order.foodsID = await dbClient.insert(TABLE, order.toMap());

    print(order);
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
      totalPrice,
      taste,
      comment,
    ]);
    //List<Map> maps = await dbClient.rawQuery("SELECT * FROM $TABLE");
    List<Order> orders = [];

    print('==YYYYYYYYYYYYYY========' + maps.length.toString());
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
        columns: [
          foodsID,
          foodsName,
          price,
          size,
          qty,
          description,
          images,
          totalPrice,
          taste,
          comment
        ],
        where: '$foodsID = ?',
        whereArgs: [id]);
//   var result = await dbClient.rawQuery('SELECT * FROM $tableNote WHERE $columnId = $id');
    List<Order> orders = [];
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
    return await dbClient.rawDelete(
        "Update orderlist SET qty=qty+1,totalprice=(price*qty)+price where foodsid = " +
            foodsID.toString());
  }

  Future<int> removeQty(int id) async {
    var dbClient = await db;
    List<Map> maps = await dbClient.query(TABLE,
        columns: [
          foodsID,
          foodsName,
          price,
          size,
          qty,
          description,
          images,
          totalPrice,
          taste,
          comment
        ],
        where: '$foodsID = ?',
        whereArgs: [id]);
//   var result = await dbClient.rawQuery('SELECT * FROM $tableNote WHERE $columnId = $id');
    List<Order> orders = [];
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        orders.add(Order.fromMap(maps[i]));
      }
    }

    if (orders[0].qty == 1) {
      return await dbClient
          .delete(TABLE, where: '$foodsID = ?', whereArgs: [id]);
    } else {
      return await dbClient.rawUpdate(
          "Update orderlist SET qty=qty-1,totalprice=(price*qty)-price where foodsid = " +
              id.toString());
    }
  }

  Future<int> addQty(int id) async {
    var dbClient = await db;
    return await dbClient.rawUpdate(
        "Update orderlist SET qty=qty+1,totalprice=(price*qty)+price where foodsid = " +
            id.toString());
  }

  Future<double> calculateTotal() async {
    var dbClient = await db;
    var result = await dbClient.rawQuery("SELECT * FROM orderlist");
    List totalList;
    totalList = result.toList();
    double tot = 0;
    totalList.forEach((price) {
      tot = tot + price['totalprice'];
    });
    return tot;
    // return result.toList();
  }


  Future<String> getJsonOrder() async {
    var dbClient = await db;
    var result = await dbClient.rawQuery("SELECT * FROM orderlist");
    List totalList;
    totalList = result.toList();
    String json = '';
    int i = 0;
    totalList.forEach((price) {

      i += 1;

          json += '{"foodsID":"${price['foodsid']}",';
        json += '"foodsName":"${price['foodsname']}",';
        json += '"price":"${price['price']}",';
        json += '"size":"${price['size']}",';
        json += '"description":"${price['description']}",';
        json += '"qty":"${price['qty']}",';
        json += '"totalPrice":"${price['totalprice']}",';
        json += '"taste":"${price['taste']}",';
        if(i == totalList.length)
          {
            json += '"comment":"${price['comme']}"}';
          }
        else
          {
            json += '"comment":"${price['comme']}"},';
          }

    });
print(json);
    return json;





   // totalList = result.toList();
//    String json = '';
//    int foodID;
//    String foodName;
//    String price;
//    String size;
//    String qty;
//    String description;
//    String images;
//    String totalPrice;
//    String taste;
//    String comment;




//        json += '{"foodsID":"${orders[i].foodsID}",';
//        json += '"foodsName":"${orders[i].foodsName}",';
//        json += '"price":"${orders[i].price.toString()}",';
//        json += '"size":"${orders[i].size}",';
//        json += '"description":"${orders[i].description}",';
//        json += '"qty":"${orders[i].qty.toString()}",';
//        json += '"totalPrice":"${orders[i].totalPrice.toString()}",';
//        json += '"taste":"${orders[i].taste}",';
//        if (i == maps.length - 1) {
//          json += '"comment":"${orders[i].comme}"}';
//        } else {
//          json += '"comment":"${orders[i].comme}"},';
//        }


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
