import 'dart:convert' show jsonDecode;

final paymentsJson = """

  {"data": {
       "ResultOk":true,
        "ErrorMessage":"",
 
      "foodsTypeIDLevel1": "1",
      "foodsTypeNameLevel1": "Drink",
     "foodsTypeIDLevel2": "1",
      "foodsTypeNameLevel2": "Drink",
      "count": 3,
      "foodsItems":[
        {
          "foodsID": "15",
          "foodsName": "Late-Coffee",
          "price": "45",
          "size":"S",
          "description": "Tender and bla...",
          "images": "Foods/abc.png"
          },
        {
          "foodsID": "16",
          "foodsName": "Late-Coffee",
          "price": "70",
          "size":"M",
          "description": "Tender and bla...",
          "images": "Foods/abc.png"
          },
        {
          "foodsID": "17",
          "foodsName": "Late-Coffee",
          "price": "90",
          "size":"L",
          "description": "Tender and bla...",
          "images": "Foods/abc.png"
          }
        ]
        },
        
         "data": {
       "ResultOk":true,
        "ErrorMessage":"",
 
      "foodsTypeIDLevel1": "1",
      "foodsTypeNameLevel1": "Drink",
     "foodsTypeIDLevel2": "1",
      "foodsTypeNameLevel2": "Drink",
      "count": 3,
      "foodsItems":[
        {
          "foodsID": "15",
          "foodsName": "Late-Coffee",
          "price": "45",
          "size":"S",
          "description": "Tender and bla...",
          "images": "Foods/abc.png"
          },
        {
          "foodsID": "16",
          "foodsName": "Late-Coffee",
          "price": "70",
          "size":"M",
          "description": "Tender and bla...",
          "images": "Foods/abc.png"
          },
        {
          "foodsID": "17",
          "foodsName": "Late-Coffee",
          "price": "90",
          "size":"L",
          "description": "Tender and bla...",
          "images": "Foods/abc.png"
          }
        ]
        }
        }
  

""";
void main() {
//  var ids = jsonDecode(paymentsJson);

 // final pmt = new Foods.fromJson(paymentsJson);
 // print(pmt.foods[1].price);
  //expect(pmt.result, "success");
}

class Data{
  bool ResultOk ;
  String errorMessage;
  List<Foods> datas;
}

class Foods {

  String foodsTypeIDLevel1;
  String foodsTypeIDLevel2;
  String foodsTypeNameLevel1;
  String foodsTypeNameLevel2;
  int count;
  List<Food> foods;

  Foods.fromJson(String jsonStr) {
    final _map = jsonDecode(jsonStr);
  //  this.ResultOk =    _map['ResultOk'];
    this.count = _map['count'];
    this.foods = [];
    final _foodList = _map['foodsItems'];

    for (var i = 0; i < (this.count); i++) {
      this.foods.add(new Food.fromJson(_foodList[i]));
    }
  }
}



class Food {
  String foodsID;
  String foodsName;
  double price;
  String size;
  String description;
  String images;

  Food.fromJson(Map<String, dynamic> jsonMap) {
    this.foodsID = jsonMap['resultOk'];
    this.foodsName = jsonMap['ErrorMessage'];
    this.price = double.parse(jsonMap['price']);
    this.size = jsonMap['size'];
    this.description = jsonMap['description'];
    this.images = jsonMap['images'];
  }
}