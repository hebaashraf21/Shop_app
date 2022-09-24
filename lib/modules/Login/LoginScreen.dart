import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop/modules/Register/RegisterScreen.dart';
import 'package:shop/shared/components/components.dart';

class LoginScreen extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {

    var EmailController=TextEditingController();
    var PasswordController=TextEditingController();


    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: SingleChildScrollView(
        child: Center(
          child: Padding(padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Login",style: TextStyle(fontFamily: 'Cairo-Black',fontSize: 40),),
          Text("Login now to browse our hot offers",style: TextStyle(fontFamily: 'Cairo-Black',fontSize: 20,color: Colors.grey),),
          SizedBox(height:30),
          defaultTextFormField(
            controller: EmailController,
             type: TextInputType.emailAddress,
              validate: (val){
                if(val.isEmpty)
                {
                  return "Please enter your E-mail.";
                }
              },
               label: "Email",
                prefix: Icons.email),

                SizedBox(height:10),

                defaultTextFormField(
                  controller: EmailController,
                   type: TextInputType.visiblePassword,
                    validate: (val){
                      if(val.isEmpty)
                      {
                        return "Please enter your password.";
                      }
                    },
                     label: "Password",
                      prefix: Icons.lock_outline,
                      suffix: Icons.remove_red_eye_outlined,
                      suffixPressed: (){}),

                      SizedBox(height:20),

                      defaultButton(function: (){}, text: "Login"),

                      SizedBox(height:10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Don/'t have an account?"),
                          TextButton(onPressed: (){navigateTo(context,RegisterScreen());}, child: Text("Register now!"))
                        ],
                      ),
        ],
      ),
      )
        ),
      )
      )
    );
    throw UnimplementedError();
  }

}