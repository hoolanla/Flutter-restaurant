import 'package:flutter/material.dart';
import 'package:online_store/screens/home/FirstPage2.dart';

void main() => runApp(DetailFirstPage());

class DetailFirstPage extends StatelessWidget {
  final String restaurantID;
  final String restaurantName;
  final String content;
  final String description;
  final String images;

  DetailFirstPage(
      {this.restaurantID,
        this.restaurantName,
        this.content,
        this.description,
        this.images});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(
        restaurantID: restaurantID,
        restaurantName: restaurantName,
        content: content,
        description: description,
        images: images,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String restaurantID;
  final String restaurantName;
  final String content;
  final String description;
  final String images;

  MyHomePage(
      {this.restaurantID,
        this.restaurantName,
        this.content,
        this.description,
        this.images});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {




    return Scaffold(

      appBar: AppBar(
        title: Text(widget.restaurantName,style: TextStyle(color: Colors.black),),
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black45,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => FirstPage2()),
            );
          },
        ),

        /*    actions: <Widget>[
          new Padding(
            padding: const EdgeInsets.all(10.0),
            child: new Container(
              height: 150.0,
              width: 30.0,
              child: new GestureDetector(
                onTap: () {},
                child: new Stack(
                  children: <Widget>[
                    new IconButton(
                      icon: new Icon(
                        Icons.shopping_cart,
                        color: Colors.white,
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
                                '111',
                                style: new TextStyle(
                                    color: Colors.white,
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],*/
      ),
      body: GridView.count(
        crossAxisCount: 1,
        children: List.generate(1, (index) {
          return GestureDetector(
            onTap: () {},
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    _header(images: widget.images),
                    SizedBox(height: 16),
                    _content(content: widget.content),
                    SizedBox(
                      height: 16,
                    ),
                    _detailCafe(description: widget.description),
                  ],
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}

Widget _content({String content}) => Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: <Widget>[
    new Text(
      '${content}                                           ',
      style: TextStyle(fontSize: 18.0, color: Colors.black),
    ),
  ],
);

Widget _detailCafe({String description}) => Padding(
  padding: new EdgeInsets.all(3.5),
  child: new Text(description),
);

Widget _header({String images}) => Padding(
  padding: new EdgeInsets.all(2.0),
  child: Image.network(images, width: 360, height: 250, fit: BoxFit.cover),
);
