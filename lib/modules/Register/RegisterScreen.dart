import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/modules/Login/cubit/cubit.dart';
import 'package:shop/modules/Login/cubit/states.dart';
import 'package:shop/modules/Register/cubit/cubit.dart';
import 'package:shop/modules/Register/cubit/states.dart';

import '../../shared/components/components.dart';
import '../../shared/components/constants.dart';
import '../../shared/network/local/cache_helper.dart';
import '../Layout/HomeScreen.dart';

class RegisterScreen extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    var FormKey = GlobalKey<FormState>();
    var EmailController = TextEditingController();
    var PasswordController = TextEditingController();
    var NameController=TextEditingController();
    var PhoneController=TextEditingController();

    return BlocProvider(create: (context) =>ShopRegisterCubit(),
    child: BlocConsumer<ShopRegisterCubit,ShopRegisterStates>(
      builder: (context,state){
        var cubit=ShopRegisterCubit.get(context);
        return Scaffold(
      appBar: AppBar(),
      body:Center(
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
                              "REGISTER",
                              style: TextStyle(
                                  fontFamily: 'Cairo-Black', fontSize: 40),
                            ),
                            Text(
                              "Register now to browse our hot offers",
                              style: TextStyle(
                                  fontFamily: 'Cairo-Black',
                                  fontSize: 20,
                                  color: Colors.grey),
                            ),
                            SizedBox(height: 30),
                            defaultTextFormField(
                                controller: NameController,
                                type: TextInputType.name,
                                validate: (val) {
                                  if (val.isEmpty) {
                                    return "Please enter your name.";
                                  }
                                },
                                label: "User name",
                                prefix: Icons.person),

                                  
                            
      
                                SizedBox(height: 10),
                            defaultTextFormField(
                                controller: EmailController,
                                type: TextInputType.emailAddress,
                                validate: (val) {
                                  if (val.isEmpty) {
                                    return "Please enter your email.";
                                  }
                                },
                                label: "Email",
                                prefix: Icons.email),

                                     SizedBox(height: 10),
                            defaultTextFormField(
                                controller: PhoneController,
                                type: TextInputType.phone,
                                validate: (val) {
                                  if (val.isEmpty) {
                                    return "Please enter your phone.";
                                  }
                                },
                                label: "Phone number",
                                prefix: Icons.phone),

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
                                    cubit.UserRegister(
                                        phone:PhoneController.text,
                                        name:NameController.text,
                                        email: EmailController.text,
                                        password: PasswordController.text);
                                  }
                                },
                                label: "Password",
                                prefix: Icons.lock_outline,
                                suffix: cubit.suffix,
                                isPassword:
                                    cubit.isPassword,
                                suffixPressed: () {
                                  cubit.changeSuffix();
                                }),
                            SizedBox(height: 20),
                            ConditionalBuilder(
                                condition: state is !ShopRegisterLoadingState,
                                builder: (context) => defaultButton(
                                    function: () {
                                      if (FormKey.currentState!.validate()) {
                                        ShopRegisterCubit.get(context).UserRegister(
                                            name:NameController.text,
                                            email: EmailController.text,
                                            password: PasswordController.text,
                                            phone: PhoneController.text

                                            );
                                      }
                                    },
                                    text: "Register"),
                                fallback: (context) => Center(
                                      child: CircularProgressIndicator(),
                                    )),
                            SizedBox(height: 10),
                            
                          ],
                        ),
                      ))),
            ))
    );
      }, listener: (context,state)
      {
        if (state is ShopRegisterSuccessState) {
          if (state.loginmodel.status!) {

            showToast(
                text: state.loginmodel.message.toString(), state: ToastState.SUCCESS);

            CacheHelper.SaveData(key: 'token', value: state.loginmodel.data?.token).then((value) => navigateAndFinish(context, HomeScreen()));    

          } else {
            showToast(
                text: state.loginmodel.message.toString(), state: ToastState.ERROR);
                CacheHelper.SaveData(
                  key: 'token',
                   value: state.loginmodel.data?.token).then((value) 
                   {
                    token=state.loginmodel.data!.token!;
                    navigateAndFinish(context, HomeScreen());}); 
          }
        }
      }), );
    throw UnimplementedError();
  }

}