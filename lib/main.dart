import 'package:flutter/material.dart';
import 'package:mcan/root_page.dart';
import 'package:mcan/auth.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MCAN Chat',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Flexible(
            child: Hero(
              tag: 'logo',
              child: Container(
                child: Image.network('https://image.freepik.com/free-vector/characters-people-chatting-through-smartphones_53876-43013.jpg'),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "MCAN CHAT APP",
                style: TextStyle(
                  fontSize: 40.0,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 50.0,
          ),
          SizedBox(
            height: 60,
            width: 400,
            child: RaisedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RootPage(auth: new Auth(), login: true)),
                );
              },
              child: Text(
                'Login',
                style: TextStyle(fontSize: 20)
              ),
            ),
          ),
          SizedBox(height: 10),
          SizedBox(
            height: 60,
            width: 400,
            child: RaisedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RootPage(auth: new Auth(), login: false)),
                );
              },
              child: Text(
                'Register',
                style: TextStyle(fontSize: 20)
              ),
            ),
          ),
        ],
      ),
    );
  }
}



