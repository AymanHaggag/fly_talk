import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fly_talk/modules/login/cubit/user_cubet.dart';
import 'package:fly_talk/modules/login/cubit/user_states.dart';

import '../../constants.dart';
import '../../layout/Cubit/social_cubit.dart';
import '../../services/cash_helper.dart';
import '../../widgets/componento.dart';
import '../login/login_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserStates>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold(
          body: Column(
            children: [
              if(FirebaseAuth.instance.currentUser!.emailVerified == false)
                Container(
                  color: Colors.amber.shade200,
                  child: Row(
                    children: [
                      Icon(Icons.info_outline),
                      SizedBox(
                        width: 10,
                      ),
                      Text("Please Verefy Your Mail "),
                      Spacer(),
                      TextButton(
                          onPressed: () {
                            FirebaseAuth.instance.currentUser!
                                .sendEmailVerification()
                                .then((value) {
                              showToast(
                                  "Check Your Email", ToastStates.success);
                              FirebaseFirestore.instance
                                  .collection("users")
                                  .doc(uId).update({"isVerified": true})
                                  .then((value) {
                                print("update successful");
                                UserCubit.get(context).getUserData();
                              })
                                  .catchError((error) {
                                print("Error while update $error");
                              });
                            }).catchError((error) {
                              showToast(error.toString(), ToastStates.error);
                            });
                          },
                          child: Text("Send")),
                    ],
                  ),
                ),
              Center(
                child: TextButton(
                    onPressed: () {
                      CacheHelper.deleteData(key: "uId");
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()),
                              (route) => false);
                    },
                    child: Text("LOG OUT")),
              ),
              Center(
                child: TextButton(
                    onPressed: () {
                      print(FirebaseAuth.instance.currentUser!.emailVerified);
                    },
                    child: Text("TEST")),
              ),
            ],
          ),
        );
      },
    );
  }
}
