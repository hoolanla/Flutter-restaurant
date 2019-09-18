import 'package:flutter/material.dart';
import 'package:online_store/blocs/bloc_provider.dart';
import 'package:online_store/widgets/drawer/menu_item.dart';
import 'package:online_store/screens/login/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:online_store/services/authService.dart';
String imagePath = '';
String displayName = '';


class DrawerLayout extends StatelessWidget  {

  _loadCounter() async {
    AuthService authService = AuthService();
    if(await authService.isLogin()){
      displayName = await authService.getDisplayName();
      imagePath = await authService.getImage();
    }
  }

  _logOut(BuildContext context) async {
    AuthService authService = AuthService();
    await authService.logout();
    Navigator.of(context).pushNamed('/login');
  }

  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of(context).authBloc;

    _loadCounter();

    return new Drawer(
        child: new StreamBuilder(
      stream: authBloc.auth,
      builder: (context, snapshot) {


        Future _showAlertDialog() async {
          SharedPreferences _pref = await SharedPreferences.getInstance();
          showDialog(context: context,
              barrierDismissible: true,
              builder: (context){
                return AlertDialog(
                  title: Text("${_pref.getString(AuthService.DISPLAYNAME)} to logout." ),
                  content: Text("Are you sure?"),
                  actions: <Widget>[
                    FlatButton(
                      onPressed: ()  {
                        AuthService authService = AuthService();
                         authService.logout();
                        Navigator.of(context).pushNamed('/login');;
                      },
                      child: Text("Yes"),
                    ),
                    FlatButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text("No"),
                    )
                  ],
                );
              });
        }

        return Container(
            color: Colors.green,
            child: new Column(
              children: <Widget>[
                new Expanded(
                  child: new Container(
                    padding: EdgeInsets.only(top: 40.0),
                    child: new Column(
                      children: <Widget>[
                        new Container(
                            decoration: new BoxDecoration(
                                color: Colors.transparent,
                                border: new Border.all(
                                    color: Colors.redAccent, width: 2.0),
                                borderRadius: new BorderRadius.circular(100.0)),
                            child: new Container(
                              width: 100.0,
                              height: 100.0,
                              padding: EdgeInsets.all(5.0),
                              child: snapshot.data['isAuth'] == true
                                  ? new CircleAvatar(
                                      backgroundImage: NetworkImage(imagePath),
                                        //  'https://media.licdn.com/dms/image/C4D03AQH7JI67WE1hAw/profile-displayphoto-shrink_100_100/0?e=1544054400&v=beta&t=ymDXIFJA0lOEi2unXPMDDHhb6NlC23B5cXSkH_Wqenw'),
                                    )
                                  : new CircleAvatar(
                                      backgroundImage: NetworkImage(imagePath))
                                          //'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSdI4vX5gRoNdDDDrrSgPxSWBh4LWcu-HMsX87IomFM_o2Xq4iD1Q')),
                            )),

                        snapshot.data['isAuth'] == true ? new Text(
                          snapshot.data['user']['name'],
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                              color: Colors.white),
                        ):
                        FlatButton(
                          child: Text('Welcome ' + displayName,style:
                          TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                              color: Colors.white),
                            ),
                        //  onPressed: (){Navigator.of(context).pushNamed('/login');},
                        )
                        ,
                        snapshot.data['isAuth'] == true ? new Text(
                          snapshot.data['user']['title'],
                          style: TextStyle(color: Colors.white),
                        ):new Container(),
                      ],
                    ),
                  ),
                ),
                new Expanded(
                  flex: 2,
                  child: new Container(
                    color: Colors.white,
                    child: new Column(
                      children: <Widget>[
                     //   snapshot.data['isAuth'] == false ?
                     /*   new MenuItem(
                          title: "Login",
                          icon: Icon(
                            Icons.person,
                            color: Colors.black54,
                          ),
                          onTap: () {
                            Navigator.of(context).pushNamed('/login');
                          },
                        ):*/
                  /*      new MenuItem(
                          title: "Exit",
                          icon: Icon(
                            Icons.exit_to_app,
                            color: Colors.black54,
                          ),
                          onTap: () {
                            authBloc.logout.add('logout');
                          },
                        ),*/
                        new MenuItem(
                          title: "Scan",
                          icon: Icon(
                            Icons.center_focus_strong,
                            color: Colors.black54,
                          ),
                          onTap: () {
                            Navigator.of(context).pushNamed('/barcode');
                          },
                        ),
                        new MenuItem(
                          title: "Map",
                          icon: Icon(
                            Icons.map,
                            color: Colors.black54,
                          ),
                          onTap: () {
                            Navigator.of(context).pushNamed('/map');
                          },
                        ),
                        new MenuItem(
                          title: "Menu",
                          icon: Icon(
                            Icons.home,
                            color: Colors.black54,
                          ),
                          onTap: () {
                            Navigator.of(context).pushNamed('/home');
                          },
                        ),

                        new MenuItem(
                          title: "ViewMenu",
                          icon: Icon(
                            Icons.edit,
                            color: Colors.black54,
                          ),
                          onTap: () {
                            Navigator.of(context).pushNamed('/ViewMenu');
                          },
                        ),

                        new MenuItem(
                          title: "OrderList",
                          icon: Icon(
                            Icons.list,
                            color: Colors.black54,
                          ),
                          onTap: () {
                            Navigator.of(context).pushNamed('/OrderList');
                          },
                        ),

                        new MenuItem(
                          title: "Cart",
                          icon: Icon(
                            Icons.shopping_basket,
                            color: Colors.black54,
                          ),
                          onTap: () {
                            Navigator.of(context).pushNamed('/cart');
                          },
                        ),
                        new MenuItem(
                          title: "Logout",
                          icon: Icon(
                            Icons.exit_to_app,
                            color: Colors.black54,

                          ),

                         onTap: _showAlertDialog,

                        ),
                      ],
                    ),
                  ),
                )
              ],
            ));
      },
    ));
  }
}
