import 'package:flutter/material.dart';
import 'package:online_store/blocs/cart.dart';
import 'package:online_store/widgets/rate_star.dart';
import 'package:online_store/utils/jalali.dart';
import 'package:online_store/blocs/bloc_provider.dart';

class ProductCard extends StatefulWidget {
  final data;
  final VoidCallback onTap;

  ProductCard(this.data, this.onTap);

  @override
  ProductCardState createState() => new ProductCardState();
}

class ProductCardState extends State<ProductCard> {
  //void _onPressed(data) {
//    PersianDate date = new PersianDate.now();
  //   print(date.toString());
//  }

  @override
  Widget build(BuildContext ctx) {
    var data = widget.data;
    var _productImage = new Image.asset('assets/images/' + data['thumbnail']);
    var heroImage = new Hero(
      tag: 'hero-tag-' + data['id'].toString(),
      child: _productImage,
    );

    CartBloc cartBloc = BlocProvider.of(context).cartBloc;

    // Wrong: cartBloc = new CartBloc()
    Color _iconColor = Colors.blue;

    bool isPressed = true;
    return Stack(
      alignment: const Alignment(0.6, 0.6),
      children: [
        Container(
          child: Card(
            elevation: 3.0,
            child: Padding(
                padding: EdgeInsets.all(15.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(),
                    ),
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          data['title'],
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                          ),
                        ),
                        Text(data['description']),
                        StarRating(
                          rating: data['rate'],
                          onRatingChanged: (double rate) {
                            print(rate);
                          },
                        ),
                        Padding(
                            padding: EdgeInsets.only(top: 20.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  data['price'].toString() + " B",
                                ),
                                IconButton(
                                  tooltip: 'Like this.!',
                                  icon: Icon(Icons.thumb_up,
                                      color: isPressed
                                          ? Colors.grey
                                          : Colors.blue),
                                  iconSize: 25.0,
                                  onPressed: () {
                                    setState(() {
                                      isPressed = !isPressed;
                                    });
                                  },
                                ),
                                IconButton(
                                  tooltip: 'Add to cart.',
                                  icon: Icon(
                                    Icons.add_circle,
                                    color: Colors.green,
                                  ),
                                  iconSize: 25.0,
                                  onPressed: () {
                                    cartBloc.addition.add(data);
                                  },
                                ),
                              ],
                            ))
                      ],
                    ))
                  ],
                )),
          ),
        ),
        Container(
            child: new Row(
          children: <Widget>[
            Expanded(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(
                        top: 10.0, left: 10.0, right: 10.0, bottom: 30.0),
                    child: InkWell(
                      onTap: widget.onTap,
                      child: heroImage,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(),
            )
          ],
        )),
      ],
    );
  }
}
