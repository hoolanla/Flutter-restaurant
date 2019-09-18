import 'dart:async';
import 'package:online_store/utils/cart.dart';
import 'package:rxdart/rxdart.dart';

class ProductsBloc {
  static final List _productsInstance = [
    {
      "id": 1,
      "title": "Pizza 1",
      "description":
          "Good taste .......",
      "price": 142,
      "rate" : 3.5,
      "thumbnail": "plate1.png"
    },
    {
      "id": 2,
      "title": "Pizza 2",
      "description": "Good taste .......",
      "price": 150,
      "rate" : 3.2,
      "thumbnail": "plate2.png"
    },
    {
      "id": 3,
      "title": "Pizza 3",
      "description": "Good taste .......",
      "price": 140,
      "rate" : 4.0,
      "thumbnail": "plate3.png"
    },
    {
      "id": 4,
      "title": "Pizza 4",
      "description": "Good taste .......",
      "price": 145,
      "rate" : 2.0,
      "thumbnail": "plate4.png"
    }
  ];

  final _products = new BehaviorSubject<List>(seedValue: _productsInstance);

  Stream<List> get products => _products.stream;

  ProductsBloc() {
    // _additionController.stream.listen(onAdd);
  }
}
