import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fly_talk/layout/Cubit/social_cubit.dart';
import 'package:fly_talk/layout/Cubit/social_states.dart';
import 'package:fly_talk/modules/login/cubit/user_cubet.dart';
import 'package:fly_talk/modules/login/cubit/user_states.dart';
import 'package:fly_talk/modules/login/login_screen.dart';
import 'package:fly_talk/services/cash_helper.dart';

import 'bloc_observer.dart';
import 'constants.dart';
import 'layout/social_layout.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp().whenComplete(() => (){print(">>>>>Completed");});
  Bloc.observer = MyBlocObserver();
  await CacheHelper.init();
  uId = await CacheHelper.getData(key: "uId");
  print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> uId = $uId");
  Widget openingScreen = LoginScreen();
  if (uId != null){
    openingScreen = SocialLayoutScreen();
  }

  runApp( MyApp(openingScreen: openingScreen,));

}

class MyApp extends StatelessWidget {
   MyApp({required this.openingScreen ,super.key});
 Widget openingScreen;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context)  {
    return MultiBlocProvider(
  providers: [
    BlocProvider(
      create: (context) =>  UserCubit(UserInitialState())..getUserData(),
),
    BlocProvider(
      create: (context) => SocialCubit(SocialInitialState()),
    ),
  ],
  child: BlocConsumer<UserCubit, UserStates>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return MaterialApp(
            theme: ThemeData(
              // This is the theme of your application.
              //
              // TRY THIS: Try running your application with "flutter run". You'll see
              // the application has a blue toolbar. Then, without quitting the app,
              // try changing the seedColor in the colorScheme below to Colors.green
              // and then invoke "hot reload" (save your changes or press the "hot
              // reload" button in a Flutter-supported IDE, or press "r" if you used
              // the command line to start the app).
              //
              // Notice that the counter didn't reset back to zero; the application
              // state is not lost during the reload. To reset the state, use hot
              // restart instead.
              //
              // This works for code too, not just values: Most code changes can be
              // tested with just a hot reload.
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
            home: openingScreen,
          );
        },
      ),
);
  }
}


