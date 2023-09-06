import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fly_talk/modules/login/cubit/user_cubet.dart';
import 'package:fly_talk/modules/login/cubit/user_states.dart';
import 'package:fly_talk/modules/login/login_screen.dart';
import 'package:fly_talk/modules/new_post_screen/new_post_screen.dart';
import 'package:fly_talk/modules/notifications_screen/notifications_screen.dart';
import 'package:fly_talk/modules/profile_screen/profile_screen.dart';
import 'package:fly_talk/widgets/componento.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../constants.dart';
import '../modules/search_screen/search_screen.dart';
import '../services/cash_helper.dart';
import 'Cubit/social_cubit.dart';
import 'Cubit/social_states.dart';

class SocialLayoutScreen extends StatelessWidget {
  const SocialLayoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SocialCubit(SocialInitialState()),
      child: BlocConsumer<SocialCubit, SocialStates>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return Scaffold(
            floatingActionButton: Container(
              height: 45,
              width: 45,
              decoration: BoxDecoration(
                  color: Colors.green, borderRadius: BorderRadius.circular(200)
                  //more than 50% of width makes circle
                  ),
              child: FloatingActionButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => NewPostScreen()));
                },
                child: FaIcon(
                  FontAwesomeIcons.solidPenToSquare,
                  color: Colors.grey,
                ),
                /*shape:  BeveledRectangleBorder(
                  borderRadius: BorderRadius.circular(10)
              ),*/
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            extendBody: true,
            appBar: AppBar(
              elevation: 5,
              shadowColor: Colors.grey.shade300,
              actions: [
                IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SearchScreen()));
                    },
                    icon: FaIcon(
                      FontAwesomeIcons.magnifyingGlass,
                      color: Colors.grey,
                    )),
                IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => NotificationsScreen()));
                    },
                    icon: FaIcon(
                      FontAwesomeIcons.bell,
                      color: Colors.grey,
                    ))
              ],
              leading:  InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfileScreen()));
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 10,right: 3,top:3 ,bottom: 3),
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(
                      UserCubit.get(context).currentUser!.image as String ,),
                    radius: 20,
                  ),
                ),
              ),
              
              /*IconButton(onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfileScreen()));
              }, icon: FaIcon(
                FontAwesomeIcons.user,
                color: Colors.grey,
              ),),*/
              title: Text(SocialCubit.get(context)
                  .titleList[SocialCubit.get(context).currentIndex]),
            ),
            body: SocialCubit.get(context)
                .screensList[SocialCubit.get(context).currentIndex],
            bottomNavigationBar: BottomAppBar(
              clipBehavior: Clip.antiAlias,
              shape: CircularNotchedRectangle(),
              color: Theme.of(context).primaryColor.withAlpha(0),
              elevation: 0,
              notchMargin: 10,
              child: BottomNavigationBar(
                backgroundColor: Theme.of(context).primaryColor.withAlpha(255),
                selectedItemColor: Theme.of(context).colorScheme.onSurface,
                elevation: 20,
                unselectedFontSize: 10,
                selectedFontSize: 10,
                currentIndex: SocialCubit.get(context).currentIndex,
                onTap: (index) {
                  SocialCubit.get(context).changeBtmNavBar(index);
                },
                selectedLabelStyle: TextStyle(color: Colors.red),
                unselectedLabelStyle: TextStyle(color: Colors.grey),
                items: const [
                  BottomNavigationBarItem(
                      icon: FaIcon(
                        FontAwesomeIcons.house,
                        color: Colors.grey,
                      ),
                      label: "Home"),
                  BottomNavigationBarItem(
                      icon: FaIcon(
                        FontAwesomeIcons.commentDots,
                        color: Colors.grey,
                      ),
                      label: "Chats"),
                  BottomNavigationBarItem(
                      icon: FaIcon(
                        FontAwesomeIcons.usersLine,
                        color: Colors.grey,
                      ),
                      label: "Friends"),
                  BottomNavigationBarItem(
                      icon: FaIcon(
                        FontAwesomeIcons.gears,
                        color: Colors.grey,
                      ),
                      label: "Settings"),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
