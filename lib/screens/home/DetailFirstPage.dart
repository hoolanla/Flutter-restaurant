import 'package:flutter/material.dart';
import 'package:online_store/screens/home/FirstPage2.dart';
import 'package:online_store/screens/home/CafeLine2.dart';
import 'package:online_store/models/foods.dart';
import 'package:online_store/screens/Json/foods.dart';

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

                     FutureBuilder<Menu>(
                        future: NetworkFoods.loadFoodsAsset(RestaurantID: widget.restaurantID,Recommend: '0'),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return new Container(
                              child: _ListSection(menu: snapshot.data),
                            );
                          } else if (snapshot.hasError) {
                            return Text("${snapshot.error}");
                          }

                          return CircularProgressIndicator();
                        }),
                  ],
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget _ListSection({Menu menu}) => ListView.builder(
    itemBuilder: (context, int idx) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 16.0),
        child: Column(
          children: <Widget>[
            Container(
              child: new ListTile(
                leading: Text(menu.data[idx].foodsTypeNameLevel2,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold)),

                // title: Text(menu.data[idx].foodsTypeNameLevel2),
                trailing: Text(
                  'ทั้งหมด (${menu.data[idx].foodsItems.length})',
                  style: TextStyle(
                      color: Colors.green,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            ListView.builder(
              itemBuilder: (context, index) {
                /*    detailFoods.add(detailFood(
                        menu.data[idx].foodsList[index].foodsID,
                        menu.data[idx].foodsList[index].foodsName,
                        menu.data[idx].foodsList[index].price,
                        menu.data[idx].foodsList[index].size,
                        menu.data[idx].foodsList[index].description,
                        menu.data[idx].foodsList[index].images));

                    print(
                        "${idx}  ${detailFoods[index].foodsName}   ${detailFoods.length.toString()}");*/

                return Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8.0,
                  ),
                  child: ListTile(
                    leading: Container(
                      height: 50,
                      width: 50,
                      child: ClipOval(
                        child: Image.network(
                          menu.data[idx].foodsItems[index].images,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    title: Text(menu.data[idx].foodsItems[index].foodName),
                    subtitle: Text(
                      menu.data[idx].foodsItems[index].price.toString(),
                    ),
                    onTap: () {
                      setState(() {});
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CafeLine2(
                            foodsID:
                            menu.data[idx].foodsItems[index].foodID,
                            foodName: menu
                                .data[idx].foodsItems[index].foodName,
                            price:
                            menu.data[idx].foodsItems[index].price,
                            priceS:
                            menu.data[idx].foodsItems[index].priceS,
                            priceM:
                            menu.data[idx].foodsItems[index].priceM,
                            priceL:
                            menu.data[idx].foodsItems[index].priceL,
                            size: "size",
                            description: menu.data[idx]
                                .foodsItems[index].description,
                            image:
                            menu.data[idx].foodsItems[index].images,
                            foodType: menu.data[idx].foodsTypeIDLevel2,
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
              itemCount: menu.data[idx].foodsItems.length,
              shrinkWrap: true,
              // todo comment this out and check the result
              physics:
              ClampingScrollPhysics(), // todo comment this out and check the result
            )
          ],
        ),
      );
    },
    itemCount: menu.data.length,
  );


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
