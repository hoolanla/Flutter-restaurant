import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:online_store/screens/home/home.dart';
import 'package:online_store/screens/home/Cart_page.dart';
import 'package:online_store/screens/home/cart_bloc.dart';
import 'package:provider/provider.dart';

class foodDetail extends StatelessWidget {
  String image;
  String description;

  foodDetail({this.image, this.description});

  @override
  Widget build(BuildContext context) {




    return Scaffold(
        appBar: AppBar(
          title: Text('Food Detail'),
          actions: <Widget>[
            new Padding(
              padding: const EdgeInsets.all(10.0),
              child: new Container(
                  height: 150.0,
                  width: 30.0,
                  child: new GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CartPage(),
                        ),
                      );
                    },
                    child: new Stack(
                      children: <Widget>[
                        new IconButton(
                          icon: new Icon(
                            Icons.shopping_cart,
                            color: Colors.green,
                          ),
                          onPressed: null,
                        ),
                        new Positioned(
                            child: new Stack(
                              children: <Widget>[
                                new Icon(Icons.brightness_1,
                                    size: 20.0, color: Colors.red[700]),
                                new Positioned(
                                    top: 3.0,
                                    right: 7,
                                    child: new Center(
                                      child: new Text(
                                        '1',
                                        style: new TextStyle(
                                            color: Colors.white,
                                            fontSize: 12.0,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    )),
                              ],
                            )),
                      ],
                    ),
                  )),
            )
          ],
        ),
        body: Card(
          child: Column(
            children: <Widget>[
              _headerSectionCard(),
              _Body(),
              _detailCafe(),
              //  _headerFooter(),
            ],
          ),
        ));
  }

  Widget _headerSectionCard() => ListTile(
    leading: Container(
      width: 50,
      height: 50,
      child: ClipOval(
        child: Image.network(
          image,
          fit: BoxFit.cover,
        ),
      ),
    ),
    title: Text("กาแฟร้อน"),
    subtitle: Text(''),
  );

  Widget _Body() => new GestureDetector(
      onTap: () {
        // bloc.addToCart(0);
      },
      child: new Container(
        width: 500.0,
        height: 300.0,
        padding: new EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
        color: Colors.white,
        child: new Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,  // add
            children: [
              new Image.network(
                image,
                height: 250,
                fit: BoxFit.fill,
              ),
            ]),
      ));

  Widget headerBody() => Padding(
    padding: new EdgeInsets.all(8.0),
    child: Image.network(image),
  );

  Widget _detailCafe() => Padding(
    padding: new EdgeInsets.all(8.0),
    child: new Text(description),
  );
}
