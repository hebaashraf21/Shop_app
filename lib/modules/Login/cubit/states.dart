abstract class ShopLoginStates{}

class ShopLoginInitialState extends ShopLoginStates{}

class ShoploginLoadingState extends ShopLoginStates{}

class ShopLoginSuccessState extends ShopLoginStates{}

class ShopLoginErrorState extends ShopLoginStates
{
  String err;
  ShopLoginErrorState(this.err);
}

class ShopLoginChangePasswordVisibility extends ShopLoginStates{}