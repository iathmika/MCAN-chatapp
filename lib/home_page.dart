import 'package:flutter/material.dart';
import 'package:mcan/auth.dart';
import 'package:mcan/chat_list.dart';


class HomePage extends StatelessWidget {
  HomePage({this.auth, this.onSignOut});
  final BaseAuth auth;
  final VoidCallback onSignOut;

  @override
  Widget build(BuildContext context) {

    void _signOut() async {
      try {
        await auth.signOut();
        onSignOut();
      } catch (e) {
        print(e);
      }
    }

    return new Scaffold(
      appBar: new AppBar(
        leading: Builder(
          builder: (BuildContext context){
            return IconButton(
              icon: Icon(Icons.search),
              onPressed: () {

              },
            );
          }
        ),
        title: Text("MCAN Chat App"),
        automaticallyImplyLeading: false,
        actions: <Widget>[
          new FlatButton(
              onPressed: _signOut,
              child: new Text('Logout', style: new TextStyle(fontSize: 17.0, color: Colors.white))
          ),
        ],
      ),
      body: new ChatList()
    );
  }
}

