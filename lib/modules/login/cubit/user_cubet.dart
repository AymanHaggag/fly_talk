import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fly_talk/models/user_model.dart';
import 'package:fly_talk/modules/login/cubit/user_states.dart';

import '../../../constants.dart';
import '../../../services/cash_helper.dart';

class UserCubit extends Cubit<UserStates> {
  UserCubit(super.initialState);

  static UserCubit get(context) => BlocProvider.of(context);

  bool hidePass = true;
  IconData suffixIcon = Icons.visibility;

  void hidePassword() {
    hidePass = !hidePass;
    suffixIcon = hidePass ? Icons.visibility : Icons.visibility_off;

    emit(UserHidePasswordState());
  }

  UserModel? currentUser;

  void login({
    required String email,
    required String password,
  }) {
    emit(UserLoadingState());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      print(value.user!.email);
      CacheHelper.saveData(key: "uId", value: value.user!.uid);
      emit(UserLoginSuccessfulState());
    }).catchError((error) {
      print(error.toString());
      emit(UserLoginErrorState());
    });
  }

  void signUp({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) {
    emit(UserLoadingState());

    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      createUser(
          name: name,
          email: email,
          uId: value.user!.uid,
          phone: phone,
          isVerified: false,
          cover:
              "https://img.freepik.com/free-vector/watercolor-leaves-falling-background_52683-74651.jpg?w=1060&t=st=1693658651~exp=1693659251~hmac=307e69fec136e24af9752c9282dda86748a073640b3b323c8220378db3ed1fda",
          image:
              "https://ps.w.org/user-avatar-reloaded/assets/icon-256x256.png?rev=2540745",
          numberOfPosts: "0",
          numberOfPhotos: "0",
          numberOfFollowing: "0",
          numberOfFollowers: "0");
      CacheHelper.saveData(key: "uId", value: value.user!.uid);
      print(value.user!.email);
      print(value.user!.displayName);
      emit(UserRegistrationSuccessfulState());
    }).catchError((error) {
      print(error.toString());
      emit(UserRegistrationErrorState());
    });
  }

  void createUser({
    required String name,
    required String email,
    required String uId,
    required String phone,
    bool? isVerified,
    String? image,
    String? cover,
    String? bio,
    String? numberOfPosts,
    String? numberOfPhotos,
    String? numberOfFollowing,
    String? numberOfFollowers,
  }) async {
    currentUser = UserModel(
        name: name, email: email, phone: phone, uId: uId, isVerified: false);

    FirebaseFirestore.instance
        .collection("users")
        .doc(uId)
        .set(currentUser!.toMap())
        .then((value) {
      emit(UserCreateUserSuccessfulState(uId));
    }).catchError((error) {
      print(error.toString());
      emit(UserCreateUserErrorState());
    });
  }

  Future<void> getUserData() async {
    if (uId != null) {
      emit(UserGetUserLoadingState());

      await FirebaseFirestore.instance
          .collection("users")
          .doc(uId)
          .get()
          .then((value) {
        currentUser = UserModel.fromJson(value.data()!);
        print(currentUser!.name);
        print(currentUser!.isVerified);
        emit(UserGetUserSuccessfulState());
      }).catchError((error) {
        print(error.toString());
        emit(UserGetUserErrorState());
      });
    }
  }


}


