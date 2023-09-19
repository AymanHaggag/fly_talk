import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fly_talk/layout/Cubit/social_cubit.dart';
import 'package:fly_talk/layout/Cubit/social_states.dart';
import 'package:fly_talk/models/post_model.dart';
import 'package:fly_talk/modules/login/cubit/user_cubet.dart';
import 'package:fly_talk/modules/login/cubit/user_states.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:line_icons/line_icons.dart';

import '../../widgets/post_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
  listener: (context, state) {
    // TODO: implement listener
  },
  builder: (context, state) {
    List<PostModel> postList = SocialCubit.get(context).postsList;
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              elevation: 10,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child:
                  Stack(alignment: AlignmentDirectional.bottomCenter, children: [
                Image(
                  image: NetworkImage(
                    "https://img.freepik.com/free-photo/indoor-photo-satisfied-teenage-girl-texts-cellular-reads-interesting-article-online-wears-casual-outfit-creats-new-publication-own-web-page-isolated-brown-wall-with-free-space_273609-26359.jpg?w=1060&t=st=1693541879~exp=1693542479~hmac=ba02e3e0dec115a2a1b073f41c9ca55892cfcacc87ea59a17b44a0cb05c69d52",
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Text(
                    "Communicate with your friends Now",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                )
              ]),
            ),
            ConditionalBuilder(
                condition: postList.isNotEmpty || state !is SocialGetPostsLoadingState || state !is UserGetUserLoadingState,
                builder: (context) => ListView.separated(
    shrinkWrap: true,
    physics: NeverScrollableScrollPhysics(),
    itemBuilder: (context ,index) => postCard(
    context: context,
    name: UserCubit.get(context).currentUser!.name as String,
    profileImage: UserCubit.get(context).currentUser!.image as String,
    dateTime: postList[index].dateTime ?? "null value" ,
    postBody: postList[index].postBody ?? "null value",
    postImage: postList[index].postImage ?? "null value",
    numberOfLikes: 0,
    numberOfComments: 0,
        index: index
    ),
    separatorBuilder: (context ,index) => SizedBox(height: 10,),
    itemCount: postList.length) ,
                fallback: (context) => Center(child: Text("No Posts To Show"),)),

           
          ],
        ),
      ),
    ));
  },
);
  }
}





