import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
        //print('Home '+homemodel!.data!.banners[0].id.toString());
      }).catchError(
        (onError)
        {
          print(onError.toString());
          emit(ShopHomeErrorState(onError));
        });
  }
}