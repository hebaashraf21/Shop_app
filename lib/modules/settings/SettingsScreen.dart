import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/modules/Layout/cubit/cubit.dart';
import 'package:shop/modules/Layout/cubit/states.dart';
import 'package:shop/shared/components/components.dart';

class SettingsScreen extends StatelessWidget
{
  var formKey=GlobalKey<FormState>();
  var nameController=TextEditingController();
  var emailController=TextEditingController();
  var phoneController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      builder: (context,state){
        // var model=ShopCubit.get(context).loginModel;
        //   nameController.text=model!.data!.name!;
        //   emailController.text=model!.data!.email!;
        //   phoneController.text=model!.data!.phone!;
        
        return ConditionalBuilder(
          condition:ShopCubit.get(context).loginModel!=null ,
           builder: (context){
            return Padding(padding: EdgeInsets.all(20),
    child: Form(
      key: formKey,
      child: Column
    (
      children: [
        if(state is ShopUpdateLoadingState)
        LinearProgressIndicator(),
        SizedBox(height:25),
        defaultTextFormField(
          controller: nameController,
          type: TextInputType.text,
          validate: (value)
          {
            if(value.isEmpty)
            {
              return 'Please enter your name';
            }

          },
          label: 'Name',
          prefix: Icons.person),

          SizedBox(height:15),

          defaultTextFormField(
          controller: emailController,
          type: TextInputType.emailAddress,
          validate: (value)
          {
            if(value.isEmpty)
            {
              return 'Please enter your e-mail';
            }

          },
          label: 'Email',
          prefix: Icons.email),

           SizedBox(height:15),

          defaultTextFormField(
          controller: phoneController,
          type: TextInputType.text,
          validate: (value)
          {
            if(value.isEmpty)
            {
              return 'Please enter your phone number';
            }

          },
          label: 'Phone',
          prefix: Icons.phone),

          SizedBox(height:20),

          
          defaultButton(
            function: (){
              if(formKey.currentState!.validate())
              {
                ShopCubit.get(context).updateUserData(name: nameController.text, email: emailController.text, phone: phoneController.text);
              }
            }, text: 'UPDATE'),

            SizedBox(height:20),

          defaultButton(
            function: (){
              SignOut(context);
            }, text: 'LOGOUT')
      ],

    ),));
           }, fallback: (context)=>CircularProgressIndicator());
      },
       listener: (context,state){
        if(state is ShopGetUserDataSuccessState)
        {
          // print(state.model.data!.name!);
          // nameController.text=state.model.data!.name!;
          // emailController.text=state.model.data!.email!;
          // phoneController.text=state.model.data!.phone!;


        }
       });
    throw UnimplementedError();
  }

}