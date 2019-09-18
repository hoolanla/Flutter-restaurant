import 'package:flutter/material.dart';
import 'package:online_store/blocs/bloc_provider2.dart';
import 'package:online_store/widgets/product_card_1.dart';
import 'package:online_store/screens/product/product2.dart';

class ViewList2 extends StatefulWidget {
  @override
  ViewListState2 createState() => new ViewListState2();
}

class ViewListState2 extends State<ViewList2> {
  @override
  void initState() {
    super.initState();
  }

  void onTap(data) {
    Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (BuildContext ctx) => new  ProductPage2(data)));
  }

  @override
  Widget build(BuildContext context) {

    final productsBloc = BlocProvider2.of(context).productsBloc2;
print("ffff" + productsBloc.toString());
    return new StreamBuilder(

      stream:  productsBloc.products2,
      builder: (context,sh) {
        return new ListView.builder(
          itemCount: sh.data == null ? 0 : sh.data.length,
          itemBuilder: (BuildContext context, int index) {
         //   return new ProductCard(
           //     sh.data[index], () => onTap(sh.data[index]));
          },
        );
      },
    );
  }
}
