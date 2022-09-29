import 'package:shop/models/LoginModel.dart';

abstract class ShopRegisterStates{}

class ShopRegisterInitialState extends ShopRegisterStates{}
class ShopRegisterLoadingState extends ShopRegisterStates{}
class ShopRegisterSuccessState extends ShopRegisterStates
{
  LoginModel loginmodel;
  ShopRegisterSuccessState(this.loginmodel);
}

class ShopRegisterErrorState extends ShopRegisterStates
{
  String err;
  ShopRegisterErrorState(this.err);
}




class ShopRegisterChangePasswordVisibility extends ShopRegisterStates{}