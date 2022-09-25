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


class ShopHomeCategoriesSuccessState extends ShopStates{}

class ShopHomeCategoriesErrorState extends ShopStates{}

class ShopChangeFavoritesSuccessState extends ShopStates{}

class ShopChangeFavoritesErrorState extends ShopStates{}
