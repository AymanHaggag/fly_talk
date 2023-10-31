import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  var onSubmit,
  var onChange,
  var onTap,
  bool isPassword = false,
   var validate,
  required String label,
  String? hintText,
  IconData? prefix,
  IconData? suffix,
  var suffixPressed,
  bool isClickable = true,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      enabled: isClickable,
      onFieldSubmitted: onSubmit,
      onChanged: onChange,
      onTap: onTap,
      validator: validate,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(),
        labelText: label,
        labelStyle:  TextStyle(),
        prefixIcon: Icon(
          prefix,
        ),
        suffixIcon: suffix != null
            ? IconButton(
          onPressed: suffixPressed,
          icon: Icon(
            suffix,

          ),
        )
            : null,
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
          ),
        ),
        focusedBorder : OutlineInputBorder(
          borderSide: BorderSide(
          ), ),

      ),
    );


Widget defaultButton ({
  required String title,
  required var onPressed,
}) => Container(
    height: 45,
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
    width: double.infinity,
    child:   ElevatedButton(
      onPressed: onPressed,
      child: Text(title),
      style: ElevatedButton.styleFrom(
        shadowColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(13),

        ),

      ),
    )
);


enum ToastStates  {success , error , warning}

Color chooseToastColor (ToastStates state)
{
  Color backGroundColor;

  switch(state){
    case ToastStates.success :
      backGroundColor = Colors.green;
      break;
    case ToastStates.error :
      backGroundColor = Colors.red;
      break;
    case ToastStates.warning :
      backGroundColor = Colors.amberAccent;
      break;
  }
  return backGroundColor;
}

void showToast(String message , ToastStates state ){

  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: chooseToastColor(state),
      textColor: Colors.white,
      fontSize: 16.0);
}