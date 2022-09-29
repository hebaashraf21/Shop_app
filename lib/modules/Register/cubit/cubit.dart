import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/models/LoginModel.dart';
import 'package:shop/modules/Register/cubit/states.dart';
import 'package:shop/shared/network/local/cache_helper.dart';
import 'package:shop/shared/network/remote/dio_helper.dart';
import '../../../shared/network/end_points.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterStates>
{
  ShopRegisterCubit():super(ShopRegisterInitialState());

  static ShopRegisterCubit get(context)=>BlocProvider.of(context);

  IconData suffix=Icons.remove_red_eye_outlined;
  bool isPassword=true;
  LoginModel? loginmodel;

  void changeSuffix()
  {
    isPassword=!isPassword;
    suffix=(isPassword)?Icons.visibility_outlined:Icons.visibility_off_outlined;
    emit(ShopRegisterChangePasswordVisibility());
  }
  

  void UserRegister({
    required String email,
    required String password,
    required String name,
    required String phone
  })
  {
    emit(ShopRegisterLoadingState());
    DioHelper.postData(
      url: REGISTER,
      data: {
        'name':name,
        'email':email,
        'password':password,
        'phone':phone
      }).then((value) {
        loginmodel=LoginModel.fromJson(value.data);
          CacheHelper.SaveData(key: 'token', value: loginmodel!.data!.token);

        // print(loginmodel!.message);
        // print(loginmodel!.status);
        // print(loginmodel!.data!.email);
        //print(value.data['message']);
        emit(ShopRegisterSuccessState(loginmodel!));
      }).catchError((onError){
        emit(ShopRegisterErrorState(onError.toString()));
      });
  }


}