import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fly_talk/models/user_model.dart';
import 'package:fly_talk/modules/edit_screen/edit_screen.dart';
import 'package:fly_talk/modules/login/cubit/user_cubet.dart';
import 'package:fly_talk/modules/login/cubit/user_states.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserStates>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return BlocConsumer<UserCubit, UserStates>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            var currentUserData = UserCubit.get(context).currentUser;
            return Scaffold(
              appBar: AppBar(
                title: Text("Profile"),
              ),
              body: Column(
                children: [
                  Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(5),
                            topRight: Radius.circular(5))),
                    elevation: 0,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Container(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      height: 300,
                      width: double.infinity,
                      child: Stack(
                          alignment: AlignmentDirectional.bottomCenter,
                          children: [
                            Align(
                              alignment: AlignmentDirectional.topCenter,
                              child: Image(
                                height: 220,
                                width: double.infinity,
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                  currentUserData!.cover as String,
                                ),
                              ),
                            ),
                            CircleAvatar(
                              radius: 77,
                              backgroundColor:
                                  Theme.of(context).scaffoldBackgroundColor,
                              child: CircleAvatar(
                                radius: 75,
                                backgroundImage: NetworkImage(
                                    currentUserData!.image as String),
                              ),
                            ),
                          ]),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              currentUserData!.name as String,
                              style: TextStyle(fontSize: 15),
                            ),
                            Icon(
                              Icons.verified,
                              color: Colors.blue,
                              size: 15,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          currentUserData!.bio as String,
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.black.withOpacity(.7)),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  Text(
                                      currentUserData!.numberOfPosts as String),
                                  Text("post"),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  Text(currentUserData!.numberOfPhotos
                                      as String),
                                  Text("Photo"),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  Text(currentUserData!.numberOfFollowing
                                      as String),
                                  Text("Following"),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  Text(currentUserData!.numberOfFollowers
                                      as String),
                                  Text("Followers"),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: OutlinedButton(
                                  onPressed: () {
                                    print(currentUserData.image);
                                  },
                                  child: Text("Add Post")),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            OutlinedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    PageRouteBuilder(pageBuilder: (context, animation, secondaryAnimation)
                                    {
                                      return EditScreen();
                                      },
                                        transitionsBuilder: (context, animation,
                                        secondaryAnimation, child)
                                    {
                                      return FadeTransition(
                                        opacity: animation,
                                        child: child,
                                      );
                                    }),
                                  );
                                },
                                child: Icon(Icons.edit)),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }
}
