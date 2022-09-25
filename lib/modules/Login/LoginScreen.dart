import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop/models/LoginModel.dart';
import 'package:shop/modules/Layout/ShopHome.dart';
import 'package:shop/modules/Login/cubit/cubit.dart';
import 'package:shop/modules/Login/cubit/states.dart';
import 'package:shop/modules/Register/RegisterScreen.dart';
import 'package:shop/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:shop/shared/network/local/cache_helper.dart';
import 'package:tbib_toast/tbib_toast.dart';

class LoginScreen extends StatelessWidget {
  var FormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var EmailController = TextEditingController();
    var PasswordController = TextEditingController();

    return BlocProvider(
      create: (context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit, ShopLoginStates>(
          builder: (context, state) {
        return Scaffold(
            appBar: AppBar(),
            body: Center(
                child: SingleChildScrollView(
              child: Center(
                  child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Form(
                        key: FormKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Login",
                              style: TextStyle(
                                  fontFamily: 'Cairo-Black', fontSize: 40),
                            ),
                            Text(
                              "Login now to browse our hot offers",
                              style: TextStyle(
                                  fontFamily: 'Cairo-Black',
                                  fontSize: 20,
                                  color: Colors.grey),
                            ),
                            SizedBox(height: 30),
                            defaultTextFormField(
                                controller: EmailController,
                                type: TextInputType.emailAddress,
                                validate: (val) {
                                  if (val.isEmpty) {
                                    return "Please enter your E-mail.";
                                  }
                                },
                                label: "Email",
                                prefix: Icons.email),
                            SizedBox(height: 10),
                            defaultTextFormField(
                                controller: PasswordController,
                                type: TextInputType.visiblePassword,
                                validate: (val) {
                                  if (val.isEmpty) {
                                    return "Please enter your password.";
                                  }
                                },
                                onSubmit: () {
                                  if (FormKey.currentState!.validate()) {
                                    ShopLoginCubit.get(context).UserLogin(
                                        email: EmailController.text,
                                        password: PasswordController.text);
                                  }
                                },
                                label: "Password",
                                prefix: Icons.lock_outline,
                                suffix: ShopLoginCubit.get(context).suffix,
                                isPassword:
                                    ShopLoginCubit.get(context).isPassword,
                                suffixPressed: () {
                                  ShopLoginCubit.get(context).changeSuffix();
                                }),
                            SizedBox(height: 20),
                            ConditionalBuilder(
                                condition: state is! ShoploginLoadingState,
                                builder: (context) => defaultButton(
                                    function: () {
                                      if (FormKey.currentState!.validate()) {
                                        ShopLoginCubit.get(context).UserLogin(
                                            email: EmailController.text,
                                            password: PasswordController.text);
                                      }
                                    },
                                    text: "Login"),
                                fallback: (context) => Center(
                                      child: CircularProgressIndicator(),
                                    )),
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Don/'t have an account?"),
                                TextButton(
                                    onPressed: () {
                                      navigateTo(context, RegisterScreen());
                                    },
                                    child: Text("Register now!"))
                              ],
                            ),
                          ],
                        ),
                      ))),
            )));
      }, listener: (context, state) {
        if (state is ShopLoginSuccessState) {
          if (state.loginmodel.status!) {

            showToast(
                text: state.loginmodel.message.toString(), state: ToastState.SUCCESS);

            CacheHelper.SaveData(key: 'token', value: state.loginmodel.data?.token).then((value) => navigateAndFinish(context, ShopHome()));    

          } else {
            showToast(
                text: state.loginmodel.message.toString(), state: ToastState.ERROR);
                CacheHelper.SaveData(key: 'token', value: state.loginmodel.data?.token).then((value) => navigateAndFinish(context, ShopHome())); 
          }
        }
      }),
    );
    throw UnimplementedError();
  }
}
