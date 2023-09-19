import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fly_talk/layout/Cubit/social_cubit.dart';
import 'package:fly_talk/layout/Cubit/social_states.dart';
import 'package:fly_talk/modules/login/cubit/user_cubet.dart';

class NewPostScreen extends StatelessWidget {
   NewPostScreen({Key? key}) : super(key: key);

  final TextEditingController postBodyController = TextEditingController();


  @override
  Widget build(BuildContext context) {
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
              title: Text("Create New Post"),
            ),
            body: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  if (state is SocialCreateProfileImageLoadingState ||state is SocialCreatePostLoadingState )
                    LinearProgressIndicator(),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage(
                            UserCubit.get(context).currentUser!.image as String),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text(UserCubit.get(context).currentUser!.name as String,
                          style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15) ,
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: postBodyController,
                      decoration: InputDecoration(
                        hintText: "What is in your mind ..." ,
                        hintStyle: TextStyle(fontSize: 15,fontWeight: FontWeight.w400),
                        border: InputBorder.none
                      ),
                    ),
                  ),
                  if(SocialCubit.get(context).postImage != null)
                   Stack(
                     alignment: Alignment.topRight,
                     children: [
                       Container(
                         height: 300,
                         width: double.infinity,
                         decoration: BoxDecoration(
                           borderRadius: BorderRadius.circular(5),
                           image: DecorationImage(
                             image:  FileImage(SocialCubit.get(context).postImage as File),
                             fit: BoxFit.cover,
                           ),
                         ),
                       ),
                       Padding(
                         padding: const EdgeInsets.all(8.0),
                         child: CircleAvatar(
                           backgroundColor: Colors.grey,
                           child: IconButton(
                             onPressed: () {
                               SocialCubit.get(context).removePostImage();
                             },
                             icon: Icon(
                               Icons.close,
                               color: Colors.white,
                             ),
                           ),
                         ),
                       ),
                     ]
                   ),
                  Row(
                    children: [
                      ElevatedButton(
                          onPressed: (){
                            SocialCubit.get(context).getPostImage();
                            SocialCubit.get(context).uploadPostImage();
                          },
                          child: Icon(Icons.add_a_photo_outlined),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Expanded(
                          child: ElevatedButton(
                              onPressed: () async{
                                if(SocialCubit.get(context).postImage != null){
                                  await SocialCubit.get(context).uploadPostImage();
                                }
                                SocialCubit.get(context).createPost(context: context, postBody: postBodyController.text);
                                SocialCubit.get(context).removePostImage();
                              },
                              child: Text("Post"),
                          ),
                      ),
                    ],
                  ),

                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
