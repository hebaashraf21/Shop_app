import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/models/CategoriesModel.dart';
import 'package:shop/models/HomeModel.dart';
import 'package:shop/modules/Layout/cubit/states.dart';
import 'package:shop/modules/categories/CategoriesScreen.dart';
import 'package:shop/modules/favourites/FavouritesScreen.dart';
import 'package:shop/modules/products/ProductsScreen.dart';
import 'package:shop/modules/settings/SettingsScreen.dart';
import 'package:shop/shared/components/components.dart';
import 'package:shop/shared/components/constants.dart';
import 'package:shop/shared/network/remote/dio_helper.dart';

import '../../../shared/network/end_points.dart';

class ShopCubit extends Cubit<ShopStates>
{
  ShopCubit():super(ShopInitialState());

  static ShopCubit get(context)=>BlocProvider.of(context);

  int CurrentIndex=0;

  HomeModel? homemodel;
  CategoriesModel? categoriesmodel;

  Map<int,bool>?isfavorite={};

  List<Widget>BottomScreens=[ProductsScreen(),CategoriesScreen(),FavouritesScreen(),SettingsScreen()];

  void ChangeBottomNavBar(int index)
  {
    CurrentIndex=index;
    emit(ShopChangeNavBarState());
  }

  void GetHomeData()
  {
    emit(ShopHomeLoadingState());

    DioHelper.getdata(url: HOME, token: token).then(
      (value) 
      {
        emit(ShopHomeSuccessState());
        homemodel = HomeModel.fromJson(value.data);

        homemodel!.data!.products.forEach((element)
        {
          isfavorite!.addAll({element.id!:element.in_favorites!});
          
        });

        //print(isfavorite);
        //print('Home '+homemodel!.data!.banners[0].id.toString());
      }).catchError(
        (onError)
        {
          print(onError.toString());
          emit(ShopHomeErrorState(onError));
        });
  }

  void GetCategoriesData()
  {
    emit(ShopHomeLoadingState());

    DioHelper.getdata(url: GET_CATEGORIES, token: token).then(
      (value) 
      {
        emit(ShopHomeCategoriesSuccessState());
        categoriesmodel = CategoriesModel.fromJson(value.data);
        //print('Home '+homemodel!.data!.banners[0].id.toString());
      }).catchError(
        (onError)
        {
          print(onError.toString());
          emit(ShopHomeCategoriesErrorState());
        });
  }


  void GetFavoritesData(int ProductId)
  {
    DioHelper.postdata(
      url: FAVORITES,
       data: {
        'product_id':ProductId
       },
       token: token).then((value) {
        emit(ShopChangeFavoritesSuccessState());
       }).catchError((onError){
        emit(ShopChangeFavoritesErrorState());
       });

  }
}