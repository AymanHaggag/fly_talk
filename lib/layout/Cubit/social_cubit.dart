import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fly_talk/constants.dart';
import 'package:fly_talk/layout/Cubit/social_states.dart';
import 'package:fly_talk/models/user_model.dart';
import 'package:fly_talk/modules/chat_screen/chat_screen.dart';
import 'package:fly_talk/modules/home_screen/home_screen.dart';
import 'package:fly_talk/modules/login/cubit/user_cubet.dart';
import 'package:fly_talk/modules/settengs_screen/settings_screen.dart';
import 'package:fly_talk/modules/users_screen/users_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit(super.initialState);

  static SocialCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<Widget> screensList = [
    const HomeScreen(),
    const ChatScreen(),
    const UsersScreen(),
    const SettingsScreen()
  ];
  List<String> titleList = [
    "Home",
    "Chats",
    "Users",
    "Settings",
  ];
  void changeBtmNavBar(index) {
    currentIndex = index;
    emit(ChangeBtmNavBarState());
  }

  File? profileImage;
  var picker = ImagePicker();

  Future getProfileImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(SocialGetProfileImageSuccessfulState());
    } else {
      print("No Image Selected");
      emit(SocialGetProfileImageErrorState());
    }
  }

  File? coverImage;
  Future getCoverImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      emit(SocialGetCoverImageSuccessfulState());
    } else {
      print("No Image Selected");
      emit(SocialGetCoverImageErrorState());
    }
  }

  String? profileImageUrl;
  Future<void> uploadProfileImage() async {
    if(profileImage != null){
      await firebase_storage.FirebaseStorage.instance
          .ref()
          .child("users/${Uri.file(profileImage!.path).pathSegments.last}")
          .putFile(profileImage!)
          .then((value) {
        value.ref.getDownloadURL().then((value) {
          profileImageUrl = value;
          print("The url of profile Image >>>>> $value");
          updateProfileImage(image: profileImageUrl as String);
          emit(SocialUploadProfileImageSuccessfulState());
        }).catchError((error) {
          print(error.toString());
          emit(SocialUploadProfileImageErrorState());
        });

      })
          .catchError((error) {
        print(error.toString());
        emit(SocialUploadProfileImageErrorState());
      });
    }

  }

  String? coverImageUrl;
  Future<void> uploadCoverImage() async {
    if(coverImage != null){
      await firebase_storage.FirebaseStorage.instance
          .ref()
          .child("users/${Uri.file(coverImage!.path).pathSegments.last}")
          .putFile(coverImage!)
          .then((value) {
        value.ref.getDownloadURL()
            .then((value) {
          coverImageUrl = value;
          print("The url of cover Image >>>>> $value");
          updateCoverImage(cover: coverImageUrl as String);
          emit(SocialUploadProfileImageSuccessfulState());
        })
            .catchError((error) {
          print(error.toString());
          emit(SocialUploadProfileImageErrorState());
        });
      })
          .catchError((error) {
        print(error.toString());
        emit(SocialUploadProfileImageErrorState());
      });
    }

  }

  Future<void> updateUserData({
    required String name,
    required String bio,
    required String phone,
  }) async {
    emit(SocialUpdateUserLoadingState());
      // UserModel model = UserModel(
      //   name: name,
      //   bio: bio,
      //   phone: phone,
      //   image: profileImageUrl ?? UserCubit.get(context).currentUser!.image,
      //   cover: coverImageUrl ?? UserCubit.get(context).currentUser!.cover,
      //   email: UserCubit.get(context).currentUser!.email,
      //   numberOfFollowers: UserCubit.get(context).currentUser!.numberOfFollowers,
      //   numberOfFollowing: UserCubit.get(context).currentUser!.numberOfFollowing,
      //   numberOfPhotos: UserCubit.get(context).currentUser!.numberOfPhotos,
      //   numberOfPosts: UserCubit.get(context).currentUser!.numberOfPosts,
      //   isVerified: UserCubit.get(context).currentUser!.isVerified,
      //   uId: uId,
      // );

      await FirebaseFirestore.instance
          .collection("users")
          .doc(uId)
          .update(
        {
          "name": name,
          "bio": bio,
          "phone": phone,
        }
      )
          .then((value) {
            print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
        // UserCubit.get(context).getUserData();
        emit(SocialUpdateUserDataSuccessfulState());
      }).catchError((error) {
        print(error.toString());
        emit(SocialUpdateUserDataErrorState());
      });

  }

  Future<void> updateCoverImage ({
    // BuildContext? context,
  required String cover,
})async{
    emit(SocialUpdateUserLoadingState());
    await FirebaseFirestore.instance
        .collection("users")
        .doc(uId)
        .update({
      "cover" :cover
    })
        .then((value) {
      // UserCubit.get(context).getUserData();
      emit(SocialUpdateUserCoverSuccessfulState());
    }).catchError((error) {
      print(error.toString());
      emit(SocialUpdateUserCoverErrorState());
    });

  }

  Future<void> updateProfileImage ({
    required String image,
  })async{
    emit(SocialUpdateUserLoadingState());
    await FirebaseFirestore.instance
        .collection("users")
        .doc(uId)
        .update({
      "image" :image
    })
        .then((value) {
      emit(SocialUpdateUserImageSuccessfulState());
    }).catchError((error) {
      print(error.toString());
      emit(SocialUpdateUserImageErrorState());
    });

  }


}
