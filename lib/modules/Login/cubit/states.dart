import 'package:shop/models/LoginModel.dart';

abstract class ShopLoginStates{}

class ShopLoginInitialState extends ShopLoginStates{}

class ShoploginLoadingState extends ShopLoginStates{}

class ShopLoginSuccessState extends ShopLoginStates
{
  LoginModel loginmodel;
  ShopLoginSuccessState(this.loginmodel);
}

class ShopLoginErrorState extends ShopLoginStates
{
  String err;
  ShopLoginErrorState(this.err);
}

class ShopLoginChangePasswordVisibility extends ShopLoginStates{}