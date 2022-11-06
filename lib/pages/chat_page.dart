import 'package:flutter/material.dart';
import 'package:scholar_chat/models/message.dart';
import '../widgets/chat_buble.dart';
import '../widgets/constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class ChatPage extends StatelessWidget {
  static String id = 'ChatPage';
  final _controller = ScrollController();
  // Create a CollectionReference called users that references the firestore collection
  CollectionReference messages =
  FirebaseFirestore.instance.collection(kMessagesCollections);


    TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // to return argument which i send in the login page
    var email  = ModalRoute.of(context)!.settings.arguments ;
    // we using stream builder because we want UI change concurrently
    return StreamBuilder<QuerySnapshot>(
        stream: messages.orderBy(kCreatedAt, descending: true).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Message> messagesList = [];
            for (int i = 0; i < snapshot.data!.docs.length; i++) {
              messagesList.add(Message.fromJson(snapshot.data!.docs[i]));
            }
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: kPrimaryColor,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    kLogo,
                    height: 60,
                  ),
                  Text('Chat'),
                ],
              ),
              centerTitle: true,
            ),
            body: Container(
              color: Color(0xff89ab69),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(

                     reverse: true,
                  controller: _controller,
                  itemCount: messagesList.length,
                  itemBuilder: (context, index) {

                    return messagesList[index].id == email ?
                    ChatBuble(
                      message: messagesList[index],
                    ) : ChatBubleForFriend(
                        message: messagesList[index]);
                  }),
                  ),


                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: TextField(
                      controller: controller,
                      onSubmitted: (data){
                        messages.add(
                          {
                           kMessage:data,
                           kCreatedAt : DateTime.now(),
                            'id' :email,

                        });
                        controller.clear();
                        //making screenListView  scrolling to the end to see the last message i send
                        _controller.animateTo(
                           0,
                            duration: Duration(seconds: 5),
                            curve: Curves.easeIn,);
                      },
                      decoration: InputDecoration(
                        hintText: 'Send Message',
                        suffixIcon: Icon(
                          Icons.send,
                          color: kPrimaryColor,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                            color: kPrimaryColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }else{
          return Text('Loading.....');
        }
        });
  }
}
