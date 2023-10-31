import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fly_talk/layout/social_layout.dart';

import '../../widgets/componento.dart';
import '../registeration/register_screen.dart';
import 'cubit/user_cubet.dart';
import 'cubit/user_states.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  bool hidePassword = true;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserStates>(
      listener: (context, state) {
        if (state is UserLoginSuccessfulState) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => SocialLayoutScreen()),
              (route) => false);
        }
      },
      builder: (context, state) {
        return Scaffold(
            body: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 200,
                  ),
                  const Text(
                    'Hello Again!',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Fill Your Details To Connect To The World',
                    style: TextStyle(fontSize: 15),
                  ),
                  const SizedBox(
                    height: 85,
                  ),
                  defaultFormField(
                    controller: emailController,
                    type: TextInputType.text,
                    hintText: 'xyz@gmail.com',
                    validate: (var value) {
                      if (value.isEmpty) {
                        return 'Please enter your email';
                      }
                    },
                    label: "Email Address",
                    prefix: Icons.email,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  defaultFormField(
                    isPassword: UserCubit.get(context).hidePass,
                    controller: passwordController,
                    type: TextInputType.text,
                    validate: (var value) {
                      if (value.isEmpty) {
                        return 'Please enter your password';
                      }
                    },
                    label: "Password",
                    prefix: Icons.lock_outline,
                    suffix: UserCubit.get(context).suffixIcon,
                    suffixPressed: () {
                      UserCubit.get(context).hidePassword();
                    },
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Spacer(),
                      TextButton(
                        onPressed: () {},
                        child: Text("Recovery Password"),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  ConditionalBuilder(
                      condition: state is! UserLoadingState,
                      builder: (context) => Container(
                            height: 45,
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                 /* if (FirebaseAuth.instance.currentUser!.emailVerified == false)
                                  {
                                    AwesomeDialog(context: context,
                                    dialogType: DialogType.warning,
                                    animType: AnimType.topSlide,
                                    showCloseIcon: true,
                                    title: " Verify" ,
                                    desc: "You Need to verify your Mail First",
                                    btnOkText: "Verify",
                                    btnOkOnPress: (){
                                      FirebaseAuth.instance.currentUser!
                                          .sendEmailVerification()
                                          .then((value) {
                                        showToast("Check Your Email", ToastStates.success);

                                          SocialCubit.get(context).getUserData();
                                        });
                                      });



                                  }*/
                                  UserCubit.get(context).login(
                                    email: emailController.text,
                                    password: passwordController.text,
                                  );


                                  // CacheHelper.saveData(key: "onboarding", value: true);
                                }
                                // debugPrint(UserCubit.get(context).userModel!.data!.token);
                              },
                              child: Text('Login'),
                              style: ElevatedButton.styleFrom(
                                shadowColor: Colors.black,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(13),
                                ),
                              ),
                            ),
                          ),
                      fallback: (context) =>
                          const Center(child: CircularProgressIndicator())),
                  SizedBox(
                    height: 170,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'New User? ',
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RegisterScreen()),
                          );
                        },
                        child: Text(
                          'Create Account',
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
      },
    );
  }
}
