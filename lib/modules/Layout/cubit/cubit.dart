import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/models/CategoriesModel.dart';
import 'package:shop/models/ChangeFavoritesModel.dart';
import 'package:shop/models/FavoritesModel.dart';
import 'package:shop/models/HomeModel.dart';
import 'package:shop/models/LoginModel.dart';
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
   ChangeFavoritesModel? changeFavoritesModel;
     FavoritesModel? favoritesModel;
 

  Map<int , bool> favorites ={};

  List<Widget>BottomScreens=[ProductsScreen(),CategoriesScreen(),FavouritesScreen(),SettingsScreen()];

  void ChangeBottomNavBar(int index)
  {
    CurrentIndex=index;
    emit(ShopChangeNavBarState());
  }

  void GetHomeData()
  {
    emit(ShopHomeLoadingState());

    DioHelper.getData(url: HOME, token: token).then(
      (value) 
      {
        emit(ShopHomeSuccessState());
        homemodel = HomeModel.fromJson(value.data);

        homemodel!.data!.products.forEach((element)
        {
          favorites.addAll({element.id!:element.in_favorites!});
          
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

    DioHelper.getData(url: GET_CATEGORIES, token: token).then(
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


 

  void changeFavorites(int productId){
    if(favorites[productId] == true) {
      favorites[productId] = false;
    }else{
      favorites[productId] = true;
    }
    emit(ShopChangeFavoritesState());
    DioHelper.postData(url: FAVORITES,

        data: {
      'product_id' : productId,
        },
        token: token
    ).then((value) {
      changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);
    //  print(value.data);
            getFavorites();


      if(changeFavoritesModel!.status == false){
        if(favorites[productId] == true) {
          favorites[productId] = false;
        }else{
          favorites[productId] = true;
        }
      }else{
        getFavorites();
      }
      emit(ShopChangeFavoritesSuccessState(changeFavoritesModel!));
    }).catchError((error){
      print(error.toString());
      if(favorites[productId] == true) {
        favorites[productId] = false;
      }else{
        favorites[productId] = true;
      }
      emit(ShopChangeFavoritesErrorState());
    });
  }




  void getFavorites(){

    emit(ShopHomeGetFavoritesLoadingState());
    DioHelper.getData(
      url: FAVORITES,
      token: token
    ).then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);
      print(favoritesModel);
      print(value.data);
      emit(ShopHomeGetFavoritesSuccessState(favoritesModel!));
    }).catchError((error){
      print(error.toString());
      emit(ShopHomeGetFavoritesErrorState());
    });
  }


  LoginModel? loginModel;

    void getUserData(){

    emit(ShopGetUserDataLoadingState());
    DioHelper.getData(
      url: PROFILE,
      token: token
    ).then((value) {
      loginModel = LoginModel.fromJson(value.data);
      print(value.data);
      emit(ShopGetUserDataSuccessState(loginModel!));
    }).catchError((error){
      print(error.toString());
      emit(ShopGetUserDataErrorState());
    });
  }

  void updateUserData(
    {
      required String name,
      required String email,
      required String phone
    }
  ){

    emit(ShopUpdateLoadingState());
    DioHelper.putData(
      url: UPDATE_PROFILE,
      data: {
        'name':name,
        'email':email,
        'phone':phone
      },
      token: token
    ).then((value) {
      loginModel = LoginModel.fromJson(value.data);
      print(value.data);
      emit(ShopUpdateSuccessState(loginModel!));
    }).catchError((error){
      print(error.toString());
      emit(ShopUpdateErrorState(error));

    });
  }


}