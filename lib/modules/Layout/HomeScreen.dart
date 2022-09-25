import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/modules/Layout/cubit/cubit.dart';
import 'package:shop/modules/Layout/cubit/states.dart';
import 'package:shop/modules/Login/LoginScreen.dart';
import 'package:shop/modules/search/SearchScreen.dart';
import 'package:shop/shared/components/components.dart';
import 'package:shop/shared/network/local/cache_helper.dart';

class HomeScreen extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      builder: (context,state)
      {
        var cubit=ShopCubit.get(context);

        return Scaffold(
      appBar: AppBar(
        title: Text("Salla"),
        actions: [
          IconButton(icon: Icon(Icons.search),onPressed: (){navigateTo(context, SearchScreen());},)
        ],
      ),
      body: cubit.BottomScreens[cubit.CurrentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) {
          cubit.ChangeBottomNavBar(value);
        },
        currentIndex: cubit.CurrentIndex,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home),label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.category),label: "Categories"),
          BottomNavigationBarItem(icon: Icon(Icons.favorite),label: "Favourites"),
          BottomNavigationBarItem(icon: Icon(Icons.settings),label: "Settings"),
        ],
      ),
    );
      }, listener: (context,state){});
    throw UnimplementedError();
  }

}