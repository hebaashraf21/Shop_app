abstract class ShopStates{}

class ShopInitialState extends ShopStates{}

class ShopChangeNavBarState extends ShopStates{}

class ShopHomeLoadingState extends ShopStates{}

class ShopHomeSuccessState extends ShopStates
{

}

class ShopHomeErrorState extends ShopStates
{
  String err;
  ShopHomeErrorState(this.err);
}

