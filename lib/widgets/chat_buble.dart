import 'package:flutter/material.dart';

import '../models/message.dart';
import 'constant.dart';

class ChatBuble extends StatelessWidget {
  const ChatBuble({
    Key? key,
    required this.message,
  }) : super(key: key);
final Message message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.only(left: 20,top: 25,bottom: 25,right: 20),
        margin: EdgeInsets.symmetric(vertical: 8,horizontal: 16),
        decoration: BoxDecoration(
            color: Color(0xffedfddc) ,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(32),
              topRight: Radius.circular(32),
              bottomRight: Radius.circular(32),
            )),
        child: Text(
         message.message,
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
class ChatBubleForFriend extends StatelessWidget {
  const ChatBubleForFriend({
    Key? key,
    required this.message,
  }) : super(key: key);

  final Message message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: EdgeInsets.only(left: 16, top: 32, bottom: 32, right: 32),
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
            bottomLeft: Radius.circular(32),
          ),
          color: Color(0xfffbfbf7),
        ),
        child: Text(
          message.message,
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}