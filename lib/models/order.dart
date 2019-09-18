class Order{
  int foodsID;
  String foodsName;
  double price;
  String size;
  String description;
  String images;
  int qty;
  double totalPrice;


  Order(
      this.foodsID,
      this.foodsName,
      this.price,
      this.size,
      this.description,
      this.images,
      this.qty,
      this.totalPrice
      );

  Map<String, dynamic> toMap()
  {
    var map= <String,dynamic>{
      'foodsid' : foodsID,
      'foodsname': foodsName,
      'price' : price,
      'size': size,
      'description' : description,
      'images' : images,
      'qty': qty,
      'totalprice': totalPrice,
    };
    return map;
  }


  Order.fromMap(Map<String,dynamic> map){
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