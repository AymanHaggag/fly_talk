import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fly_talk/layout/Cubit/social_cubit.dart';
import 'package:fly_talk/layout/Cubit/social_states.dart';
import 'package:fly_talk/models/message_model.dart';
import 'package:fly_talk/models/user_model.dart';
import 'package:intl/intl.dart';




import '../../constants.dart';
import '../../widgets/message.dart';

class ChatDetailScreen extends StatelessWidget {

  UserModel? userModel;

  ChatDetailScreen({super.key, this.userModel});

  final TextEditingController messageController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        SocialCubit.get(context).getMessages(receiverId: userModel!.uId as String);
        return BlocConsumer<SocialCubit, SocialStates>(
  listener: (context, state) {
        // TODO: implement listener
  },
  builder: (context, state) {
        return GestureDetector(
          onTap: (){
            FocusScope.of(context).unfocus();
          },
          child: Scaffold(
            appBar: AppBar(
              titleSpacing: 0,
              title: Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage(userModel!.image as String),

                  ),
                  SizedBox(width: 5,),
                  Text(userModel!.name as String)

                ],
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  ConditionalBuilder(
                      condition: SocialCubit.get(context).messages.isNotEmpty,
                      builder: (context) =>Expanded(
                        child: ListView.separated(
                            itemBuilder: (context , index){

                              // List<MessageModel> reversedMessagesList = SocialCubit.get(context).messages.reversed;

                              var message = SocialCubit.get(context).messages[index];


                              if(uId == SocialCubit.get(context).messages[index].senderId )
                                return senderMassageBuilder(messageModel: message);

                              return receiverMassageBuilder(messageModel: message);
                            },
                            separatorBuilder: (context , index) => SizedBox(height: 5,),
                            itemCount: SocialCubit.get(context).messages.length
                        ),
                      ),
                      fallback: (context) => Expanded(child: Container(child: Center(child: Text("Start A Conversation Now!"),))),
                  ),
                  Container(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7),
                        border: Border.all(
                          color: Colors.grey.shade400,
                          width: 1,
                        )
                    ),
                    child: Row(
                      children: [
                        SizedBox(width: 5,),
                        Expanded(
                          child: TextFormField(
                            controller: messageController,
                            keyboardType: TextInputType.text,
                            enabled: true,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Aa",

                            ),
                          ),
                        ),
                        Container(
                          height: 50,
                          child: MaterialButton(
                            onPressed:(){
                              SocialCubit.get(context).sendMessage(
                                receiverId: userModel!.uId as String,
                                dateTime: DateFormat.Hms().format(DateTime.now()),
                                message: messageController.text,
                              );
                              messageController.clear();
                            },
                            child: Icon(Icons.send,color: Colors.white,) ,
                            color: Colors.lightBlue.shade300,
                            minWidth: 1,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),

          ),
        );
  },
);
      }
    );
  }









}




