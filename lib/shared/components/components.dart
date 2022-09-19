import 'package:flutter/material.dart';
import 'package:shop/styles/colors.dart';

void navigateTo(context,widget)
{
  Navigator.push(context, MaterialPageRoute(builder: (context)=>widget));
}

void navigateAndFinish(context,widget)
{
  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>widget), (route) => false);
}

Widget defaultTextFormField({
  required TextEditingController controller,
  required TextInputType type,
  Function? onSubmit,
  Function? onChange,
  GestureTapCallback? ontap, 
  required FormFieldValidator validate,
  required String label,
  required IconData prefix,
  bool isPassword = false,
  bool isClickable = true,
  IconData? suffix,
  Function? suffixPressed,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      onFieldSubmitted:(s){onSubmit!();} ,
      onChanged:(s) {onChange!();},
      enabled: isClickable,
      onTap: ontap,
      validator: validate,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(
          prefix,
        ),
        suffixIcon: suffix != null
            ? IconButton(
                onPressed: () {
                  suffixPressed!();
                },
                icon: Icon(
                  suffix,
                ),
              )
            : null,
        border: const OutlineInputBorder(),
      ),
    );



Widget defaultButton({
  double width = double.infinity,
  Color background =defaultColor,
  bool isUpperCase = true,
  double radius = 3.0,
  required Function function,
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
        onPressed: () {
          function();
        },
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20.0,
          ),
        ),
      ),
    ); 


Widget defaultTextButton({

  required Function ontap,
  required String text,

})
{
  return TextButton(onPressed: (){ontap;}, child: Text("$text"));

}       


