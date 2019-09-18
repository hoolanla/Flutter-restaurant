import 'package:flutter/material.dart';
import 'package:online_store/screens/home/cart_bloc.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {

  String foodName;
  String image;
  String description;
  double price;
  CartPage({this.foodName, this.image, this.description, this.price});

  @override
  Widget build(BuildContext context) {
    int mainTotal = 0;
    var bloc = Provider.of<CartBloc>(context);
    var cart = bloc.cart;
    return Scaffold(
      appBar: AppBar(
        title: Text("Cart"),
      ),
      body: ListView.builder(
        itemCount: cart.length,
        itemBuilder: (context, index) {
          int giftIndex = cart.keys.toList()[index];
          int count = cart[giftIndex];
          int total = 50 * count;
          int price = 50;
          mainTotal = total ;
          print(mainTotal);
          return ListTile(
            leading: Container(
              width: 50,
              height: 50,
              child:ClipOval(
                child: Image.network(image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            title: Text(    '[$price]       $count  แก้ว     Total: $total'),


            trailing: Icon(Icons.delete,),
            onTap: () { bloc.clear(giftIndex);},


//            trailing: RaisedButton(
//              child: Text('Clear'),
//              color: Theme.of(context).buttonColor,
//              elevation: 1.0,
//              splashColor: Colors.blueGrey,
//              onPressed: () {
//                bloc.clear(giftIndex);
//              },
//            ),
          );
        },
      ),


      floatingActionButton: FloatingActionButton.extended(
        elevation: 4.0,
        //  icon: const Icon(Icons.add),
        label:  _ShowTotal(tot: mainTotal ),
        onPressed: () {},
      ),
      floatingActionButtonLocation:
      FloatingActionButtonLocation.centerDocked,



    );
  }
}

Widget _ShowTotal({int tot}) {

//  setState(() {
//    tot++;
//  });


}

