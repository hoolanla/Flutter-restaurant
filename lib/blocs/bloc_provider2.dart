import 'package:flutter/material.dart';
import 'package:online_store/blocs/auth.dart';
import 'package:online_store/blocs/cart2.dart';
import 'package:online_store/blocs/products2.dart';

class BlocProvider2 extends InheritedWidget {
 final CartBloc2 cartBloc2 = CartBloc2();
 final ProductsBloc2 productsBloc2 = ProductsBloc2();
 final AuthBloc authBloc = AuthBloc();

 BlocProvider2({Key key, Widget child}) : super(key: key, child: child);

 static BlocProvider2 of(BuildContext context) =>
     context.inheritFromWidgetOfExactType(BlocProvider2) as BlocProvider2;

 @override
 bool updateShouldNotify(InheritedWidget oldWidget) {
  return true;
 }
}
