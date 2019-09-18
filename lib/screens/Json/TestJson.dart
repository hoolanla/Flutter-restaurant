import 'dart:convert' show jsonDecode;
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

final photoJson = """
[
{
"albumId": 1,
"id": 1,
"title": "accusamus beatae ad facilis cum similique qui sunt",
"url": "http://placehold.it/600/92c952",
"thumbnailUrl": "http://placehold.it/150/92c952"
},
{
"albumId": 1,
"id": 2,
"title": "reprehenderit est deserunt velit ipsam",
"url": "http://placehold.it/600/771796",
"thumbnailUrl": "http://placehold.it/150/771796"
},
{
"albumId": 1,
"id": 3,
"title": "officia porro iure quia iusto qui ipsa ut modi",
"url": "http://placehold.it/600/24f355",
"thumbnailUrl": "http://placehold.it/150/24f355"
}
]

""";




const paymentsJson = """
[
{
"ResultOk": true,
"ErrorMessage": "e",
"foodsTypeIDLevel1": "1",
"foodsTypeNameLevel1": "Drink",
"foodsTypeIDLevel2": "1",
"foodsTypeNameLevel2": "Drink",
"count": 3,
"foodsItems":[
        {
          "foodsID": "15",
          "foodsName": "Late-Coffee",
          "price": 45.0,
          "size":"S",
          "description": "Tender and bla...",
          "images": "Foodsabc.png"
         },
        {
          "foodsID": "16",
          "foodsName": "Late-Coffee",
          "price": 70.0,
          "size":"M",
          "description": "Tender and bla...",
          "images": "Foodsabc.png"
         },
        {
          "foodsID": "17",
          "foodsName": "Late-Coffee",
          "price": 90.0,
          "size":"L",
          "description": "Tender and bla...",
          "images": "Foodsabc.png"
         }
        ]
}
]
""";


void main() {

 // _loadFoods();
  _loadPhotoAsset();

}




  class FoodsList {
  final List<Food> foods;
  FoodsList({
    this.foods,
  });

  factory FoodsList.fromJson(List<dynamic> parsedJson) {

    List<Food> _foods = new List<Food>();
    _foods = parsedJson.map((i)=>Food.fromJson(i)).toList();
//print(_foods.length.toString());
    return new FoodsList(
        foods: _foods
    );
  }
}



Future<String> _loadFoods() async {
  return await rootBundle.loadString('assets/Foods.json');
}

Future loadFoods() async {
  String jsonFoods = await _loadFoods();
 // print(jsonFoods);
  final jsonResponse = json.decode(jsonFoods);
  FoodsList _foodsList = FoodsList.fromJson(jsonResponse);
  print("foodssssssssss " + _foodsList.foods[0].price.toString());
}

Future<String> _loadPhotoAsset() async {
  return await rootBundle.loadString('assets/photo.json');
}

Future loadPhotos() async {
  String jsonPhotos = await _loadPhotoAsset();
  final jsonResponse = json.decode(jsonPhotos);
  PhotosList photosList = PhotosList.fromJson(jsonResponse);
  print("photos " + photosList.photos[0].title);
}


class PhotosList {
  final List<Photo> photos;

  PhotosList({
    this.photos,
  });

  factory PhotosList.fromJson(List<dynamic> parsedJson) {

    List<Photo> photos = new List<Photo>();
    photos = parsedJson.map((i)=>Photo.fromJson(i)).toList();

    return new PhotosList(
        photos: photos
    );
  }
}

class Photo{
  final String id;
  final String title;
  final String url;

  Photo({
    this.id,
    this.url,
    this.title
  }) ;

  factory Photo.fromJson(Map<String, dynamic> json){
    return new Photo(
      id: json['id'].toString(),
      title: json['title'],
      url: json['json'],
    );
  }

}



//class Foods {
//
//  String foodsTypeIDLevel1;
//  String foodsTypeIDLevel2;
//  String foodsTypeNameLevel1;
//  String foodsTypeNameLevel2;
//  int count;
//  List<Food> foods;
//
//  Foods.fromJson(String jsonStr) {
//    final _map = jsonDecode(jsonStr);
//    //  this.ResultOk =    _map['ResultOk'];
//    this.count = _map['count'];
//    this.foods = [];
//    final _foodList = _map['foodsItems'];
//
//    for (var i = 0; i < (this.count); i++) {
//      this.foods.add(new Food.fromJson(_foodList[i]));
//    }
//  }
//}





class Food {
  String foodsID;
  String foodsName;
  double price;
  String size;
  String description;
  String images;

  Food({
    this.foodsID,
    this.foodsName,
    this.price,
    this.size,
    this.description,
    this.images
  });


  factory Food.fromJson(Map<String, dynamic> parsedJson){
    return Food(
        foodsID:parsedJson['foodsID'],
        foodsName:parsedJson['foodsName'],
        price: parsedJson['price'],
        size:parsedJson['size'],
        description:parsedJson['description'],
        images:parsedJson['images']
    );
  }

}


class Foods {
  bool ResultOK;
  String ErrorMessage;
  String foodsTypeIDLevel1;
  String foodsTypeNameLevel1;
  String foodsTypeIDLevel2;
  String foodsTypeNameLevel2;
  int count;
  List<Food> foodsItems;

  Foods({
    this.ResultOK,
    this.ErrorMessage,
    this.foodsTypeIDLevel1,
    this.foodsTypeNameLevel1,
    this.foodsTypeIDLevel2,
    this.foodsTypeNameLevel2,
    this.count,
    this.foodsItems
  });

  factory Foods.fromJson(Map<String, dynamic> parsedJson){

    var list = parsedJson['foodsItems'] as List;
  //  print(list.runtimeType);
    List<Food> foodsList = list.map((i) => Food.fromJson(i)).toList();


    return Foods(
        ResultOK:parsedJson['ResultOK'] ,
        ErrorMessage: parsedJson['ErrorMessage'],
        foodsTypeIDLevel1: parsedJson['foodsTypeIDLevel1'],
        foodsTypeNameLevel1: parsedJson['foodsTypeNameLevel1'],
        foodsTypeIDLevel2: parsedJson['foodsTypeIDLevel2'],
        foodsTypeNameLevel2: parsedJson['foodsTypeNameLevel2'],
        count:  parsedJson['count'],
        foodsItems: foodsList
    );
  }
}






//
//
//
//class Food {
//  String foodsID;
//  String foodsName;
//  double price;
//  String size;
//  String description;
//  String images;
//
//  Food.fromJson(Map<String, dynamic> jsonMap) {
//    this.foodsID = jsonMap['resultOk'];
//    this.foodsName = jsonMap['ErrorMessage'];
//    this.price = double.parse(jsonMap['price']);
//    this.size = jsonMap['size'];
//    this.description = jsonMap['description'];
//    this.images = jsonMap['images'];
//  }
//}