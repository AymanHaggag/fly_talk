import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fly_talk/layout/Cubit/social_states.dart';
import 'package:fly_talk/models/user_model.dart';
import 'package:fly_talk/widgets/componento.dart';

import '../../layout/Cubit/social_cubit.dart';
import '../login/cubit/user_cubet.dart';

class EditScreen extends StatelessWidget {
  EditScreen({Key? key}) : super(key: key);

  TextEditingController nameController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var currentUserData = UserCubit.get(context).currentUser;
    nameController.text = currentUserData!.name as String;
    bioController.text = currentUserData!.bio as String;
    phoneController.text = currentUserData!.phone as String;

    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {
        if (state is SocialUpdateUserLoadingState) {}
      },
      builder: (context, state) {
        var profileImage = SocialCubit.get(context).profileImage;
        var coverImage = SocialCubit.get(context).coverImage;
        var profileUrl = SocialCubit.get(context).profileImageUrl;
        var coverUrl = SocialCubit.get(context).coverImageUrl;
        return Scaffold(
          appBar: AppBar(
            title: Text("Edit"),
          ),
          body: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    // color: Theme.of(context).scaffoldBackgroundColor,
                    height: 300,
                    width: double.infinity,
                    child: Stack(
                      children: [
                        Image(
                          height: 220,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          image: coverImage == null
                              ? NetworkImage(
                                  currentUserData!.cover as String,
                                )
                              : FileImage(coverImage) as ImageProvider,
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Stack(
                            alignment: Alignment.bottomRight,
                            children: [
                              CircleAvatar(
                                radius: 77,
                                backgroundColor:
                                    Theme.of(context).scaffoldBackgroundColor,
                                child: CircleAvatar(
                                  radius: 75,
                                  backgroundImage: profileImage == null
                                      ? NetworkImage(
                                          currentUserData!.image as String)
                                      : FileImage(profileImage)
                                          as ImageProvider,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CircleAvatar(
                                  radius: 20,
                                  backgroundColor: Colors.blue,
                                  child: IconButton(
                                    onPressed: () async {
                                      await SocialCubit.get(context)
                                          .getProfileImage();
                                    },
                                    icon: Icon(
                                      Icons.camera_alt_outlined,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircleAvatar(
                              radius: 20,
                              backgroundColor: Colors.blue,
                              child: IconButton(
                                onPressed: () {
                                  SocialCubit.get(context).getCoverImage();
                                },
                                icon: Icon(
                                  Icons.camera_alt_outlined,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        defaultFormField(
                          controller: nameController,
                          prefix: Icons.manage_accounts,
                          type: TextInputType.text,
                          label: "Name",
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        defaultFormField(
                          controller: bioController,
                          prefix: Icons.short_text_outlined,
                          type: TextInputType.text,
                          label: "Bio",
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        defaultFormField(
                          controller: phoneController,
                          prefix: Icons.phone,
                          type: TextInputType.text,
                          label: "Phone",
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: double.infinity,
                          child: Column(
                            children: [
                              Container(
                                width: double.infinity,
                                child: OutlinedButton(
                                    onPressed: () async {
                                      await SocialCubit.get(context)
                                          .uploadCoverImage();
                                      await SocialCubit.get(context)
                                          .uploadProfileImage();
                                      await SocialCubit.get(context)
                                          .updateUserData(
                                        name: nameController.text,
                                        bio: bioController.text,
                                        phone: phoneController.text,
                                      );

                                      UserCubit.get(context)
                                          .getUserData()
                                          .then((value) {
                                        Navigator.pop(context);
                                      });

                                      // Navigator.pop(context);
                                    },
                                    child: Text("Update")),
                              ),
                              if (state is SocialUpdateUserLoadingState)
                                LinearProgressIndicator(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
