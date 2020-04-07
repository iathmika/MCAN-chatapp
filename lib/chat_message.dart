import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatMessage extends StatefulWidget{
  var documentId = "";
  var user1;
  var user2;

  ChatMessage({Key key, this.user1, this.user2}): super(key: key);
  @override
  State createState() => new ChatMessageState(user1, user2);
}

class ChatMessageState extends State<ChatMessage>{
  final homeUser = "test1@mail.com";
  var user1;
  var user2;
  var documentId = "";
  final TextEditingController _textController = new TextEditingController();
  ChatMessageState(String user1, String user2){
    this.user1 = user1;
    this.user2 = user2;
    if (user2.compareTo(user1)>0){
      documentId = user1+user2; 
    }
    else if (user1.compareTo(user2)>0){
      documentId = user2+user1;
    }
  }
  void _handleSubmitted(String text){
    _textController.clear();
    if (text != null && text != "")
    {setState(() {
      Firestore.instance.collection('chat_message').document(documentId).collection('messages').add({
              'msg': text,
              'recevier': user1 == homeUser?user2:user1,
              'sender': homeUser,
              'time': new DateTime.now()
            });
    });}
  }
  @override
  Widget build(BuildContext context){
    return new Scaffold(
      appBar: AppBar(
        title: Text(user1 == homeUser?user2:user1),
      ),
      body: StreamBuilder(
        stream: Firestore.instance.collection('chat_message').document(documentId).collection('messages').orderBy('time', descending: false).snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.data.documents.isEmpty){
            Firestore.instance.collection('chat_message').document(documentId).setData({
              'msg': 'Hello user',
            });
            Firestore.instance.collection('chat_message').document(documentId).collection('messages').add({
              'msg': ' ',
              'recevier': user1 == homeUser?user2:user1,
              'sender': homeUser,
              'time': new DateTime.now()
            });
          }
          return Container(
            padding: EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                Expanded(
                  child: FirestoreListView(documents: snapshot.data.documents),
                ),
                Row(children: <Widget>[
                  new Flexible(
                    child: new TextField(
                      decoration: new InputDecoration.collapsed(hintText: "Send a message",),
                      controller: _textController,
                      onSubmitted: _handleSubmitted,
                    ),
                  ),
                  new Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: new IconButton(
                      icon: new Icon(Icons.send),
                      onPressed: ()=> _handleSubmitted(_textController.text),
                    ),
                  )
                ],)
              ],
            ),
          );
        },
      ),
    );
  }
}

class FirestoreListView extends StatelessWidget {
  final homeUser = "test1@mail.com";
  final List<DocumentSnapshot> documents;
  FirestoreListView({this.documents}); 
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: documents.length,
      itemBuilder: (BuildContext context, int index) {
        String msg = documents[index].data['msg'].toString();
        String time = documents[index].data['time'].toDate().toString();
        String sender = documents[index].data['sender'].toString();
        return ListTile(
          title: Container(
            padding: const EdgeInsets.all(5.0),
            child: Wrap(
              children: <Widget>[
                Align(
                  alignment: sender == homeUser?Alignment.centerRight:Alignment.centerLeft,
                  child: SizedBox(
                    width: 320.0,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: sender == homeUser?Colors.blue[100]:Colors.grey[300],
                        border: Border.all(color: sender == homeUser?Colors.blue[300]:Colors.grey[500],),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: new Tooltip(
                        message: time, 
                        child: new Text(
                          msg,
                          style: TextStyle(fontSize: 21.0,),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox.shrink(),
              ],
            ),
          ),
        );
      },
    );
  }
}
