import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mcan/chat_message.dart';

class ChatList extends StatefulWidget{
  @override
  State createState() => new ChatListState();
}

class ChatListState extends State<ChatList>{
  @override
  Widget build(BuildContext context){
    return new Scaffold(
      body: StreamBuilder(
        stream: Firestore.instance.collection('connected').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) return CircularProgressIndicator();
          return FirestoreListView(documents: snapshot.data.documents);
        },
      ),
    );
  }
}

class FirestoreListView extends StatelessWidget {
  final List<DocumentSnapshot> documents;
  final homeUser = "test1@mail.com";
  FirestoreListView({this.documents}); 
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: documents.length,
      itemExtent: 90.0,
      itemBuilder: (BuildContext context, int index) {
        if (documents[index].data['user'].toString()==homeUser){
          return SizedBox.shrink();
        }
        String user1 = documents[index].data['user'].toString();
        return ListTile(
          title: Container(
            padding: const EdgeInsets.all(0.0),
            child: Row(
              children: <Widget>[
                Align(
                  alignment: Alignment.topCenter,
                  child: SizedBox(
                    height: 60,
                    width: 370,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(width: 1.0, color: Colors.grey),
                          bottom: BorderSide(width: 1.0, color: Colors.grey),
                        ),
                      ),
                      child: FlatButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ChatMessage(user1: user1, user2: homeUser)),
                          );
                        }, 
                        child: Text(
                          user1,
                          style: TextStyle(fontSize: 22,),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ),
                  ),
                ),
                
              ],
            ),
          ),
        );
      },
    );
  }
}
