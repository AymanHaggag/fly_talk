import 'package:flutter/material.dart';
import 'package:fly_talk/models/message_model.dart';

Widget senderMassageBuilder ({
  required MessageModel messageModel
})=>  Row(
  children: [
    Spacer(),
    Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.only(
          topLeft: Radius.circular(5),
          topRight: Radius.circular(0),
          bottomLeft: Radius.circular(5),
          bottomRight: Radius.circular(5)),
        color: Colors.lightBlue.shade200,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
        child: Text(messageModel.message as String,style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),
      ),
    ),
  ],
);



Widget receiverMassageBuilder ({
  required MessageModel messageModel
})=>  Row(
  children: [
    Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.only(
          topLeft: Radius.circular(0),
          topRight: Radius.circular(5),
          bottomLeft: Radius.circular(5),
          bottomRight: Radius.circular(5)),
          color: Colors.grey.shade300
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
        child: Text(messageModel.message as String,style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),
      ),
    ),
  ],
);