class Order {
  int foodsID;
  String foodsName;
  double price;
  String size;
  String description;
  String images;
  int qty;
  double totalPrice;

  Order(this.foodsID, this.foodsName, this.price, this.size, this.description,
      this.images, this.qty, this.totalPrice);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'foodsid': foodsID,
      'foodsname': foodsName,
      'price': price,
      'size': size,
      'description': description,
      'images': images,
      'qty': qty,
      'totalprice': totalPrice,
    };
    return map;
  }

  Order.fromMap(Map<String, dynamic> map) {
    foodsID = map['foodsid'];
    foodsName = map['foodsname'];
    price = map['price'];
    size = map['size'];
    description = map['description'];
    images = map['images'];
    qty = map['qty'];
    totalPrice = map['totalprice'];
  }
}

class resultInsertOrder {
  String ResultOk;
  String ErrorMessage;

  resultInsertOrder({
    this.ResultOk,
    this.ErrorMessage,
  });

  factory resultInsertOrder.fromJson(Map<String, dynamic> parsedJson) {
    return resultInsertOrder(
        ResultOk: parsedJson['ResultOk'],
        ErrorMessage: parsedJson['ErrorMessage']);
  }
}

class InsertOrder {
  String restuarantID;
  String userID;
  String tableID;
  List<OrderList> orderList;

  InsertOrder({
    this.restuarantID,
    this.userID,
    this.tableID,
    this.orderList
});





  Map<String, dynamic> toJson() => _itemToJson(this);

}

Map<String, dynamic> _itemToJson(InsertOrder instance) {

  List<Map<String, dynamic>> _orderList = instance.orderList != null
      ? instance.orderList.map((i) => i.toJson()).toList()
      : null;


  return <String, dynamic>{
    'restuarantID': instance.restuarantID,
    'userID': instance.userID,
    'tableID': instance.tableID,
    'orderList': _orderList,
  };
}




class OrderList
{
  int foodID;
  String foodName;
  double price;
  String size;
  String description;
  String images;
  int qty;
  double totalPrice;

  OrderList(this.foodID, this.foodName, this.price, this.size, this.description,
      this.images, this.qty, this.totalPrice);
  Map<String, dynamic> toJson() => _OrderListToJson(this);

}

Map<String, dynamic> _OrderListToJson(OrderList instance) => <String, dynamic>{
  'foodID': instance.foodID,
  'foodName': instance.foodName,
  'price': instance.price,
  'size': instance.size,
  'description': instance.description,
  'images': instance.images,
  'qty': instance.qty,
  'totalPrice': instance.totalPrice
};

class StatusOrder{
  String ResultOk;
  String ErrorMessage;
  String ReturnMessage;
  List<StatusOrderlist> orderList;

  StatusOrder  ({this.ResultOk,
    this.ErrorMessage,
    this.ReturnMessage,
    this.orderList});

  factory StatusOrder.fromJson(Map<String, dynamic> parsedJson){

    var list = parsedJson['orderList'] as List;
    List<StatusOrderlist> orderList = list.map((i) => StatusOrderlist.fromJson(i)).toList();

    return StatusOrder(
        ResultOk: parsedJson['ResultOk'],
        ErrorMessage: parsedJson['ErrorMessage'],
        ReturnMessage: parsedJson['ReturnMessage'],
        orderList: orderList
    );
  }
}

class RetStatusInsertOrder{
  String ResultOk;
  String ErrorMessage;
  String ReturnMessage;
  RetStatusInsertOrder ({
    this.ResultOk,
    this.ErrorMessage,
    this.ReturnMessage,
    });
  factory RetStatusInsertOrder.fromJson(Map<String, dynamic> parsedJson){
    return RetStatusInsertOrder(
        ResultOk: parsedJson['ResultOk'],
        ErrorMessage: parsedJson['ErrorMessage'],
        ReturnMessage: parsedJson['ReturnMessage'],
    );
  }
}


class StatusOrderlist{
  String restuarantID;
  String userID;
  String tableID;
  String foodsID;
  String foodsName;
  String qty;
  String price;
  String totalPrice;
  String status;


  StatusOrderlist({
    this.restuarantID,
    this.userID,
    this.tableID,
    this.foodsID,
    this.foodsName,
    this.qty,
    this.price,
    this.totalPrice,
    this.status
  });

  factory  StatusOrderlist.fromJson(Map<String, dynamic> parsedJson){


    return StatusOrderlist(
        restuarantID: parsedJson['restuarantID'],
        userID: parsedJson['userID'],
        tableID: parsedJson['tableID'],
        foodsID: parsedJson['foodsID'],
        foodsName: parsedJson['foodsName'],
        qty: parsedJson['qty'],
        price: parsedJson['price'],
        totalPrice: parsedJson['totalPrice'],
        status: parsedJson['status'],
    );
  }
}