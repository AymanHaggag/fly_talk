import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fly_talk/constants.dart';
import 'package:fly_talk/layout/Cubit/social_states.dart';
import 'package:fly_talk/models/message_model.dart';
import 'package:fly_talk/models/post_model.dart';
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
  List<Widget> screensList =
  [
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


  var picker = ImagePicker();


  // Profile image Methods

  File? profileImage;
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

  Future<void> updateProfileImage ({
    required String image,
  })async{

    emit(SocialCreateProfileImageLoadingState());
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


  // Cover image Methods

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



  // Post Methods

  File? postImage;
  Future getPostImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      emit(SocialPostImagePickedSuccessfulState());
    } else {
      print("No Post Image Selected");
      emit(SocialPostImagePickedErrorState());
    }
  }

  String? postImageUrl;
  Future<void> uploadPostImage() async {

    emit(SocialCreateProfileImageLoadingState());
    if(postImage != null){
      await firebase_storage.FirebaseStorage.instance
          .ref()
          .child("Posts/${Uri.file(postImage!.path).pathSegments.last}")
          .putFile(postImage!)
          .then((value) {
        value.ref.getDownloadURL()
            .then((value) {
          postImageUrl = value;
          print("The url of post Image >>>>> $value");
          emit(SocialCreatePostImageSuccessfulState());
        })
            .catchError((error) {
          print(error.toString());
          emit(SocialCreatePostImageErrorState());
        });
      })
          .catchError((error) {
        print(error.toString());
        emit(SocialCreatePostImageErrorState());
      });
    }

  }


  void createPost({
    required context,
    String? dateTime,
    String? postImage,
    required String? postBody,

  }) async {
    PostModel postModel = PostModel(
        name: UserCubit.get(context).currentUser!.name,
      dateTime: DateTime.now().toString(),
        postImage: postImageUrl,
        uId: uId,
        postBody: postBody,
        );

    emit(SocialCreatePostLoadingState());


    FirebaseFirestore.instance
        .collection("posts")
        .add(postModel!.toMap())
        .then((value) {
      emit(SocialCreatePostSuccessfulState());
    }).catchError((error) {
      print(error.toString());
      emit(SocialCreatePostErrorState());
    });
  }

  void removePostImage (){
    postImage = null;
    emit(SocialRemovePostImageState());
  }

  List<PostModel> postsList =[];
  List<String> likesIdList =[];
  List<int> likesList =[];
  Future<void> getPosts() async {

    emit(SocialGetPostsLoadingState());

    await FirebaseFirestore.instance
        .collection("posts")
        .get()
        .then((value) {
      value.docs.forEach((element) {
        element.reference.collection("likes").get().then((value) {
          likesList.add(value.docs.length);
          likesIdList.add(element.id);
          postsList.add(PostModel.fromJson(element.data()));
        }).catchError((error) {});

        emit(SocialGetPostsSuccessfulState());
      });
    })
        .catchError((error){});
    emit(SocialGetPostsErrorState());
  }


  void likePost(String postId){

    FirebaseFirestore.instance
        .collection("posts")
        .doc(postId)
        .collection("likes")
        .doc(uId).set({"liked" : true})
        .then((value) {
      emit(SocialLikePostSuccessfulState());

    })
        .catchError((error){
      emit(SocialLikeErrorState());

    });
  }

  List<UserModel> allUsersList =[];
  Future<void> getAllUsers() async {
    emit(SocialGetAllUsersLoadingState());
    allUsersList =[];

    await FirebaseFirestore.instance
        .collection("users")
        .get()
        .then((value) {
      value.docs.forEach((element) {
        if(element.data()["uId"] != uId) {
          allUsersList.add(UserModel.fromJson(element.data()));
        }
      });


      emit(SocialGetAllUsersSuccessfulState());
    }).catchError((error) {
      emit(SocialGetAllUsersErrorState());
    });
  }

  Future<void> sendMessage (
  {
  required String receiverId,
  required String dateTime,
  required String message,
}
      ) async{

    MessageModel messageModel = MessageModel(
      senderId: uId ,
      receiverId: receiverId,
      dateTime: dateTime,
      message: message,
    );

    FirebaseFirestore.instance
        .collection("users")
        .doc(uId)
        .collection("chats")
        .doc(receiverId)
        .collection("messages")
        .add(messageModel.toMap())
        .then((value) {
          emit(SocialSendMessageSuccessfulState());
    })
        .catchError(() {
          emit(SocialSendMessageErrorState());
    });


    FirebaseFirestore.instance
        .collection("users")
        .doc(receiverId)
        .collection("chats")
        .doc(uId)
        .collection("messages")
        .add(messageModel.toMap())
        .then((value) {
          emit(SocialSendMessageSuccessfulState());
    })
        .catchError(() {
          emit(SocialSendMessageErrorState());
    });
  }

  List<MessageModel> messages =[];
  void getMessages ({
    required String receiverId,

  }) {


     FirebaseFirestore.instance
        .collection("users")
        .doc(uId)
        .collection("chats")
        .doc(receiverId)
        .collection("messages")
        .orderBy("dateTime")
        .snapshots()
        .listen((event) {

      messages.clear();

      event.docs.forEach((element) {

            messages.add(MessageModel.fromJson(element.data()));
            print(">>>>>>>>>>>>>>>>>>>>>>>>START");
            print(element.data()["dateTime"]);
          }

          );
      // messages.reversed;

          emit(SocialGetMessageSuccessfulState());
    });
  }




}
