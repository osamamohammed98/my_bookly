import 'package:bloc_basic/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

Widget defaultButton({
  double width = double.infinity,
  Color background = defaultColor,
  bool isUpperCase = true,
  double radius = 3.0,
  required Function() function,
  required String text,
}) =>
    Container(
      width: width,
      height: 50.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          radius,
        ),
        color: background,
      ),
      child: MaterialButton(
        onPressed: function,
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );

Widget defaultTextButton({required Function() onPress, required String txt}) =>
    TextButton(onPressed: onPress, child: Text(txt));

Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  Function(String)? onSubmit,
  Function(String)? onChange,
  Function()? onTap,
  bool isPassword = false,
  required Function(String) validate,
  required String label,
  required IconData prefix,
  IconData? suffix,
  Function()? suffixPressed,
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
      validator: (v) => validate(v.toString()),
      decoration: InputDecoration(
        labelText: label,
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
        border: const OutlineInputBorder(),
      ),
    );

void navigateTo(context, widget) => Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => widget,
  ),
);

void navigateAndFinish(
    context,
    widget,
    ) =>
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
          (route) {
        return false;
      },
    );

void successToast(String? message) {
  Fluttertoast.showToast(
      msg: message.toString(),
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: Colors.green,
      textColor: Colors.white,
      fontSize: 16.0);
}

void errorToast(String? message) {
  Fluttertoast.showToast(
      msg: message.toString(),
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0);
}

Widget myDivider() => Padding(
  padding: const EdgeInsetsDirectional.only(
    start: 20.0,
  ),
  child: Container(
    width: double.infinity,
    height: 1.0,
    color: Colors.grey[300],
  ),
);

