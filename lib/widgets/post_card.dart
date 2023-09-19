import 'package:flutter/material.dart';
import 'package:fly_talk/layout/Cubit/social_cubit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Widget? postCard ({
  required int index,
  required context,
  required String name,
  required String profileImage,
  required String dateTime,
  required String postBody,
  required String postImage,
  required int numberOfLikes,
  required int numberOfComments,
} ){
  return Container(
    decoration: BoxDecoration(
      boxShadow: [
        // BoxShadow(
        //   color: Colors.grey, // Shadow color
        //   blurRadius: 5.0,   // Spread radius
        //   offset: Offset(0, 3), // Offset in the x and y direction
        // ),
        // BoxShadow(
        //   color: Colors.black.withOpacity(0.6),
        //   offset: Offset(
        //     0.0,
        //     10.0,
        //   ),
        //   blurRadius: 10.0,
        //   spreadRadius: -6.0,
        // ),
      ],
    ),
    child: Card(
      // clipBehavior: Clip.antiAliasWithSaveLayer,
      // elevation: 5.0,
      // margin: EdgeInsets.all(
      //   8.0,
      // ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundImage: NetworkImage(
                      postImage),
                ),
                SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            name,
                            style: TextStyle(fontSize: 15),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Icon(
                            Icons.verified,
                            color: Colors.blue,
                            size: 15,
                          )
                        ],
                      ),
                      Text(
                        dateTime,
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.black.withOpacity(.7)),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.more_horiz),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Container(
                height: 1,
                color: Colors.grey,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
                width: MediaQuery.of(context).size.width,
                child: Text(
                    postBody),
            ),
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                image: DecorationImage(
                  image: NetworkImage(
                    postImage,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                InkWell(
                  onTap: (){
                    SocialCubit.get(context).likePost(SocialCubit.get(context).likesIdList[index]);
                    SocialCubit.get(context).getPosts();
                  },
                  child: Row(children: [
                    FaIcon(FontAwesomeIcons.heart,color: Colors.red,size: 20,),
                    SizedBox(width: 5,),
                    Text("${SocialCubit.get(context).likesList[index]}")
                  ],),
                ),
                Spacer(),
                InkWell(
                  onTap: (){},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      FaIcon(FontAwesomeIcons.comment,color: Colors.amber,size: 20),
                      SizedBox(width: 5,),
                      Text("150 comment"),
                    ],),
                ),
              ],),
            SizedBox(
              height: 10,
            ),
            Row(children: [
              CircleAvatar(
                radius: 25,
                backgroundImage: NetworkImage(
                    profileImage),
              ),
              SizedBox(width: 8,),
              Text("Write a comment...")
            ],),
          ],
        ),
      ),
    ),
  ) ;
}
