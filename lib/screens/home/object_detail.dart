import 'package:flutter/material.dart';

class PhotoPage extends StatefulWidget {
  String foodName;
  String image;
  String description;
  double price;

  PhotoPage({this.foodName, this.image, this.description, this.price});

  @override
  State<StatefulWidget> createState() {
    return _PhotoState(
        foodName: foodName,
        image: image,
        description: description,
        price: price);
  }
}

class _PhotoState extends State<PhotoPage> {
  String foodName;
  String image;
  String description;
  double price;

  _PhotoState({this.foodName, this.image, this.description, this.price});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ffff'),
      ),
      body: Text(image),
    );
  }
}
