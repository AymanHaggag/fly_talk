import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fly_talk/layout/Cubit/social_states.dart';
import 'package:fly_talk/modules/chat_screen/chat_details.dart';
import 'package:fly_talk/modules/login/cubit/user_cubet.dart';

import '../../layout/Cubit/social_cubit.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
  listener: (context, state) {
    // TODO: implement listener
  },
  builder: (context, state) {
    return Scaffold(
      body: ListView.separated(
        physics: BouncingScrollPhysics(),
          itemBuilder: (context,index) => buildChatUnit(
            index: index,
              name: SocialCubit.get(context).allUsersList[index].name as String,
              image: SocialCubit.get(context).allUsersList[index].image as String,
              dateTime: "12:45 pm",
              message: "Hello darling",
              context: context,
          ),
          separatorBuilder: (context,index) =>SizedBox(height: 0,),
          itemCount: SocialCubit.get(context).allUsersList.length)
    );
  },
);
  }

  Widget buildChatUnit(
  {
    required int index,
    required context,
  required String name,
  required String image,
  required String dateTime,
  required String message,
}
      )=> Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: InkWell(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> ChatDetailScreen(userModel: SocialCubit.get(context).allUsersList[index],)));
          },
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundImage: NetworkImage(
                        image),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 150,
                            height: 25,
                            child: Text(
                              name,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: TextStyle(fontSize: 15),
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Icon(
                            Icons.verified,
                            color: Colors.blue,
                            size: 15,
                          ),
                          SizedBox(width: 70,),
                          Text(
                            dateTime,
                            style: TextStyle(
                                fontSize: 12,
                                color: Colors.black.withOpacity(.7)),
                          ),

                        ],
                      ),
                      SizedBox(height: 3,),
                      Text(message)
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}
