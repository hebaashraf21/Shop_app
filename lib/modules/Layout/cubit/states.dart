import 'package:shop/models/ChangeFavoritesModel.dart';
import 'package:shop/models/LoginModel.dart';

import '../../../models/FavoritesModel.dart';

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

class ShopChangeFavoritesState extends ShopStates{}

class ShopChangeFavoritesSuccessState extends ShopStates
{
  final ChangeFavoritesModel model;
  ShopChangeFavoritesSuccessState(this.model);
}

class ShopChangeFavoritesErrorState extends ShopStates{}

class ShopHomeGetFavoritesLoadingState extends ShopStates{}

class ShopHomeGetFavoritesSuccessState extends ShopStates{
    final FavoritesModel model;
  ShopHomeGetFavoritesSuccessState(this.model);
}

class ShopHomeGetFavoritesErrorState extends ShopStates{}

class ShopGetUserDataLoadingState extends ShopStates{}

class ShopGetUserDataSuccessState extends ShopStates
{
  LoginModel model;
  ShopGetUserDataSuccessState(this.model);
}

class ShopGetUserDataErrorState extends ShopStates{}

class ShopUpdateLoadingState extends ShopStates{}
class ShopUpdateSuccessState extends ShopStates
{
  LoginModel loginmodel;
  ShopUpdateSuccessState(this.loginmodel);
}

class ShopUpdateErrorState extends ShopStates
{
  String err;
  ShopUpdateErrorState(this.err);
}
