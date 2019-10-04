import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

//import 'package:polygon_clipper/polygon_clipper.dart';
import 'package:online_store/screens/home/CafeLine.dart';
import 'package:online_store/screens/home/CafeLine_Recommend.dart';
import 'package:online_store/screens/barcode/barcode.dart';
import 'package:online_store/screens/map/place.dart';
import 'package:online_store/screens/home/Showdata.dart';
import 'package:online_store/screens/home/status_order.dart';
import 'package:online_store/models/restaurant.dart';
import 'package:online_store/screens/Json/foods.dart';
import 'package:online_store/screens/home/DetailFirstPage.dart';
import 'dart:async' show Future;
import 'package:online_store/screens/home/newOrder2.dart';

void main() => runApp(FirstPage2());

class FirstPage2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyStateful(),
    );
  }
}

class MyStateful extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new MyHomePage();
  }
}

class MyHomePage extends State<MyStateful> with SingleTickerProviderStateMixin {
  var textYellow = Color(0xFFf6c24d);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        textTheme: TextTheme(
            title: TextStyle(
              color: Colors.black,
              fontSize: 20.0,
            )),
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: Colors.white,
        title: Text(
          'eMENU',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      bottomNavigationBar: new BottomAppBar(
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            new IconButton(
                icon: new Icon(Icons.home),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FirstPage2()),
                  );
                }),
            //   new IconButton(icon: new Text('SAVE'), onPressed: null),
            new IconButton(
                icon: new Icon(Icons.center_focus_strong),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Barcode()),
                  );
                }),



            new IconButton(
                icon: new Icon(Icons.list),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => newOrder2()),
                  );
                }),
            new IconButton(
                icon: new Icon(Icons.alarm),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Status_Order()),
                  );
                }),

            new IconButton(
                icon: new Icon(Icons.map),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Mapgoogle()),
                  );
                }),
          ],
        ),
      ),
      body: FutureBuilder<Restaurant>(
        future: NetworkFoods.loadRestaurant(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return new Container(
              child: _listCard(Mrestaurant: snapshot.data),
            );
          } else {}
        },
      ),
    );
  }

  Widget _listCard({Restaurant Mrestaurant}) => ListView.builder(
      itemCount: Mrestaurant.data.length,
      itemBuilder: (context, idx) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(0.0, 2, 0.0, 2),
          child:  Container(
              height: 180.0,
              width: 420.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(Mrestaurant.data[idx].images),
                    fit: BoxFit.cover),
              ),
              child: Stack(
                children: <Widget>[
                  Container(
                    height: 180.0,
                    width: 420.0,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [
                            Colors.black.withOpacity(0.1),
                            Colors.black
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        // Spacer(),
                        Text(
                          '${Mrestaurant.data[idx].restaurantName}',
                          style: TextStyle(
                              color: textYellow,
                              fontWeight: FontWeight.bold,
                              fontSize: 24.0,
                              letterSpacing: 1.1),
                        ),
                        Text(
                          '${Mrestaurant.data[idx].content}',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                              letterSpacing: 1.1),
                        ),
                        Spacer(),

                        ButtonTheme(
                          height: 28,
                          minWidth: 110,
                          child: FlatButton(
                            color: Colors.green,
                            textColor: Colors.white,
                            disabledColor: Colors.grey,
                            disabledTextColor: Colors.black,
                            padding: EdgeInsets.all(5.0),
                            splashColor: Colors.green,
                            shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Cafe_Line(
                                    restaurantID: Mrestaurant
                                        .data[idx].restaurantID,
                                    restaurantName: Mrestaurant
                                        .data[idx].restaurantName,
                                    content:
                                    Mrestaurant.data[idx].content,
                                    description:
                                    Mrestaurant.data[idx].description,
                                    images: Mrestaurant.data[idx].images,
                                  ),
                                ),
                              );
                            },
                            child: Text(
                              "รายละเอียด",
                              style: TextStyle(fontSize: 14.0),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              )),

        );
      });
}
