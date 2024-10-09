import 'package:chat_app/services/firestore_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FeedPage extends StatefulWidget {
  FeedPage({super.key});

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Feed'),
        centerTitle: true,
        backgroundColor:Color.fromRGBO(76, 175, 80, 1),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance.collection('Feedbacks').snapshots(),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Center(child: Text('Erro: ${snapshot.error}'));
                } else {
                  return ListView.separated(
                    separatorBuilder: (context, index) => Divider(),
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Color.fromRGBO(76, 175, 80, 1),
                          child: Text(
                            snapshot.data.docs[index]['username'][0].toUpperCase(),
                            style: TextStyle(color:Color.fromRGBO(76, 175, 80, 1)),
                          ),
                        ),
                        title: Text(snapshot.data.docs[index]['username']),
                        subtitle: Text(snapshot.data.docs[index]['message']),
                      );
                    },
                  );
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: messageController,
                    maxLines: 1,
                    decoration: InputDecoration(
                      hintText: 'Digite sua mensagem...',
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () async {
                    try {
                      await FirestoreService().postFeedback(messageController.text);
                      messageController.clear();
                    } catch (e) {
                      print(e);
                    }
                  },
                  child: Icon(Icons.send),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromRGBO(76, 175, 80, 1),
                    shape: CircleBorder(),
                    padding: EdgeInsets.all(16),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
